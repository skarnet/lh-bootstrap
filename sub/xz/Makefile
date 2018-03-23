
XZ_NAME := xz
XZ_VERSION := 5.2.3
XZ_URLDIR := http://tukaani.org/$(XZ_NAME)
XZ_TAREXT := tar.xz
XZ_TARLETTER := J
XZ_CONFIGURE_OPTIONS := --disable-nls --with-gnu-ld --enable-threads=posix --disable-shared --disable-scripts --disable-doc --disable-lzma-links --disable-lzmainfo --disable-lzmadec --disable-xzdec --disable-xz
XZ_CFLAGS := ""
XZ_CONFLDFLAGS := "-s"
XZ_MAKELDFLAGS := "-s"


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

$(OUTPUT)/build-build/.lh_$(XZ_NAME)_configured: $(OUTPUT)/build-build/.lh_$(XZ_NAME)_copied $(OUTPUT)/build-build/.lh_gcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION)/src export CFLAGS $(XZ_CFLAGS) export LDFLAGS $(XZ_CONFLDFLAGS) ./configure --prefix=$(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION) $(XZ_CONFIGURE_OPTIONS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(XZ_NAME)_built: $(OUTPUT)/build-build/.lh_$(XZ_NAME)_configured $(OUTPUT)/build-build/.lh_gcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION)/src $(MAKE) LDFLAGS=$(XZ_MAKELDFLAGS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(XZ_NAME)_installed: $(OUTPUT)/build-build/.lh_$(XZ_NAME)_built $(OUTPUT)/build-build/.lh_gcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(XZ_NAME)-$(XZ_VERSION)/src $(MAKE) install
	exec setuidgid $(NORMALUSER) makenamelink $(OUTPUT)/build-build/opt $(XZ_NAME) $(XZ_NAME)-$(XZ_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_$(XZ_NAME)_copied: $(OUTPUT)/sources/.lh_$(XZ_NAME)_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/$(XZ_NAME)-$(XZ_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host tar $(XZ_TARLETTER)xpvf $(OUTPUT)/sources/$(XZ_NAME)-$(XZ_VERSION).$(XZ_TAREXT)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_$(XZ_NAME)_configured: $(OUTPUT)/build-host/.lh_$(XZ_NAME)_copied $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/$(XZ_NAME)-$(XZ_VERSION) export CFLAGS $(XZ_CFLAGS) export LDFLAGS $(XZ_CONFLDFLAGS) export CC muslgcc ./configure --host=$(TRIPLE) --prefix=/opt/$(XZ_NAME)-$(XZ_VERSION) $(XZ_CONFIGURE_OPTIONS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_$(XZ_NAME)_built: $(OUTPUT)/build-host/.lh_$(XZ_NAME)_configured $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/$(XZ_NAME)-$(XZ_VERSION) $(MAKE) LDFLAGS=$(XZ_MAKELDFLAGS) CC=muslgcc
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_$(XZ_NAME)_installed: $(OUTPUT)/build-host/.lh_$(XZ_NAME)_built $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/$(XZ_NAME)-$(XZ_VERSION) $(MAKE) install DESTDIR=$(OUTPUT)/rootfs
	exec makenamelink $(OUTPUT)/rootfs/opt $(XZ_NAME) $(XZ_NAME)-$(XZ_VERSION) $(OUTPUT)/tmp
	exec makelinks $(OUTPUT)/rootfs /bin /opt/$(XZ_NAME)/bin
	exec setuidgid $(NORMALUSER) s6-touch $@
