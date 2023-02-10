
MAKE_VERSION ?= 4.4
MAKE_MAKE_STATIC := $(if $(filter true,$(TARGET_STATIC)),LDFLAGS=-static,)

clean-make:
	rm -f $(OUTPUT)/build-$(TRIPLE)/.lh_make_*
	

$(OUTPUT)/sources/make-$(MAKE_VERSION).tar.gz: | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget https://ftp.gnu.org//gnu/make/make-$(MAKE_VERSION).tar.gz

$(OUTPUT)/build-$(TRIPLE)/.lh_make_dled: $(OUTPUT)/sources/make-$(MAKE_VERSION).tar.gz | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_make_copied: $(OUTPUT)/build-$(TRIPLE)/.lh_make_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-$(TRIPLE)/make-$(MAKE_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE) tar -zxpvf $(OUTPUT)/sources/make-$(MAKE_VERSION).tar.gz
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_make_configured: $(OUTPUT)/build-$(TRIPLE)/.lh_make_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/make-$(MAKE_VERSION) export CC "$(TARGET_CC)" ./configure --host=$(TRIPLE) --prefix=/opt/make-$(MAKE_VERSION) --disable-nls --disable-rpath
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_make_built: $(OUTPUT)/build-$(TRIPLE)/.lh_make_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/make-$(MAKE_VERSION) $(MAKE) $(MAKE_MAKE_STATIC)
	exec setuidgid $(NORMALUSER) s6-touch $@
	
$(OUTPUT)/build-$(TRIPLE)/.lh_make_installed: $(OUTPUT)/build-$(TRIPLE)/.lh_make_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed $(OUTPUT)/tmp/.lh_layout_installed
	exec cd $(OUTPUT)/build-$(TRIPLE)/make-$(MAKE_VERSION) $(MAKE) install DESTDIR=$(OUTPUT)/rootfs
	exec makenamelink $(OUTPUT)/rootfs/opt make make-$(MAKE_VERSION) $(OUTPUT)/tmp
	exec makelinks $(OUTPUT)/rootfs /bin /opt/make/bin
	exec setuidgid $(NORMALUSER) s6-touch $@
