
BEARSSL_NAME := bearssl
# latest version from 2019-05-03
BEARSSL_VERSION := 9721b3e7566693128a5923cc1f481216b7853466
BEARSSL_URLDIR := https://www.bearssl.org/git

$(OUTPUT)/sources/.lh_$(BEARSSL_NAME)_dled: | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/sources/$(BEARSSL_NAME) $(OUTPUT)/sources/$(BEARSSL_NAME)-$(BEARSSL_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources git clone $(BEARSSL_URLDIR)/BearSSL
	exec setuidgid $(NORMALUSER) s6-rename $(OUTPUT)/sources/BearSSL $(OUTPUT)/sources/$(BEARSSL_NAME)-$(BEARSSL_VERSION)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_$(BEARSSL_NAME)_copied: $(OUTPUT)/sources/.lh_$(BEARSSL_NAME)_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/$(BEARSSL_NAME)-$(BEARSSL_VERSION)
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/$(BEARSSL_NAME)-$(BEARSSL_VERSION) $(OUTPUT)/build-host/$(BEARSSL_NAME)-$(BEARSSL_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/$(BEARSSL_NAME)-$(BEARSSL_VERSION) git checkout $(BEARSSL_VERSION)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_$(BEARSSL_NAME)_built: $(OUTPUT)/build-host/.lh_$(BEARSSL_NAME)_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/$(BEARSSL_NAME)-$(BEARSSL_VERSION) $(MAKE) lib CC=$(BUILD_HOST_CC) LD=$(BUILD_HOST_CC) LDDLL=$(BUILD_HOST_CC)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_$(BEARSSL_NAME)_installed: $(OUTPUT)/build-host/.lh_$(BEARSSL_NAME)_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec s6-mkdir -p $(OUTPUT)/rootfs/opt/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/lib $(OUTPUT)/rootfs/opt/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/bin
	exec cp $(OUTPUT)/build-host/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/build/libbearssl.a $(OUTPUT)/rootfs/opt/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/lib/
	exec s6-hiercopy $(OUTPUT)/build-host/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/inc $(OUTPUT)/rootfs/opt/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/include
	exec chown -R root.root $(OUTPUT)/rootfs/opt/$(BEARSSL_NAME)-$(BEARSSL_VERSION)/include
	exec makenamelink $(OUTPUT)/rootfs/opt $(BEARSSL_NAME) $(BEARSSL_NAME)-$(BEARSSL_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) s6-touch $@
