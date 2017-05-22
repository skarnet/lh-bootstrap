# The initramfs

INITRAMFS_SKARNET_LIST := cd execlineb export if redirfd s6-echo s6-mount

$(OUTPUT)/tmp/.lh_initramfs_installed: $(OUTPUT)/tmp/.lh_layout_copied $(OUTPUT)/build-host/.lh_skarnet_installed $(OUTPUT)/build-host/.lh_mdev_installed
	for i in $(INITRAMFS_SKARNET_LIST) ; do cp -f -L $(OUTPUT)/rootfs/command/$$i $(OUTPUT)/initramfs/command/$$i ; done
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/initramfs.img.gz: $(OUTPUT)/tmp/.lh_initramfs_installed
	cd $(OUTPUT)/initramfs && find . | cpio -o --format=newc > ../initramfs.img && cd .. && rm -f $@ && gzip -9 initramfs.img

$(OUTPUT)/rootfs/boot/initramfs.gz: $(OUTPUT)/initramfs.img.gz | $(OUTPUT)/build-build/.lh_skarnet_installed $(OUTPUT)/tmp/.lh_layout_copied
	exec cp -f $(OUTPUT)/initramfs.img.gz $(OUTPUT)/rootfs/boot/initramfs-$(KERNEL_VERSION).gz
	exec s6-ln -sf initramfs-$(KERNEL_VERSION).gz $@

ifeq ($(KERNEL_GENERIC_ARCH),x86)
$(OUTPUT)/tmp/.lh_initramfs_done: $(OUTPUT)/rootfs/boot/initramfs.gz
else
$(OUTPUT)/tmp/.lh_initramfs_done: $(OUTPUT)/initramfs.img.gz
endif
	exec setuidgid $(NORMALUSER) touch $@
