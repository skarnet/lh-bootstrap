
DROPBEAR_VERSION ?= 2022.83
DROPBEAR_CONF_STATIC := $(if $(filter true,$(TARGET_STATIC)),--enable-static,)
DROPBEAR_MAKE_STATIC := $(if $(filter true,$(TARGET_STATIC)),-static,)

clean-dropbear:
	rm -f $(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_*
	

$(OUTPUT)/sources/dropbear-$(DROPBEAR_VERSION).tar.bz2: | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget https://dropbear.nl/mirror/dropbear-$(DROPBEAR_VERSION).tar.bz2

$(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_dled: $(OUTPUT)/sources/dropbear-$(DROPBEAR_VERSION).tar.bz2 | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_copied: $(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-$(TRIPLE)/dropbear-$(DROPBEAR_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE) tar -jxpvf $(OUTPUT)/sources/dropbear-$(DROPBEAR_VERSION).tar.bz2
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_patched: $(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_copied sub/dropbear/localoptions.h
	exec setuidgid $(NORMALUSER) cp -f sub/dropbear/localoptions.h $(OUTPUT)/build-$(TRIPLE)/dropbear-$(DROPBEAR_VERSION)/localoptions.h
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_configured: $(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_patched $(OUTPUT)/build-$(TRIPLE)/.lh_utmps_installed $(OUTPUT)/build-$(TRIPLE)/.lh_skalibs_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/dropbear-$(DROPBEAR_VERSION) export ARCH $(KERNEL_ARCH) export CC "$(TARGET_CC)" export CFLAGS "-O2 -I$(OUTPUT)/rootfs/package/admin/utmps/include" export LDFLAGS "-s $(DROPBEAR_MAKE_STATIC) -L$(OUTPUT)/rootfs/package/admin/utmps/library -L$(OUTPUT)/rootfs/package/prog/skalibs/library" export LIBS "-lutmps -lskarnet" ./configure --host=$(TRIPLE) --prefix=/opt/dropbear-$(DROPBEAR_VERSION) --disable-syslog --disable-utmp --disable-wtmp --disable-pututline --without-pam --enable-bundled-libtom --disable-zlib --disable-harden $(DROPBEAR_CONF_STATIC)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_built: $(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/dropbear-$(DROPBEAR_VERSION) $(MAKE) ARCH=$(KERNEL_ARCH) PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp"
	exec setuidgid $(NORMALUSER) s6-touch $@
	
$(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_installed: $(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-$(TRIPLE)/dropbear-$(DROPBEAR_VERSION) $(MAKE) install DESTDIR=$(OUTPUT)/rootfs
	exec makenamelink $(OUTPUT)/rootfs/opt dropbear dropbear-$(DROPBEAR_VERSION) $(OUTPUT)/tmp
	exec cp -f $(OUTPUT)/build-$(TRIPLE)/dropbear-$(DROPBEAR_VERSION)/scp $(OUTPUT)/rootfs/opt/dropbear-$(DROPBEAR_VERSION)/bin/scp
	exec mv -f $(OUTPUT)/rootfs/opt/dropbear-$(DROPBEAR_VERSION)/sbin/dropbear $(OUTPUT)/rootfs/opt/dropbear-$(DROPBEAR_VERSION)/bin/dropbear
	exec rmdir $(OUTPUT)/rootfs/opt/dropbear-$(DROPBEAR_VERSION)/sbin
	exec makelinks $(OUTPUT)/rootfs /bin /opt/dropbear/bin
	exec setuidgid $(NORMALUSER) s6-touch $@
