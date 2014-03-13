# generic code for modules packages
# (c) Eduard Bloch <blade@debian.org>, 2003..2007
# 
# to be sourced by rules files
#
# needed vars: 
# PACKAGE (eg. "bcm4567-module")
# fixme optional var:
# fixme DIRDEPTH (empty or "../" chain for each level that needs to be
# ascended if the Debian dir is in subdirectories
#
# Some parts ripped from:
# alsa-source:
# Written by Steve Kowalik <stevenk@debian.org> for the New Alsa-Source.
# Loosely based on the rules file from pcmcia-cs and the old alsa-source.

ifeq ($(KSRC),)
KSRC = /usr/src/linux
endif

ifeq ($(KVERS),)
KVERS = unknown
endif

package = $(PACKAGE)

PKGARCH = $(shell dpkg --print-architecture)

ifeq ($(ARCH),)
SPARCH=$(shell grep 'CONFIG_SPARC..=y' "$(KSRC)/.config" 2>/dev/null| cut -d= -f1)
#maybe a different ARCH on sparc
ifeq (CONFIG_SPARC32,$(SPARCH))
ARCH :=sparc
export ARCH
endif
ifeq (CONFIG_SPARC64,$(SPARCH))
ARCH :=sparc64
export ARCH
endif
endif

# See if we can work out the compiler used
ifeq ($(origin CC),default)
ifneq "$(wildcard $(KSRC)/include/linux/compile.h)" ""
CC = gcc-$(shell grep LINUX_COMPILER $(KSRC)/include/linux/compile.h | sed 's/.* \([0-9]\+\.[0-9]\+\).*/\1/')
else
CC = gcc
endif
endif

# Special case gcc 2.7.2
ifeq ($(CC),gcc-2.7)
CC = gcc272
endif
export CC

PATH :=/usr/share/modass/$(CC):$(PATH)
export PATH

ifneq (,$(findstring noopt,$(DEB_BUILD_OPTIONS)))
	CFLAGS += -O0
else
	CFLAGS += -O2
endif
ifeq (,$(findstring nostrip,$(DEB_BUILD_OPTIONS)))
	INSTALL_PROGRAM += -s
endif


# If they didn't set $(KVERS), see if we can do it for them.
ifeq ($(KVERS),unknown)

ifneq "$(wildcard $(KSRC)/include/linux/utsrelease.h)" ""
KVERS = $(shell head -1 $(KSRC)/include/linux/utsrelease.h | sed 's/.*"\(.*\)"$$/\1/')
else
ifneq "$(wildcard $(KSRC)/include/linux/version.h)" ""
KVERS = $(shell head -1 $(KSRC)/include/linux/version.h | sed 's/.*"\(.*\)"$$/\1/')
else
# the last resort, version hocus pocus
#
# do we have unconfigured kernel source?

kversion :=$(shell egrep '^VERSION +=' $(KSRC)/Makefile 2>/dev/null | \
                 sed -e 's/[^0-9]*\([0-9]*\)/\1/')
kplevel  :=$(shell egrep '^PATCHLEVEL +=' $(KSRC)/Makefile 2>/dev/null | \
                    sed -e 's/[^0-9]*\([0-9]*\)/\1/')
ksublevel:=$(shell egrep '^SUBLEVEL +=' $(KSRC)/Makefile 2>/dev/null | \
                  sed -e 's/[^0-9]*\([0-9]*\)/\1/')
EXTRA_VERSION:=$(shell egrep '^EXTRAVERSION +=' $(KSRC)/Makefile 2>/dev/null | \
                 sed -e 's/EXTRAVERSION[\t ]*=[\t ]*\(.*\)/\1/')
kextra:=$(strip $(EXTRA_VERSION))
HAVE_NEW_MODLIB:=$(shell egrep '\(INSTALL_MOD_PATH\)' \
                            $(KSRC)/Makefile 2>/dev/null )

# If you want to have more than one kernel configuration per kernel
# version, set FLAVOUR in the top level kernel Makefile *before*
# invoking make-kpkg -- it will be appended to UTS_RELEASE in
# version.h (separated by a hyphen). This affects everything -- the
# names and versions of the image, source, headers, and doc packages,
# and where the modules are searched for in /lib/modules.

FLAVOUR:=$(shell grep ^FLAVOUR $(KSRC)/Makefile 2>/dev/null | \
                  perl -ple 's/FLAVOUR[\s:=]+//g')

ifneq ($(strip $(FLAVOUR)),)
INT_FLAV := -$(FLAVOUR)
FLAV_ARG := FLAVOUR=$(FLAVOUR)
else
INT_FLAV :=
FLAV_ARG :=
endif

