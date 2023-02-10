# Version from 2023-02-10
BUSYBOX_VERSION := 93ae7464e6e460f25b73e4ffefd2d9a6499eae30

clean-busybox:
	rm -f $(OUTPUT)/sources/.lh_bb_cloned
	rm -rf $(OUTPUT)/sources/busybox
	rm -f $(OUTPUT)/sources/.lh_bb_dled
	rm -rf $(OUTPUT)/build-$(TRIPLE)/.lh_bb_*
	rm -rf $(OUTPUT)/build-$(TRIPLE)/busybox-$(BUSYBOX_VERSION)


$(OUTPUT)/sources/.lh_bb_cloned: | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/sources/busybox
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources git clone git://git.busybox.net/busybox
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_bb_dled: $(OUTPUT)/sources/.lh_bb_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources/busybox git checkout $(BUSYBOX_VERSION)
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-$(TRIPLE)/.lh_bb_copied: $(OUTPUT)/sources/.lh_bb_dled | $(OUTPUT)/build-build/.lh_skarnet_installed $(OUTPUT)/tmp/.lh_prepared
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-$(TRIPLE)/busybox-$(BUSYBOX_VERSION)
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/busybox $(OUTPUT)/build-$(TRIPLE)/busybox-$(BUSYBOX_VERSION)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/busybox-$(BUSYBOX_VERSION)/.config: $(OUTPUT)/build-$(TRIPLE)/.lh_bb_copied sub/busybox/host-full-config | $(OUTPUT)/build-build/.lh_skarnet_installed $(OUTPUT)/tmp/.lh_prepared
ifeq ($(TARGET_STATIC),true)
	exec setuidgid $(NORMALUSER) redirfd -w 1 $@ sed -e 's/# CONFIG_STATIC is not set/CONFIG_STATIC=y/' $(WD)/sub/busybox/host-full-config
else
	exec setuidgid $(NORMALUSER) cp -f $(WD)/sub/busybox/host-full-config $@
endif

$(OUTPUT)/build-$(TRIPLE)/.lh_bb_built: $(OUTPUT)/build-$(TRIPLE)/busybox-$(BUSYBOX_VERSION)/.config $(OUTPUT)/build-$(TRIPLE)/.lh_skarnet_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	+exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/busybox-$(BUSYBOX_VERSION) $(MAKE) -j1 busybox install CROSS_COMPILE=$(TRIPLE)- CC="$(TARGET_CC)" HOSTCC="$(BUILD_CC)"
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_bb_installed: $(OUTPUT)/build-$(TRIPLE)/.lh_bb_built $(OUTPUT)/tmp/.lh_layout_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec s6-rmrf $(OUTPUT)/rootfs/opt/busybox-$(BUSYBOX_VERSION)
	exec cp -RP $(OUTPUT)/build-$(TRIPLE)/busybox-$(BUSYBOX_VERSION)/_install $(OUTPUT)/rootfs/opt/busybox-$(BUSYBOX_VERSION)
	exec makenamelink $(OUTPUT)/rootfs/opt busybox busybox-$(BUSYBOX_VERSION) $(OUTPUT)/tmp
	exec makelinks $(OUTPUT)/rootfs /bin /opt/busybox/bin
	exec makelinks $(OUTPUT)/rootfs /bin /opt/busybox/sbin
	exec setuidgid $(NORMALUSER) s6-touch $@
