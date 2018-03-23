include sub/dropbear/Makefile.sftp-server

DROPBEAR_VERSION ?= 2018.76


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

$(OUTPUT)/build-host/.lh_dropbear_configured: $(OUTPUT)/build-host/.lh_dropbear_patched $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/dropbear-$(DROPBEAR_VERSION) export ARCH $(KERNEL_ARCH) export CC $(TRIPLE)-muslgcc export LDFLAGS '-s -static' ./configure --host=$(TRIPLE) --prefix=/opt/dropbear-$(DROPBEAR_VERSION) --disable-syslog --disable-lastlog --disable-utmp --disable-utmpx --disable-wtmp --disable-wtmpx --disable-pututline --disable-pututxline --without-pam --enable-bundled-libtom --disable-zlib --enable-static
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_dropbear_built: $(OUTPUT)/build-host/.lh_dropbear_configured $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/dropbear-$(DROPBEAR_VERSION) export PROGRAMS "dropbear dbclient dropbearkey dropbearconvert scp" $(MAKE) ARCH=$(KERNEL_ARCH)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_dropbear_installed: $(OUTPUT)/build-host/.lh_dropbear_built $(OUTPUT)/build-host/$(OPENSSH_NAME)-$(OPENSSH_VERSION)/sftp-server $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/dropbear-$(DROPBEAR_VERSION) $(MAKE) install DESTDIR=$(OUTPUT)/rootfs
	exec makenamelink $(OUTPUT)/rootfs/opt dropbear dropbear-$(DROPBEAR_VERSION) $(OUTPUT)/tmp
	exec cp -f $(OUTPUT)/build-host/dropbear-$(DROPBEAR_VERSION)/scp $(OUTPUT)/rootfs/opt/dropbear-$(DROPBEAR_VERSION)/bin/scp
	exec makelinks $(OUTPUT)/rootfs /bin /opt/dropbear/bin
	exec makelinks $(OUTPUT)/rootfs /bin /opt/dropbear/sbin
	# The following line happens after the makelinks on purpose: we don't want the sftp-server binary to be exported to /bin
	exec cp -f $(OUTPUT)/build-host/$(OPENSSH_NAME)-$(OPENSSH_VERSION)/sftp-server $(OUTPUT)/rootfs/opt/dropbear-$(DROPBEAR_VERSION)/bin/sftp-server
	exec setuidgid $(NORMALUSER) s6-touch $@