## This is the replacement for FLAVOUR
ifneq ($(strip $(APPEND_TO_VERSION)),)
iatv := $(strip $(APPEND_TO_VERSION))
EXTRAV_ARG := EXTRAVERSION=${EXTRA_VERSION}${iatv}
else
iatv :=
EXTRAV_ARG :=
endif

KVERS = $(kversion).$(kplevel).$(ksublevel)$(kextra)$(iatv)$(INT_FLAV)

endif
endif
endif

# end of hocus pocus
#
# workarounds for possible misdetected things:

ifeq ($(KVERS),..)
KVERS=unknown
endif

# Clear root command if already root
ifeq ($(shell id -u),0)
ROOT_CMD=
endif

ifneq ($(CONCURRENCY_LEVEL),)
MAKE_OPT += -j $(CONCURRENCY_LEVEL)
endif

VERSION ?= $(shell dpkg-parsechangelog | grep ^Vers | cut -d\  -f2)

# remove the epoch number and append later
ifeq ($(findstring :,$(VERSION)),:)
VERSIONEPOCH:=$(firstword $(subst :, ,$(VERSION)))
VERSION:=$(word 2,$(subst :, ,$(VERSION)))
endif

ifneq ($(KDREV),)
ifeq ($(findstring :,$(KDREV)),:)
VERSION := $(subst :,:$(VERSION)+,$(KDREV))
else
VERSION := $(VERSION)+$(KDREV)
endif
endif

# cosmetic version for filenames, strip ANY epoch numbers. Also add
# epoch from version if needed
ifeq ($(findstring :,$(VERSION)),:)
VERSION := $(VERSIONEPOCH)$(VERSION)
else
ifneq ($(VERSIONEPOCH),)
VERSION := $(VERSIONEPOCH):$(VERSION)
endif
endif

ifeq ($(findstring :,$(VERSION)),:)
CVERSION:=$(word 2,$(subst :, ,$(VERSION)))
else
CVERSION:=$(VERSION)
endif

PKGNAME := $(PACKAGE)-$(KVERS)

echo-vars:
	@test -e "$(KSRC)" || echo Warning! Kernel source directory is not accessible.
	@echo "I've been configured using:"
	@echo " - Kernel source of $(KSRC)"
	@echo " - Kernel version of $(KVERS)"
	@echo " - Kernel revision of $(KDREV)"
	@echo " - C compiler of $(CC)"
	@test "$$ARCH" && echo " - Target kernel ARCH is $(ARCH)" || true
	@test "$$PKGARCH" && echo " - Target package ARCH is $(PKGARCH)" || true
	@echo " - Make options of $(MAKE_OPT)"
	@echo " - Version is $(VERSION)"
	@echo " - Cosmetic version is $(CVERSION)"
	@echo ' - Maintainer is $(MAINT)'
	@echo ' - Package name is $(PKGNAME)'
	@echo ' - Target directory is $(DEB_DESTDIR)'

#ifdef KDREV
#FULLVER := $(shell dpkg-parsechangelog |grep ^Version | cut -f2 -d' ')+$(KDREV)
## BE WARNED! Using KDREV (and so DEBDEP) in control files is evil
#DEBDEP := (= $(KDREV))
#else
#FULLVER := $(shell dpkg-parsechangelog |grep ^Version | cut -f2 -d' ')
#DEBDEP :=
#endif

# your configure rule may depend on this
ifeq ($(shell which $(CC)),)
# the compiler isn't there
ifdef IGNORE_CC_MISMATCH
CC=gcc
configure-checks:
	echo "WARNING: using wrong compiler version!"
else
configure-checks:
	echo "You don't have the compiler that your kernel was built with."
	echo "Maybe needed package: $(CC)"
	exit 1
endif
endif

#control-munge:
#	for i in control postinst postrm ; do \
#		cp debian/$$i debian/$$i.old; \
#		cat debian/$$i.mod | sed -e 's/_KVERS_/$(KVERS)/g' > debian/$$i; \
#	done
#	touch control-munge

#clean-control-munge:
#	for i in control postinst postrm ; do \
#		if [ -f debian/$$i.old ]; then \
#			mv debian/$$i.old debian/$$i; \
#		fi; \
#	done
#	-$(RM) control-munge

ifeq "$(origin KPKG_DEST_DIR)" "undefined"
#ifeq "$(origin KMAINT)" "undefined"
#DEB_DESTDIR=$(CURDIR)/..
#else
DEB_DESTDIR=$(KSRC)/..
#endif
else
DEB_DESTDIR=$(KPKG_DEST_DIR)
endif

