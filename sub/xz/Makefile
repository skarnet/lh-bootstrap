
XZ_NAME := xz
XZ_VERSION := 5.4.1
XZ_URLDIR := https://tukaani.org/$(XZ_NAME)
XZ_TAREXT := tar.xz
XZ_TARLETTER := J
XZ_CONF_STATIC := $(if $(filter true,$(TARGET_STATIC)),--disable-shared,)
XZ_MAKE_STATIC := $(if $(filter true,$(TARGET_STATIC)),-static,)
XZ_CONFIGURE_OPTIONS := --disable-nls --with-gnu-ld --enable-threads=posix --disable-scripts --disable-doc --disable-lzma-links --disable-lzmainfo --disable-lzmadec --disable-xzdec --disable-xz
XZ_CFLAGS := ""
XZ_CONFLDFLAGS := "-s $(XZ_MAKE_STATIC)"
XZ_MAKELDFLAGS := "-s $(XZ_MAKE_STATIC)"


$(OUTPUT)/sources/$(XZ_NAME)-$(XZ_VERSION).$(XZ_TAREXT): | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget $(XZ_URLDIR)/$(XZ_NAME)-$(XZ_VERSION).$(XZ_TAREXT)

$(OUTPUT)/sources/.lh_$(XZ_NAME)_dled: $(OUTPUT)/sources/$(XZ_NAME)-$(XZ_VERSION).$(XZ_TAREXT) | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-build/.lh_$(XZ_NAME)_copied: $(OUTPUT)/sources/.lh_$(XZ_NAME)_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION)
	exec setuidgid $(NORMALUSER) s6-mkdir -p $(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION) tar $(XZ_TARLETTER)xpvf $(OUTPUT)/sources/$(XZ_NAME)-$(XZ_VERSION).$(XZ_TAREXT)
	exec setuidgid $(NORMALUSER) s6-rename $(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION)/$(XZ_NAME)-$(XZ_VERSION) $(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION)/src
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(XZ_NAME)_configured: $(OUTPUT)/build-build/.lh_$(XZ_NAME)_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION)/src export CC "$(BUILD_CC)" export CFLAGS $(XZ_CFLAGS) export LDFLAGS -s ./configure --prefix=$(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION) $(XZ_CONFIGURE_OPTIONS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(XZ_NAME)_built: $(OUTPUT)/build-build/.lh_$(XZ_NAME)_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION)/src $(MAKE) CC="$(BUILD_CC)" LDFLAGS=-s
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(XZ_NAME)_installed: $(OUTPUT)/build-build/.lh_$(XZ_NAME)_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION)/src $(MAKE) install CC="$(BUILD_CC)"
	exec setuidgid $(NORMALUSER) makenamelink $(OUTPUT)/build-build/opt $(XZ_NAME) $(XZ_NAME)-$(XZ_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-$(TRIPLE)/.lh_$(XZ_NAME)_copied: $(OUTPUT)/sources/.lh_$(XZ_NAME)_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-$(TRIPLE)/$(XZ_NAME)-$(XZ_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE) tar $(XZ_TARLETTER)xpvf $(OUTPUT)/sources/$(XZ_NAME)-$(XZ_VERSION).$(XZ_TAREXT)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_$(XZ_NAME)_configured: $(OUTPUT)/build-$(TRIPLE)/.lh_$(XZ_NAME)_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/$(XZ_NAME)-$(XZ_VERSION) export CC "$(TARGET_CC)" export CFLAGS $(XZ_CFLAGS) export LDFLAGS $(XZ_CONFLDFLAGS) ./configure --host=$(TRIPLE) --prefix=/opt/$(XZ_NAME)-$(XZ_VERSION) $(XZ_CONFIGURE_OPTIONS) $(XZ_CONF_STATIC)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_$(XZ_NAME)_built: $(OUTPUT)/build-$(TRIPLE)/.lh_$(XZ_NAME)_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/$(XZ_NAME)-$(XZ_VERSION) $(MAKE) LDFLAGS=$(XZ_MAKELDFLAGS) CC="$(TARGET_CC)"
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_$(XZ_NAME)_installed: $(OUTPUT)/build-$(TRIPLE)/.lh_$(XZ_NAME)_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-$(TRIPLE)/$(XZ_NAME)-$(XZ_VERSION) $(MAKE) install CC="$(TARGET_CC)" DESTDIR=$(OUTPUT)/rootfs
	exec makenamelink $(OUTPUT)/rootfs/opt $(XZ_NAME) $(XZ_NAME)-$(XZ_VERSION) $(OUTPUT)/tmp
	exec makelinks $(OUTPUT)/rootfs /bin /opt/$(XZ_NAME)/bin
	exec setuidgid $(NORMALUSER) s6-touch $@
