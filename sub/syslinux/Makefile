LIBUUID_NAME := libuuid
LIBUUID_VERSION := 1.0.3
LIBUUID_URLDIR := http://skarnet.org/archive
LIBUUID_TAREXT := tar.gz
LIBUUID_TARLETTER := z

NASM_NAME := nasm
NASM_VERSION := 2.12.02
NASM_TAREXT := tar.xz
NASM_TARLETTER := J
NASM_URLDIR = http://www.nasm.us/pub/nasm/releasebuilds/$(NASM_VERSION)

SYSLINUX_NAME := syslinux
SYSLINUX_VERSION := 6.03
SYSLINUX_URLDIR := https://cdn.kernel.org/pub/linux/utils/boot/$(SYSLINUX_NAME)
SYSLINUX_TAREXT := tar.xz
SYSLINUX_TARLETTER := J

SYSLINUX_CFLAGS := "-I $(OUTPUT)/build-build/opt/$(LIBUUID_NAME)/include"
SYSLINUX_LDFLAGS := "-s -L $(OUTPUT)/build-build/opt/$(LIBUUID_NAME)/lib"
SYSLINUX_INSTALLROOT := $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION)



$(OUTPUT)/sources/$(LIBUUID_NAME)-$(LIBUUID_VERSION).$(LIBUUID_TAREXT): | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget $(LIBUUID_URLDIR)/$(LIBUUID_NAME)-$(LIBUUID_VERSION).$(LIBUUID_TAREXT)

$(OUTPUT)/sources/.lh_$(LIBUUID_NAME)_dled: $(OUTPUT)/sources/$(LIBUUID_NAME)-$(LIBUUID_VERSION).$(LIBUUID_TAREXT) | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/sources/$(NASM_NAME)-$(NASM_VERSION).$(NASM_TAREXT): | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget $(NASM_URLDIR)/$(NASM_NAME)-$(NASM_VERSION).$(NASM_TAREXT)

$(OUTPUT)/sources/.lh_$(NASM_NAME)_dled: $(OUTPUT)/sources/$(NASM_NAME)-$(NASM_VERSION).$(NASM_TAREXT) | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/sources/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION).$(SYSLINUX_TAREXT): | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget $(SYSLINUX_URLDIR)/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION).$(SYSLINUX_TAREXT)

