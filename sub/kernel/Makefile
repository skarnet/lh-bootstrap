include sub/kernel/Makefile.ncurses

KERNEL_VERSION ?= 6.6
KERNEL_MAJOR := $(firstword $(subst ., ,$(KERNEL_VERSION)))
KERNEL_FULLVERSION := $(if $(word 2,$(subst ., ,$(KERNEL_VERSION))),$(KERNEL_VERSION),$(KERNEL_VERSION).0)

KERNEL_ENV := HOSTCC=$(BUILD_CC) DEPMOD=$(OUTPUT)/build-build/opt/kmod/bin/depmod INSTALL_MOD_PATH=$(OUTPUT)/rootfs CROSS_COMPILE=$(TARGET_PREFIX)- ARCH=$(KERNEL_GENERIC_ARCH) INSTALL_MOD_STRIP="-R .note -R .comment --strip-debug" HOST_LFS_CFLAGS= HOST_LFS_LDFLAGS= HOST_LFS_LIBS=

$(OUTPUT)/sources/linux-$(KERNEL_VERSION).tar.xz: | $(OUTPUT)/tmp/.lh_prepared
	cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) wget https://cdn.kernel.org/pub/linux/kernel/v$(KERNEL_MAJOR).x/linux-$(KERNEL_VERSION).tar.xz

$(OUTPUT)/build-build/.lh_kernel_unpacked: $(OUTPUT)/sources/linux-$(KERNEL_VERSION).tar.xz sub/kernel
	exec setuidgid $(NORMALUSER) mkdir -p $(OUTPUT)/build-build/opt/linux-$(KERNEL_VERSION)
	exec setuidgid $(NORMALUSER) makenamelink $(OUTPUT)/build-build/opt linux linux-$(KERNEL_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) rm -rf $(OUTPUT)/build-build/opt/linux-$(KERNEL_VERSION)/src $(OUTPUT)/build-build/opt/linux-$(KERNEL_VERSION)/linux-$(KERNEL_VERSION)
	cd $(OUTPUT)/build-build/opt/linux-$(KERNEL_VERSION) && setuidgid $(NORMALUSER) tar Jxpvf $(OUTPUT)/sources/linux-$(KERNEL_VERSION).tar.xz
	exec setuidgid $(NORMALUSER) mv -f $(OUTPUT)/build-build/opt/linux-$(KERNEL_VERSION)/linux-$(KERNEL_VERSION) $(OUTPUT)/build-build/opt/linux-$(KERNEL_VERSION)/src
	exec setuidgid $(NORMALUSER) sh -c 'for i in `ls -1 sub/kernel | grep "\.patch$$"` ; do patch -d $(OUTPUT)/build-build/opt/linux-$(KERNEL_VERSION)/src -p1 < sub/kernel/$$i ; done'
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_kernel_headers_installed: $(OUTPUT)/build-build/.lh_kernel_unpacked
	cd $(OUTPUT)/build-build/opt/linux-$(KERNEL_VERSION)/src && setuidgid $(NORMALUSER) $(MAKE) headers_install INSTALL_HDR_PATH=$(OUTPUT)/build-build/opt/linux-$(KERNEL_VERSION)
	exec setuidgid $(NORMALUSER) touch $@
	
	
$(OUTPUT)/build-$(TRIPLE)/kernel/.lh_unpacked: $(OUTPUT)/sources/linux-$(KERNEL_VERSION).tar.xz | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-mkdir -p $(OUTPUT)/build-$(TRIPLE)/kernel
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/kernel tar Jxpvf $(OUTPUT)/sources/linux-$(KERNEL_VERSION).tar.xz
	exec setuidgid $(NORMALUSER) sh -c 'for i in `ls -1 sub/kernel | grep "\.patch$$"` ; do patch -d $(OUTPUT)/build-$(TRIPLE)/kernel/linux-$(KERNEL_VERSION) -p1 < sub/kernel/$$i ; done'
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/kernel/.lh_configured: $(OUTPUT)/build-$(TRIPLE)/kernel/.lh_unpacked $(KERNEL_CONFIG) | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cp -f $(KERNEL_CONFIG) $(OUTPUT)/build-$(TRIPLE)/kernel/linux-$(KERNEL_VERSION)/.config
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/kernel/linux-$(KERNEL_VERSION) $(MAKE) olddefconfig $(KERNEL_ENV)
	exec setuidgid $(NORMALUSER) s6-touch $@

