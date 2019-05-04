
DROPBEAR_VERSION ?= 2019.78


clean-dropbear:
	rm -f $(OUTPUT)/build-host/.lh_dropbear_*
	

$(OUTPUT)/sources/dropbear-$(DROPBEAR_VERSION).tar.bz2: | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget https://dropbear.nl/mirror/dropbear-$(DROPBEAR_VERSION).tar.bz2

$(OUTPUT)/build-host/.lh_dropbear_dled: $(OUTPUT)/sources/dropbear-$(DROPBEAR_VERSION).tar.bz2 | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_dropbear_copied: $(OUTPUT)/build-host/.lh_dropbear_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/dropbear-$(DROPBEAR_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host tar jxpvf $(OUTPUT)/sources/dropbear-$(DROPBEAR_VERSION).tar.bz2
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_dropbear_patched: $(OUTPUT)/build-host/.lh_dropbear_copied sub/dropbear/localoptions.h
	exec setuidgid $(NORMALUSER) cp -f sub/dropbear/localoptions.h $(OUTPUT)/build-host/dropbear-$(DROPBEAR_VERSION)/localoptions.h
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_dropbear_configured: $(OUTPUT)/build-host/.lh_dropbear_patched | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/dropbear-$(DROPBEAR_VERSION) export ARCH $(KERNEL_ARCH) export CC $(BUILD_HOST_CC) export LDFLAGS '-s -static' ./configure --host=$(TRIPLE) --prefix=/opt/dropbear-$(DROPBEAR_VERSION) --disable-syslog --disable-lastlog --disable-utmp --disable-utmpx --disable-wtmp --disable-wtmpx --disable-pututline --disable-pututxline --without-pam --enable-bundled-libtom --disable-zlib --enable-static
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_dropbear_built: $(OUTPUT)/build-host/.lh_dropbear_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/dropbear-$(DROPBEAR_VERSION) $(MAKE) ARCH=$(KERNEL_ARCH) PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp"
	exec setuidgid $(NORMALUSER) s6-touch $@
	
$(OUTPUT)/build-host/.lh_dropbear_installed: $(OUTPUT)/build-host/.lh_dropbear_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/dropbear-$(DROPBEAR_VERSION) $(MAKE) install DESTDIR=$(OUTPUT)/rootfs
	exec makenamelink $(OUTPUT)/rootfs/opt dropbear dropbear-$(DROPBEAR_VERSION) $(OUTPUT)/tmp
	exec cp -f $(OUTPUT)/build-host/dropbear-$(DROPBEAR_VERSION)/scp $(OUTPUT)/rootfs/opt/dropbear-$(DROPBEAR_VERSION)/bin/scp
	exec mv -f $(OUTPUT)/rootfs/opt/dropbear-$(DROPBEAR_VERSION)/sbin/dropbear $(OUTPUT)/rootfs/opt/dropbear-$(DROPBEAR_VERSION)/bin/dropbear
	exec rmdir $(OUTPUT)/rootfs/opt/dropbear-$(DROPBEAR_VERSION)/sbin
	exec makelinks $(OUTPUT)/rootfs /bin /opt/dropbear/bin
	exec setuidgid $(NORMALUSER) s6-touch $@
