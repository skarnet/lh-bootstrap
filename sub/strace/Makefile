
STRACE_VERSION ?= 5.9
STRACE_MAKE_STATIC := $(if $(filter true,$(BUILD_HOST_STATIC)),LDFLAGS=-static,)

clean-strace:
	rm -f $(OUTPUT)/build-host/.lh_strace_*
	

$(OUTPUT)/sources/strace-$(STRACE_VERSION).tar.xz: | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget https://strace.io/files/$(STRACE_VERSION)/strace-$(STRACE_VERSION).tar.xz

$(OUTPUT)/build-host/.lh_strace_dled: $(OUTPUT)/sources/strace-$(STRACE_VERSION).tar.xz | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_strace_copied: $(OUTPUT)/build-host/.lh_strace_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/strace-$(STRACE_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host tar -Jxpvf $(OUTPUT)/sources/strace-$(STRACE_VERSION).tar.xz
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_strace_configured: $(OUTPUT)/build-host/.lh_strace_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/strace-$(STRACE_VERSION) export CC "$(BUILD_HOST_CC)" export LIBS "-lrt -lpthread" ./configure --host=$(TRIPLE) --prefix=/opt/strace-$(STRACE_VERSION) --enable-mpers=no
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_strace_built: $(OUTPUT)/build-host/.lh_strace_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/strace-$(STRACE_VERSION) $(MAKE) $(STRACE_MAKE_STATIC)
	exec setuidgid $(NORMALUSER) s6-touch $@
	
$(OUTPUT)/build-host/.lh_strace_installed: $(OUTPUT)/build-host/.lh_strace_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/strace-$(STRACE_VERSION) $(MAKE) install DESTDIR=$(OUTPUT)/rootfs
	exec makenamelink $(OUTPUT)/rootfs/opt strace strace-$(STRACE_VERSION) $(OUTPUT)/tmp
	exec makelinks $(OUTPUT)/rootfs /bin /opt/strace/bin
	exec setuidgid $(NORMALUSER) s6-touch $@
