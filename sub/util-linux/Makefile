# compiling some programs from util-linux when they are not available or outdated on the build system
# TODO: check what's available on the build system and run the recipes based on what's there or not
# (Laurent) No, this would add complexity and unpredictability for a very
# minor speed benefit. As long as we have to build one tool from the package,
# build all the tools we need has negligible cost.


UTLX_NAME := util-linux
UTLX_VERSION := 2.31.1
UTLX_MAJOR := $(word 1, $(subst ., ,$(UTLX_VERSION)))
UTLX_MINOR := $(word 2, $(subst ., ,$(UTLX_VERSION)))
UTLX_URLDIR := https://cdn.kernel.org/pub/linux/utils/$(UTLX_NAME)/v$(UTLX_MAJOR).$(UTLX_MINOR)
UTLX_TAREXT := tar.xz
UTLX_TARLETTER := J
UTLX_CONFIGURE_OPTIONS := --disable-assert --disable-nls --enable-mount --enable-losetup --disable-bash-completion --disable-pylibmount --disable-pg-bell --disable-makeinstall-chown --disable-makeinstall-setuid --disable-colors-default --with-gnu-ld --without-util --without-termcap --without-libiconv-prefix --without-udev --without-user --without-python --without-ncurses --without-tinfo
UTLX_CFLAGS := ""
UTLX_CONFLDFLAGS := ""
UTLX_MAKELDFLAGS := "-s -all-static"

# only compiling losetup, other tools are widely available and well defined. You could also add: fdisk losetup mkswap mount
# (Laurent) No, listing all the tools we need allows us to not depend on *any*
# version of util-linux being installed on the machine. This is intentional:
# if we're going to download our own util-linux anyway, we might as well
# remove the dependency entirely.

UTLX_PROGLIST := losetup fdisk mkswap mount umount


$(OUTPUT)/sources/$(UTLX_NAME)-$(UTLX_VERSION).$(UTLX_TAREXT): | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget $(UTLX_URLDIR)/$(UTLX_NAME)-$(UTLX_VERSION).$(UTLX_TAREXT)

$(OUTPUT)/sources/.lh_$(UTLX_NAME)_dled: $(OUTPUT)/sources/$(UTLX_NAME)-$(UTLX_VERSION).$(UTLX_TAREXT)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(UTLX_NAME)_copied: $(OUTPUT)/sources/.lh_$(UTLX_NAME)_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/src
	exec setuidgid $(NORMALUSER) s6-mkdir -p $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)
	exec setuidgid $(NORMALUSER) makenamelink $(OUTPUT)/build-build/opt $(UTLX_NAME) $(UTLX_NAME)-$(UTLX_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION) tar $(UTLX_TARLETTER)xpvf $(OUTPUT)/sources/$(UTLX_NAME)-$(UTLX_VERSION).$(UTLX_TAREXT)
	exec setuidgid $(NORMALUSER) s6-rename $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/$(UTLX_NAME)-$(UTLX_VERSION) $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/src
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(UTLX_NAME)_configured: $(OUTPUT)/build-build/.lh_$(UTLX_NAME)_copied $(OUTPUT)/build-build/.lh_kernel_headers_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/src export CFLAGS $(UTLX_CFLAGS) export LDFLAGS $(UTLX_CONFLDFLAGS) ./configure --prefix=$(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION) $(UTLX_CONFIGURE_OPTIONS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(UTLX_NAME)_built: $(OUTPUT)/build-build/.lh_$(UTLX_NAME)_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/src $(MAKE) $(UTLX_PROGLIST) LDFLAGS=$(UTLX_MAKELDFLAGS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(UTLX_NAME)_installed: $(OUTPUT)/build-build/.lh_$(UTLX_NAME)_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-mkdir -p $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/bin
	for i in $(UTLX_PROGLIST) ; do setuidgid $(NORMALUSER) cp -f "$(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/src/$$i" $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/bin/ ; done
	exec setuidgid $(NORMALUSER) makelinks $(OUTPUT)/build-build /bin /opt/$(UTLX_NAME)/bin
	exec setuidgid $(NORMALUSER) s6-touch $@
