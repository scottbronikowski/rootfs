ifeq ($(strip $(KDREV)),)
KDREV		= "test1.0"
endif

## Now to determine the kernel version, normally supplied by make-kpkg
ifeq ($(strip $(KVERS)),)
# Now we need to get the kernel-version somehow (we are not running
# under make-kpkg?)
ifeq ($(strip $(KSRC)),)
$(error Error. I do not know how to determine the kernel version)
else
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

ifdef FLAVOUR
# uhm - should check if we really have a Makefile capable of Flavours?
endif

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

non_epoch_version=$(shell echo $(KVERS) | perl -pe 's/^\d+://')
epoch=$(shell echo $(KVERS) | perl -ne 'm/^(\d+:)/ && print $$1')

#' We also need the package version
pversion	= $(shell sed -ne '1s/.*\((.*)\).*/\1/' debian/changelog)
pversion	= $(shell sed -ne '1s/.*(\(.*\)).*/\1/p' debian/changelog)

pmodules = $(package)-modules-$(non_epoch_version)
psource = $(package)-source


	# Is this needed for setting up a Depends?
  # PS: (eb) This is evil, don't use it
#	echo "kpkg:Package-Version=$(epoch)$(pversion)+$(non_epoch_version)" \
#		 >> debian/$(package).substvars
#	echo "kpkg:Kernel-Version=$(non_epoch_version)" > \
#		debian/$(pmodules).substvars
