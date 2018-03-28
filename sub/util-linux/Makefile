
UTLX_NAME := util-linux
UTLX_VERSION := 2.32
UTLX_MAJOR := $(word 1, $(subst ., ,$(UTLX_VERSION)))
UTLX_MINOR := $(word 2, $(subst ., ,$(UTLX_VERSION)))
UTLX_URLDIR := https://cdn.kernel.org/pub/linux/utils/$(UTLX_NAME)/v$(UTLX_MAJOR).$(UTLX_MINOR)
UTLX_TAREXT := tar.xz
UTLX_TARLETTER := J
UTLX_CONFIGURE_OPTIONS := \
--prefix=$(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION) \
--disable-assert \
--disable-nls \
--disable-shared \
--disable-widechar \
--disable-libuuid \
--disable-libblkid \
--disable-libsmartcols \
--disable-all-programs \
--enable-losetup \
--enable-fdisk \
--enable-mkswap \
--enable-mount \
--enable-umount \
--disable-bash-completion \
--disable-pylibmount \
--disable-pg-bell \
--disable-makeinstall-chown \
--disable-makeinstall-setuid \
--disable-colors-default \
--with-gnu-ld \
--without-util \
--without-termcap \
--without-libiconv-prefix \
--without-selinux \
--without-audit \
--without-udev \
--without-user \
--without-python \
--without-ncurses \
--without-ncursesw \
--without-slang \
--without-tinfo

UTLX_CFLAGS := ""
UTLX_CONFLDFLAGS := ""
UTLX_MAKELDFLAGS := "-s"

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
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/src $(MAKE) LDFLAGS=$(UTLX_MAKELDFLAGS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(UTLX_NAME)_installed: $(OUTPUT)/build-build/.lh_$(UTLX_NAME)_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/src $(MAKE) install
	exec setuidgid $(NORMALUSER) makelinks $(OUTPUT)/build-build /bin /opt/$(UTLX_NAME)/bin
	exec setuidgid $(NORMALUSER) s6-touch $@
