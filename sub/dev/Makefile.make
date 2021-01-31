
MAKE_VERSION ?= 4.3
MAKE_MAKE_STATIC := $(if $(filter true,$(BUILD_HOST_STATIC)),LDFLAGS=-static,)

clean-make:
	rm -f $(OUTPUT)/build-host/.lh_make_*
	

$(OUTPUT)/sources/make-$(MAKE_VERSION).tar.xz: | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget https://ftp.gnu.org//gnu/make/make-$(MAKE_VERSION).tar.gz

$(OUTPUT)/build-host/.lh_make_dled: $(OUTPUT)/sources/make-$(MAKE_VERSION).tar.gz | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_make_copied: $(OUTPUT)/build-host/.lh_make_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/make-$(MAKE_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host tar -zxpvf $(OUTPUT)/sources/make-$(MAKE_VERSION).tar.gz
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_make_configured: $(OUTPUT)/build-host/.lh_make_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/make-$(MAKE_VERSION) export CC "$(BUILD_HOST_CC)" ./configure --host=$(TRIPLE) --prefix=/opt/make-$(MAKE_VERSION) --disable-nls --disable-rpath
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_make_built: $(OUTPUT)/build-host/.lh_make_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/make-$(MAKE_VERSION) $(MAKE) $(MAKE_MAKE_STATIC)
	exec setuidgid $(NORMALUSER) s6-touch $@
	
$(OUTPUT)/build-host/.lh_make_installed: $(OUTPUT)/build-host/.lh_make_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/make-$(MAKE_VERSION) $(MAKE) install DESTDIR=$(OUTPUT)/rootfs
	exec makenamelink $(OUTPUT)/rootfs/opt make make-$(MAKE_VERSION) $(OUTPUT)/tmp
	exec makelinks $(OUTPUT)/rootfs /bin /opt/make/bin
	exec setuidgid $(NORMALUSER) s6-touch $@