kernel-menuconfig: $(OUTPUT)/build-$(TRIPLE)/kernel/.lh_configured $(OUTPUT)/build-build/.lh_$(NCURSES_NAME)_installed | $(OUTPUT)/build-build/.lh_skarnet_installed $(WD)/bin/fake-pkg-config
	exec setuidgid $(NORMALUSER) s6-ln -nsf $(WD)/bin/fake-pkg-config $(OUTPUT)/build-build/bin/pkg-config
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/kernel/linux-$(KERNEL_VERSION) $(MAKE) menuconfig $(KERNEL_ENV)
	exec setuidgid $(NORMALUSER) rm -f $(OUTPUT)/build-build/bin/pkg-config

$(OUTPUT)/build-$(TRIPLE)/kernel/.lh_prepared: | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec s6-mkdir -p $(OUTPUT)/rootfs/opt/linux-kernel-headers-$(KERNEL_VERSION)
	exec makenamelink $(OUTPUT)/rootfs/opt linux-kernel-headers linux-kernel-headers-$(KERNEL_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) s6-mkdir -p $(OUTPUT)/build-$(TRIPLE)/kernel
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/kernel/.lh_headers_installed: $(OUTPUT)/build-$(TRIPLE)/kernel/.lh_prepared $(OUTPUT)/build-$(TRIPLE)/kernel/.lh_built | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-$(TRIPLE)/kernel/linux-$(KERNEL_VERSION) $(MAKE) headers_install $(KERNEL_ENV) INSTALL_HDR_PATH=$(OUTPUT)/rootfs/opt/linux-kernel-headers-$(KERNEL_VERSION)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/kernel/.lh_built: $(OUTPUT)/build-$(TRIPLE)/kernel/.lh_configured | $(OUTPUT)/build-build/.lh_kmod_installed $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/kernel/linux-$(KERNEL_VERSION) $(MAKE) modules_prepare $(KERNEL_ENV)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-$(TRIPLE)/kernel/linux-$(KERNEL_VERSION) $(MAKE) all $(KERNEL_ENV)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/kernel/.lh_installed: $(OUTPUT)/build-$(TRIPLE)/kernel/.lh_built | $(OUTPUT)/tmp/.lh_layout_installed $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cp -f $(OUTPUT)/build-$(TRIPLE)/kernel/linux-$(KERNEL_VERSION)/System.map $(OUTPUT)/rootfs/boot/System.map-$(KERNEL_VERSION)
	exec s6-ln -sf System.map-$(KERNEL_VERSION) $(OUTPUT)/rootfs/boot/System.map
	cp -f $(OUTPUT)/build-$(TRIPLE)/kernel/linux-$(KERNEL_VERSION)/arch/$(KERNEL_GENERIC_ARCH)/boot/bzImage $(OUTPUT)/kernel || cp -f $(OUTPUT)/build-$(TRIPLE)/kernel/linux-$(KERNEL_VERSION)/arch/$(KERNEL_GENERIC_ARCH)/boot/zImage $(OUTPUT)/kernel || cp -f $(OUTPUT)/build-$(TRIPLE)/kernel/linux-$(KERNEL_VERSION)/arch/$(KERNEL_GENERIC_ARCH)/boot/Image $(OUTPUT)/kernel
ifeq ($(KERNEL_GENERIC_ARCH),x86)
	exec cp -f $(OUTPUT)/kernel $(OUTPUT)/rootfs/boot/vmlinuz-$(KERNEL_VERSION)
	exec s6-ln -sf vmlinuz-$(KERNEL_VERSION) $(OUTPUT)/rootfs/boot/vmlinuz
endif
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-$(TRIPLE)/kernel/.lh_modules_installed: $(OUTPUT)/build-$(TRIPLE)/kernel/.lh_built | $(OUTPUT)/build-build/.lh_kmod_installed $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-$(TRIPLE)/kernel/linux-$(KERNEL_VERSION) $(MAKE) modules_install $(KERNEL_ENV)
	exec s6-rmrf $(OUTPUT)/rootfs/lib/modules/$(KERNEL_FULLVERSION)/build $(OUTPUT)/rootfs/lib/modules/$(KERNEL_FULLVERSION)/source
	exec setuidgid $(NORMALUSER) s6-touch $@