CDBS_SAFE_DEB_DESTDIR=$(DEB_DESTDIR)

CHFILE := $(DEB_DESTDIR)/$(PKGNAME)_$(CVERSION)_$(PKGARCH).changes

#
echo-changes:
	@echo $(CHFILE)

echo-deb:
	@echo $(PKGNAME)

echo-debfile:
	@echo $(DEB_DESTDIR)/$(PKGNAME)_$(CVERSION)_$(PKGARCH).deb
	
# That is a matter of taste (of the maintainer)
# Targets that kernel-package uses.
#kdist_configure: configure-stamp
#kdist_config: configure-stamp
#kdist_image:
#	$(ROOT_CMD) $(MAKE) -f debian/rules binary-modules
#	$(ROOT_CMD) $(MAKE) -f debian/rules clean
#kdist_clean: clean
#kdist:
#	$(ROOT_CMD) $(MAKE) -f debian/rules binary-modules

# from genchanges.sh
#
ifdef KMAINT
DEB_NAME = $(KMAINT)
else
ifdef DEBFULLNAME
DEB_NAME = $(DEBFULLNAME)
else
ifdef DEBNAME
DEB_NAME = $(DEBNAME)
endif
endif
endif
#MYNAME = $(shell for name in "$$KMAINT" "$$DEBFULLNAME" "$$DEBNAME" ; \
#				 do test -n "$$name" && break; done ; echo "$$name")

ifdef KEMAIL
DEB_MAIL = $(KEMAIL)
else
ifdef DEBEMAIL
DEB_MAIL = $(DEBEMAIL)
endif
endif
#DEB_MAIL = $(shell for email in "$$KEMAIL" "$$DEBEMAIL" ; do \
#				 test -n "$$email" && break; done ; echo "$$name")

ifneq ($(DEB_MAIL),)
ifneq ($(DEB_NAME),)
MAINT := $(DEB_NAME) <$(DEB_MAIL)>
else
MAINT := $(DEB_MAIL)
endif
else
MAINT := $(LOGNAME)@$(shell hostname -f)
endif

genchanges:
	(head -2 debian/changelog ; echo "  * Built for kernel-image-$(KVERS)." ; \
	echo ; sed -ne '/^ -- / { p; q; }' debian/changelog ) > debian/changelog.tmp
	dpkg-genchanges -b -m'$(MAINT)' -e'$(MAINT)' -u'$(DEB_DESTDIR)' -ldebian/changelog.tmp > "$(CHFILE)"
	- if [ "$$SIGNCHANGES" ] ; then \
			if test -e "`which $${DEBSIGNCOMMAND:-debsign}`" ; then \
				$${DEBSIGNCOMMAND:-debsign} "$(CHFILE)" ; else \
		  	if test -e "$${GNUPGHOME:-$$HOME/.gnupg/secring.gpg}"; then \
					gpg -ast "$(DEB_MAIL)" --clearsign $(CHFILE) && mv $(CHFILE).asc $(CHFILE) ; else \
					pgp -ast -u "$(DEB_MAIL)" +clearsig=on rgb.txt ; \
				fi \
			fi \
		fi

# generic rewrite rule for the template files. First, copy files in
# debian/foo-KVERS_bar to the names with KVERS replaced. Then edit all
# files named with debian/NAME.modules.in and substitue _KVERS_ and _KDREV_,
# dumping the output into debian/NAME.
# 
prep-deb-files:
	@if test -z "$$RELAX_CC_CHECK" ; then which $(CC)>/dev/null || (  echo; echo; echo "The required compiler $(CC) is not installed, won't continue!" ; echo "Set RELAX_CC_CHECK variable to skip plausibility checks." ; sleep 5 ; exit 1) ; fi
	for templ in $(wildcard $(CURDIR)/debian/*_KVERS_*); do \
    cp $$templ `echo $$templ | sed -e 's/_KVERS_/$(KVERS)/g'` ; \
  done
	for templ in `ls debian/*.modules.in` ; do \
    test -e $${templ%.modules.in}.backup || cp $${templ%.modules.in} $${templ%.modules.in}.backup 2>/dev/null || true; \
    sed -e 's/##KVERS##/$(KVERS)/g ;s/#KVERS#/$(KVERS)/g ; s/_KVERS_/$(KVERS)/g ; s/##KDREV##/$(KDREV)/g ; s/#KDREV#/$(KDREV)/g ; s/_KDREV_/$(KDREV)/g  ' < $$templ > $${templ%.modules.in}; \
  done

.PHONY: kdist_configure kdist_config kdist_image kdist_clean kdist genchanges echo-deb echo-changes echo-vars echo-debfile
