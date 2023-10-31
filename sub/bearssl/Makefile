
BEARSSL_NAME := bearssl
# latest version from 2022-06-22
BEARSSL_VERSION := 46f7dddce75227f2e40ab94d66ceb9f19ee6b1b0
BEARSSL_URLDIR := https://www.bearssl.org/git

$(OUTPUT)/sources/.lh_$(BEARSSL_NAME)_dled: | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/sources/$(BEARSSL_NAME) $(OUTPUT)/sources/$(BEARSSL_NAME)-$(BEARSSL_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources git clone $(BEARSSL_URLDIR)/BearSSL
	exec setuidgid $(NORMALUSER) s6-rename $(OUTPUT)/sources/BearSSL $(OUTPUT)/sources/$(BEARSSL_NAME)-$(BEARSSL_VERSION)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_$(BEARSSL_NAME)_copied: $(OUTPUT)/sources/.lh_$(BEARSSL_NAME)_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-$(TRIPLE)/$(BEARSSL_NAME)-$(BEARSSL_VERSION)
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/$(BEARSSL_NAME)-$(BEARSSL_VERSION) $(OUTPUT)/build-$(TRIPLE)/$(BEARSSL_NAME)-$(BEARSSL_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/$(BEARSSL_NAME)-$(BEARSSL_VERSION) git checkout $(BEARSSL_VERSION)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_$(BEARSSL_NAME)_built: $(OUTPUT)/build-$(TRIPLE)/.lh_$(BEARSSL_NAME)_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/$(BEARSSL_NAME)-$(BEARSSL_VERSION) $(MAKE) lib CC="$(TARGET_CC)" LD="$(TARGET_CC)" LDDLL="$(TARGET_CC)"
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_$(BEARSSL_NAME)_installed: $(OUTPUT)/build-$(TRIPLE)/.lh_$(BEARSSL_NAME)_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec s6-mkdir -p $(OUTPUT)/rootfs/opt/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/lib
	exec cp $(OUTPUT)/build-$(TRIPLE)/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/build/libbearssl.a $(OUTPUT)/rootfs/opt/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/lib/
	exec s6-hiercopy $(OUTPUT)/build-$(TRIPLE)/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/inc $(OUTPUT)/rootfs/opt/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/include
	exec chown -R root:root $(OUTPUT)/rootfs/opt/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/include
	exec makenamelink $(OUTPUT)/rootfs/opt $(BEARSSL_NAME) $(BEARSSL_NAME)-$(BEARSSL_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) s6-touch $@
