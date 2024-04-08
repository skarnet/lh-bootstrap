
KMOD_NAME := kmod
KMOD_VERSION := 32
KMOD_URLDIR := https://cdn.kernel.org/pub/linux/utils/kernel/$(KMOD_NAME)
KMOD_TAREXT := tar.xz
KMOD_TARLETTER := J

# Do not use --enable-static or --disable-shared: the kmod configure script is voluntarily broken.
# Use make variables instead to link kmod statically.

KMOD_CONFIGURE_OPTIONS := --disable-option-checking --disable-maintainer-mode --with-module-directory=$(OUTPUT)/rootfs/lib/modules --with-gnu-ld --disable-gtk-doc-html --with-xz --disable-manpages --disable-test-modules --disable-logging --with-bashcompletiondir=$(OUTPUT)/build-build/opt/$(KMOD_NAME)-$(KMOD_VERSION)/bash-completions
KMOD_CFLAGS := -I$(OUTPUT)/build-build/opt/xz/include -include libgen.h
KMOD_LDFLAGS := -L$(OUTPUT)/build-build/opt/xz/lib
KMOD_LIBS := -llzma

$(OUTPUT)/sources/$(KMOD_NAME)-$(KMOD_VERSION).$(KMOD_TAREXT): | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget $(KMOD_URLDIR)/$(KMOD_NAME)-$(KMOD_VERSION).$(KMOD_TAREXT)

$(OUTPUT)/sources/.lh_$(KMOD_NAME)_dled: $(OUTPUT)/sources/$(KMOD_NAME)-$(KMOD_VERSION).$(KMOD_TAREXT) | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-build/.lh_$(KMOD_NAME)_copied: $(OUTPUT)/sources/.lh_$(KMOD_NAME)_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-build/opt/$(KMOD_NAME)-$(KMOD_VERSION)
	exec setuidgid $(NORMALUSER) s6-mkdir -p $(OUTPUT)/build-build/opt/$(KMOD_NAME)-$(KMOD_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(KMOD_NAME)-$(KMOD_VERSION) tar $(KMOD_TARLETTER)xpvf $(OUTPUT)/sources/$(KMOD_NAME)-$(KMOD_VERSION).$(KMOD_TAREXT)
	exec setuidgid $(NORMALUSER) s6-rename $(OUTPUT)/build-build/opt/$(KMOD_NAME)-$(KMOD_VERSION)/$(KMOD_NAME)-$(KMOD_VERSION) $(OUTPUT)/build-build/opt/$(KMOD_NAME)-$(KMOD_VERSION)/src
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(KMOD_NAME)_configured: $(OUTPUT)/build-build/.lh_$(KMOD_NAME)_copied $(OUTPUT)/build-build/.lh_xz_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(KMOD_NAME)-$(KMOD_VERSION)/src export CC "$(BUILD_CC)" export liblzma_CFLAGS "-I$(OUTPUT)/build-build/opt/xz/include -L$(OUTPUT)/build-build/opt/xz/lib" export liblzma_LIBS "-llzma" export CFLAGS "$(KMOD_CFLAGS)" export LDFLAGS "$(KMOD_LDFLAGS)" export LIBS "$(KMOD_LIBS)" ./configure --prefix=$(OUTPUT)/build-build/opt/$(KMOD_NAME)-$(KMOD_VERSION) $(KMOD_CONFIGURE_OPTIONS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(KMOD_NAME)_built: $(OUTPUT)/build-build/.lh_$(KMOD_NAME)_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(KMOD_NAME)-$(KMOD_VERSION)/src $(MAKE)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(KMOD_NAME)_installed: $(OUTPUT)/build-build/.lh_$(KMOD_NAME)_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(KMOD_NAME)-$(KMOD_VERSION)/src $(MAKE) install CC="$(BUILD_CC)"
	exec setuidgid $(NORMALUSER) makenamelink $(OUTPUT)/build-build/opt $(KMOD_NAME) $(KMOD_NAME)-$(KMOD_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) s6-touch $@
