
$(OUTPUT)/tmp/.lh_layout_copied: $(OUTPUT)/tmp/.lh_prepared layout | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec sub/layout/copylayout $(OUTPUT)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/tmp/.lh_layout_installed: $(OUTPUT)/tmp/.lh_layout_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@
