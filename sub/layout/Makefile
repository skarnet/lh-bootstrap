
$(OUTPUT)/tmp/.lh_layout_copied: $(OUTPUT)/tmp/.lh_prepared layout | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec sub/layout/copylayout $(OUTPUT)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/tmp/.lh_layout_s6rcdb_made: $(OUTPUT)/tmp/.lh_layout_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	stamp=$$(s6-clock) && s6-rc-compile -v2 -h sysfdh $(OUTPUT)/rootfs/etc/s6-rc/compiled-$$stamp $(OUTPUT)/rootfs/etc/s6-rc/source-base && s6-ln -s compiled-$$stamp $(OUTPUT)/rootfs/etc/s6-rc/compiled.new && s6-rename $(OUTPUT)/rootfs/etc/s6-rc/compiled.new $(OUTPUT)/rootfs/etc/s6-rc/compiled
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/tmp/.lh_layout_installed: $(OUTPUT)/tmp/.lh_layout_copied $(OUTPUT)/tmp/.lh_layout_s6rcdb_made | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@
