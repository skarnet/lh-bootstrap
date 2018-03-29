# The initramfs

INITRAMFS_SKARNET_LIST := background cd execlineb exit export fdclose fdmove forstdin if importas piperw pipeline redirfd s6-echo s6-mount mdevd-coldplug mdevd

$(OUTPUT)/tmp/.lh_initramfs_installed: $(OUTPUT)/tmp/.lh_layout_copied $(OUTPUT)/build-host/.lh_skarnet_installed $(OUTPUT)/initramfs/bin/kill
	for i in $(INITRAMFS_SKARNET_LIST) ; do cp -f -L $(OUTPUT)/rootfs/command/$$i $(OUTPUT)/initramfs/command/$$i ; done
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/initramfs/bin/kill: $(OUTPUT)/tmp/kill
	exec cp -f $< $@

$(OUTPUT)/tmp/kill: $(OUTPUT)/build-host/.lh_skarnet_installed sub/initramfs/kill.c $(OUTPUT)/build-host/bin/muslgcc
	exec setuidgid $(NORMALUSER) $(OUTPUT)/build-host/bin/muslgcc -O2 -pipe -s -static -fomit-frame-pointer -fno-exceptions -fno-unwind-tables -fno-asynchronous-unwind-tables -Wa,--noexecstack -fno-stack-protector -ffunction-sections -fdata-sections -Wl,--sort-section=alignment -Wl,--sort-common -Wl,--gc-sections -o $@ -I$(OUTPUT)/rootfs/package/prog/skalibs/include -L$(OUTPUT)/rootfs/package/prog/skalibs/library sub/initramfs/kill.c -lskarnet

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
