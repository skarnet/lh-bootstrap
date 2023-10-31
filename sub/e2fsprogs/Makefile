
E2FSPROGS_NAME := e2fsprgs
E2FSPROGS_VERSION := 1.47.0
E2FSPROGS_URLDIR := https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/snapshot
E2FSPROGS_TAREXT := tar.gz
E2FSPROGS_TARLETTER := z

E2FSPROGS_CONFIGURE_OPTIONS := --with-gnu-ld --disable-gtk-doc-html --with-xz --disable-manpages --with-bashcompletiondir=$(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION)/bash-completions
E2FSPROGS_CFLAGS :=
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
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION)/src export CC "$(BUILD_CC)" export LDFLAGS "$(E2FSPROGS_LDFLAGS)" ./configure --prefix=$(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION) $(E2FSPROGS_CONFIGURE_OPTIONS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(E2FSPROGS_NAME)_built: $(OUTPUT)/build-build/.lh_$(E2FSPROGS_NAME)_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION)/src $(MAKE) "LDFLAGS=$(E2FSPROGS_LDFLAGS)"
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(E2FSPROGS_NAME)_installed: $(OUTPUT)/build-build/.lh_$(E2FSPROGS_NAME)_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION)/src $(MAKE) install CC="$(BUILD_CC)"
	exec setuidgid $(NORMALUSER) makenamelink $(OUTPUT)/build-build/opt $(E2FSPROGS_NAME) $(E2FSPROGS_NAME)-$(E2FSPROGS_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) s6-touch $@
