.NOTPARALLEL:

# THIS RULE IS TO BE IMPLEMENTED BY THE SPECIFIC MAKEFILE
# It should compile the module, install it into the target directory
# structure in debian/ and build the package. Example:
#
#binary-modules:
#	cd driver && $(MAKE) -f ../Makefile.debian
#	mkdir -p debian/$(PKGNAME)/lib/modules/$(KVERS)/kernel/fs
#	cp driver/foo.o debian/$(PKGNAME)/lib/modules/$(KVERS)/kernel/fs/
#	dh_installdocs
#	dh_installmodules
#	dh_installchangelogs 
#	dh_link
#	dh_strip
#	dh_compress
#	dh_fixperms
#	dh_installdeb
#	dh_gencontrol  -- -v$(VERSION)
#	dh_md5sums
#	dh_builddeb --destdir=$(DEB_DESTDIR)

# THIS RULE IS TO BE IMPLEMENTED BY THE SPECIFIC MAKEFILE
# It should clean the source before and after the compilation. Example:
#
#kdist_clean:
# -$(MAKE) $(MFLAGS) debian/rules clean
# rm -rf other.o module.o files driver

# THIS RULE IS TO BE IMPLEMENTED BY THE SPECIFIC MAKEFILE
# The kdist_configure target is called by make-kpkg modules_config. It
# should configure the module so it is ready for compilation (mostly
# useful for calling configure). Example:
#
#kdist_config: prep-deb-files
## maybe assign driver-2.4 or driver-2.6 to driver
#	cp -la driver-$(shell echo $(KVERS) | sed -e 's/\(...\).*/\1/') driver
# cd driver ; ./configure

# Prepares the package for distribution.  Intended for the kernel
# maintainer
kdist: kdist_build genchanges
	$(ROOT_CMD) $(MAKE) $(MFLAGS) -f debian/rules kdist_clean

# the kdist_image target is called by make-kpkg modules_image. It is
# responsible for compiling the module and creating the package. It
# should also clean up after making the module. Please note we use a
# seperate binary-modules target to make testing the package building
# easier, and kdist_build is the rule used by both, kdist and kdist_image
kdist_image: kdist_build
	$(ROOT_CMD) $(MAKE) $(MFLAGS) -f debian/rules kdist_clean

# common build rule for modules
#ifdef ROOT_CMD
kdist_build: 
	$(ROOT_CMD) $(MAKE) $(MFLAGS) -f debian/rules kdist_clean kdist_config binary-modules
#else
#kdist_build: kdist_clean kdist_config binary-modules
#endif

.PHONY: kdist_config kdist_build kdist_image kdist
