# Version from 2021-02-13
BUSYBOX_VERSION := d40358a1c52079e238c48bf40bff504e55a9f758

clean-busybox:
	rm -f $(OUTPUT)/sources/.lh_bb_cloned
	rm -rf $(OUTPUT)/sources/busybox
	rm -f $(OUTPUT)/sources/.lh_bb_dled
	rm -rf $(OUTPUT)/build-host/.lh_bb_*
	rm -rf $(OUTPUT)/build-host/busybox-$(BUSYBOX_VERSION)


$(OUTPUT)/sources/.lh_bb_cloned: | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/sources/busybox
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources git clone git://git.busybox.net/busybox
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_bb_dled: $(OUTPUT)/sources/.lh_bb_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources/busybox git checkout $(BUSYBOX_VERSION)
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-host/.lh_bb_copied: $(OUTPUT)/sources/.lh_bb_dled | $(OUTPUT)/build-build/.lh_skarnet_installed $(OUTPUT)/tmp/.lh_prepared
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/busybox-$(BUSYBOX_VERSION)
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/busybox $(OUTPUT)/build-host/busybox-$(BUSYBOX_VERSION)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/busybox-$(BUSYBOX_VERSION)/.config: $(OUTPUT)/build-host/.lh_bb_copied sub/busybox/host-full-config | $(OUTPUT)/build-build/.lh_skarnet_installed $(OUTPUT)/tmp/.lh_prepared
ifeq ($(BUILD_HOST_STATIC),true)
	exec setuidgid $(NORMALUSER) redirfd -w 1 $@ sed -e 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' $(WD)/sub/busybox/host-full-config
else
	exec setuidgid $(NORMALUSER) cp -f $(WD)/sub/busybox/host-full-config $@
endif

$(OUTPUT)/build-host/.lh_bb_built: $(OUTPUT)/build-host/busybox-$(BUSYBOX_VERSION)/.config $(OUTPUT)/build-host/.lh_utmps_installed $(OUTPUT)/build-host/.lh_skalibs_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/busybox-$(BUSYBOX_VERSION) $(MAKE) -j1 busybox install CROSS_COMPILE=$(TRIPLE)- CC="$(BUILD_HOST_CC)" HOSTCC="$(BUILD_BUILD_CC)" CFLAGS="-O2 -I$(OUTPUT)/rootfs/package/admin/utmps/include" LDFLAGS="-L$(OUTPUT)/rootfs/package/admin/utmps/library -L$(OUTPUT)/rootfs/package/prog/skalibs/library" LDLIBS="-lutmps -lskarnet"
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_bb_installed: $(OUTPUT)/build-host/.lh_bb_built $(OUTPUT)/tmp/.lh_layout_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec s6-rmrf $(OUTPUT)/rootfs/opt/busybox-$(BUSYBOX_VERSION)
	exec cp -RP $(OUTPUT)/build-host/busybox-$(BUSYBOX_VERSION)/_install $(OUTPUT)/rootfs/opt/busybox-$(BUSYBOX_VERSION)
	exec makenamelink $(OUTPUT)/rootfs/opt busybox busybox-$(BUSYBOX_VERSION) $(OUTPUT)/tmp
	exec makelinks $(OUTPUT)/rootfs /bin /opt/busybox/bin
	exec makelinks $(OUTPUT)/rootfs /bin /opt/busybox/sbin
	exec setuidgid $(NORMALUSER) s6-touch $@
