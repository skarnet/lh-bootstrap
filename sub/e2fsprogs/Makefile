
E2FSPROGS_NAME := e2fsprogs
E2FSPROGS_VERSION := 1.47.1
E2FSPROGS_URLDIR := https://kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/v$(E2FSPROGS_VERSION)
E2FSPROGS_TAREXT := tar.xz
E2FSPROGS_TARLETTER := J

E2FSPROGS_CONFIGURE_OPTIONS := --with-gnu-ld --without-libiconv-prefix --disable-gtk-doc-html --with-xz --disable-manpages --enable-largefile --with-udev-rules-dir=no --with-crond-dir=no --with-systemd-unit-dir=no ac_cv_func_lseek64=yes
E2FSPROGS_CFLAGS := -Wno-implicit-function-declaration
E2FSPROGS_LDFLAGS := -s -static
E2FSPROGS_LIBS := -llzma

$(OUTPUT)/sources/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION).$(E2FSPROGS_TAREXT): | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget $(E2FSPROGS_URLDIR)/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION).$(E2FSPROGS_TAREXT)

$(OUTPUT)/sources/.lh_$(E2FSPROGS_NAME)_dled: $(OUTPUT)/sources/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION).$(E2FSPROGS_TAREXT) | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-build/.lh_$(E2FSPROGS_NAME)_copied: $(OUTPUT)/sources/.lh_$(E2FSPROGS_NAME)_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION)
	exec setuidgid $(NORMALUSER) s6-mkdir -p $(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION) tar $(E2FSPROGS_TARLETTER)xpvf $(OUTPUT)/sources/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION).$(E2FSPROGS_TAREXT)
	exec setuidgid $(NORMALUSER) s6-rename $(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION)/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION) $(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION)/src
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(E2FSPROGS_NAME)_configured: $(OUTPUT)/build-build/.lh_$(E2FSPROGS_NAME)_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION)/src export CC "$(BUILD_CC)" export CFLAGS "$(E2FSPROGS_CFLAGS)" export LDFLAGS "$(E2FSPROGS_LDFLAGS)" ./configure --prefix=$(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION) $(E2FSPROGS_CONFIGURE_OPTIONS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(E2FSPROGS_NAME)_built: $(OUTPUT)/build-build/.lh_$(E2FSPROGS_NAME)_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION)/src $(MAKE) "LDFLAGS=$(E2FSPROGS_LDFLAGS)"
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(E2FSPROGS_NAME)_installed: $(OUTPUT)/build-build/.lh_$(E2FSPROGS_NAME)_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION)/src $(MAKE) install CC="$(BUILD_CC)"
	exec setuidgid $(NORMALUSER) makenamelink $(OUTPUT)/build-build/opt $(E2FSPROGS_NAME) $(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) s6-touch $@
