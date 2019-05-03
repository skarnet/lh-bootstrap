# Version from 2019-05-03
BUSYBOX_VERSION := 3106784e654e7443ab724d927f9de0230adbe5ac

clean-busybox:
	rm -f $(OUTPUT)/sources/.lh_bb_cloned
	rm -rf $(OUTPUT)/sources/busybox
	rm -f $(OUTPUT)/sources/.lh_bb_dled
	rm -rf $(OUTPUT)/build-host/.lh_bb_*
	rm -rf $(OUTPUT)/build-host/busybox-$(BUSYBOX_VERSION)
	rm -f $(OUTPUT)/build-host/bbsuid.c $(OUTPUT)/build-host/bbsuid $(OUTPUT)/build-host/.lh_bbsuid_installed


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
	exec setuidgid $(NORMALUSER) cp -f $(WD)/sub/busybox/host-full-config $@

$(OUTPUT)/build-host/.lh_bb_built: $(OUTPUT)/build-host/busybox-$(BUSYBOX_VERSION)/.config $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/busybox-$(BUSYBOX_VERSION) $(MAKE) -j1 busybox install CROSS_COMPILE=$(TRIPLE)- CC=$(TRIPLE)-muslgcc
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_bb_installed: $(OUTPUT)/build-host/.lh_bb_built $(OUTPUT)/build-host/bin/muslgcc $(OUTPUT)/tmp/.lh_layout_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec s6-rmrf $(OUTPUT)/rootfs/opt/busybox-$(BUSYBOX_VERSION)
	exec cp -RP $(OUTPUT)/build-host/busybox-$(BUSYBOX_VERSION)/_install $(OUTPUT)/rootfs/opt/busybox-$(BUSYBOX_VERSION)
	exec makenamelink $(OUTPUT)/rootfs/opt busybox busybox-$(BUSYBOX_VERSION) $(OUTPUT)/tmp
	exec makelinks $(OUTPUT)/rootfs /bin /opt/busybox/bin
	exec makelinks $(OUTPUT)/rootfs /bin /opt/busybox/sbin
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/bbsuid.c: sub/busybox/SUIDLIST sub/busybox/bbsuid-header sub/busybox/bbsuid-footer | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) redirfd -w 1 $@ foreground cat sub/busybox/bbsuid-header "" foreground sed s/.*/\"\&\",/ sub/busybox/SUIDLIST "" cat sub/busybox/bbsuid-footer

$(OUTPUT)/build-host/bbsuid: $(OUTPUT)/build-host/bbsuid.c $(OUTPUT)/build-host/bin/muslgcc $(OUTPUT)/build-host/.lh_skalibs_installed
	exec setuidgid $(NORMALUSER) muslgcc -static -o $@ -I $(OUTPUT)/rootfs/package/prog/skalibs/include -L $(OUTPUT)/rootfs/package/prog/skalibs/library $(OUTPUT)/build-host/bbsuid.c -lskarnet

$(OUTPUT)/build-host/.lh_bbsuid_installed: sub/busybox/SUIDLIST $(OUTPUT)/build-host/bbsuid $(OUTPUT)/build-host/.lh_bb_installed | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec sub/busybox/install-bbsuid $(OUTPUT) sub/busybox/SUIDLIST
	exec setuidgid $(NORMALUSER) s6-touch $@