$(OUTPUT)/sources/.lh_$(SYSLINUX_NAME)_dled: $(OUTPUT)/sources/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION).$(SYSLINUX_TAREXT) | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-build/.lh_$(LIBUUID_NAME)_copied: $(OUTPUT)/sources/.lh_$(LIBUUID_NAME)_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-build/opt/$(LIBUUID_NAME)-$(LIBUUID_VERSION)
	exec setuidgid $(NORMALUSER) s6-mkdir -p $(OUTPUT)/build-build/opt/$(LIBUUID_NAME)-$(LIBUUID_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(LIBUUID_NAME)-$(LIBUUID_VERSION) tar $(LIBUUID_TARLETTER)xpvf $(OUTPUT)/sources/$(LIBUUID_NAME)-$(LIBUUID_VERSION).$(LIBUUID_TAREXT)
	exec setuidgid $(NORMALUSER) s6-rename $(OUTPUT)/build-build/opt/$(LIBUUID_NAME)-$(LIBUUID_VERSION)/$(LIBUUID_NAME)-$(LIBUUID_VERSION) $(OUTPUT)/build-build/opt/$(LIBUUID_NAME)-$(LIBUUID_VERSION)/src
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(LIBUUID_NAME)_configured: $(OUTPUT)/build-build/.lh_$(LIBUUID_NAME)_copied $(OUTPUT)/build-build/.lh_gcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(LIBUUID_NAME)-$(LIBUUID_VERSION)/src ./configure --prefix=$(OUTPUT)/build-build/opt/$(LIBUUID_NAME)-$(LIBUUID_VERSION) --enable-static --disable-shared
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(LIBUUID_NAME)_built: $(OUTPUT)/build-build/.lh_$(LIBUUID_NAME)_configured $(OUTPUT)/build-build/.lh_gcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(LIBUUID_NAME)-$(LIBUUID_VERSION)/src $(MAKE)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(LIBUUID_NAME)_installed: $(OUTPUT)/build-build/.lh_$(LIBUUID_NAME)_built $(OUTPUT)/build-build/.lh_gcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(LIBUUID_NAME)-$(LIBUUID_VERSION)/src $(MAKE) install
	exec setuidgid $(NORMALUSER) makenamelink $(OUTPUT)/build-build/opt $(LIBUUID_NAME) $(LIBUUID_NAME)-$(LIBUUID_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-build/.lh_$(NASM_NAME)_copied: $(OUTPUT)/sources/.lh_$(NASM_NAME)_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-build/opt/$(NASM_NAME)-$(NASM_VERSION)
	exec setuidgid $(NORMALUSER) s6-mkdir -p $(OUTPUT)/build-build/opt/$(NASM_NAME)-$(NASM_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(NASM_NAME)-$(NASM_VERSION) tar $(NASM_TARLETTER)xpvf $(OUTPUT)/sources/$(NASM_NAME)-$(NASM_VERSION).$(NASM_TAREXT)
	exec setuidgid $(NORMALUSER) s6-rename $(OUTPUT)/build-build/opt/$(NASM_NAME)-$(NASM_VERSION)/$(NASM_NAME)-$(NASM_VERSION) $(OUTPUT)/build-build/opt/$(NASM_NAME)-$(NASM_VERSION)/src
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(NASM_NAME)_configured: $(OUTPUT)/build-build/.lh_$(NASM_NAME)_copied $(OUTPUT)/build-build/.lh_gcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(NASM_NAME)-$(NASM_VERSION)/src ./configure --prefix=$(OUTPUT)/build-build/opt/$(NASM_NAME)-$(NASM_VERSION)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(NASM_NAME)_built: $(OUTPUT)/build-build/.lh_$(NASM_NAME)_copied $(OUTPUT)/build-build/.lh_gcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(NASM_NAME)-$(NASM_VERSION)/src $(MAKE)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(NASM_NAME)_installed: $(OUTPUT)/build-build/.lh_$(NASM_NAME)_built $(OUTPUT)/build-build/.lh_gcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(NASM_NAME)-$(NASM_VERSION)/src $(MAKE) install
	exec setuidgid $(NORMALUSER) makenamelink $(OUTPUT)/build-build/opt $(NASM_NAME) $(NASM_NAME)-$(NASM_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-build/.lh_$(SYSLINUX_NAME)_copied: $(OUTPUT)/sources/.lh_$(SYSLINUX_NAME)_dled sub/syslinux/syslinux-extraflags.patch sub/syslinux/syslinux-gcc5-1.patch sub/syslinux/syslinux-gcc5-2.patch sub/syslinux/syslinux-gcc5-3.patch sub/syslinux/syslinux-inttypes.patch sub/syslinux/syslinux-oknogit.patch | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION)
	exec setuidgid $(NORMALUSER) s6-mkdir -p $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION)
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION) tar $(SYSLINUX_TARLETTER)xpvf $(OUTPUT)/sources/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION).$(SYSLINUX_TAREXT)
	exec setuidgid $(NORMALUSER) s6-rename $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION)/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION) $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION)/src
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION)/src redirfd -r 0 $(WD)/sub/syslinux/syslinux-extraflags.patch patch -p1
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION)/src redirfd -r 0 $(WD)/sub/syslinux/syslinux-gcc5-1.patch patch -p1
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION)/src redirfd -r 0 $(WD)/sub/syslinux/syslinux-gcc5-2.patch patch -p1
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION)/src redirfd -r 0 $(WD)/sub/syslinux/syslinux-gcc5-3.patch patch -p1
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION)/src redirfd -r 0 $(WD)/sub/syslinux/syslinux-inttypes.patch patch -p1
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION)/src redirfd -r 0 $(WD)/sub/syslinux/syslinux-oknogit.patch patch -p1
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(SYSLINUX_NAME)_built: $(OUTPUT)/build-build/.lh_$(SYSLINUX_NAME)_copied $(OUTPUT)/build-build/.lh_$(LIBUUID_NAME)_installed $(OUTPUT)/build-build/.lh_gcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(SYSLINUX_NAME)-$(SYSLINUX_VERSION)/src export INSTALLROOT $(SYSLINUX_INSTALLROOT) export EXTRA_CFLAGS $(SYSLINUX_CFLAGS) export EXTRA_LDFLAGS $(SYSLINUX_LDFLAGS) if $(MAKE) clean "" if $(MAKE) installer "" make install
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(SYSLINUX_NAME)_installed: $(OUTPUT)/build-build/.lh_$(SYSLINUX_NAME)_built $(OUTPUT)/build-build/.lh_gcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) makenamelink $(OUTPUT)/build-build/opt $(SYSLINUX_NAME) $(SYSLINUX_NAME)-$(SYSLINUX_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) makelinks $(OUTPUT)/build-build /bin /opt/$(SYSLINUX_NAME)/sbin
	exec setuidgid $(NORMALUSER) s6-touch $@
