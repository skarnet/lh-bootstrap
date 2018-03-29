
UTLX_NAME := util-linux
UTLX_VERSION := 2.32
UTLX_MAJOR := $(word 1, $(subst ., ,$(UTLX_VERSION)))
UTLX_MINOR := $(word 2, $(subst ., ,$(UTLX_VERSION)))
UTLX_URLDIR := https://cdn.kernel.org/pub/linux/utils/$(UTLX_NAME)/v$(UTLX_MAJOR).$(UTLX_MINOR)
UTLX_TAREXT := tar.xz
UTLX_TARLETTER := J
UTLX_CONFIGURE_OPTIONS := \
--prefix=$(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION) \
--disable-assert \
--disable-nls \
--disable-widechar \
# --disable-all-programs \
--enable-libuuid \
--enable-libfdisk \
--enable-libsmartcols \
--enable-losetup \
--enable-libblkid \
--enable-libmount \
--enable-mount \
--disable-zramctl \
--disable-fsck \
--disable-partx \
--disable-uuidd \
--disable-mountpoint \
--disable-fallocate \
--disable-unshare \
--disable-nsenter \
--disable-setpriv \
--disable-eject \
--disable-agetty \
--disable-plymouth-support \
--disable-cramfs \
--disable-bfs \
--disable-minix \
--disable-fdformat \
--disable-hwclock \
--disable-lslogins \
--disable-wdctl \
--disable-cal \
--disable-logger \
--disable-switch_root \
--disable-pivot_root \
--disable-lsmem \
--disable-chmem \
--disable-ipcrm \
--disable-ipcs \
--disable-rfkill \
--disable-tunelp \
--disable-kill \
--disable-last \
--disable-utmpdump \
--disable-line \
--disable-mesg \
--disable-raw \
--disable-rename \
--disable-vipw \
--disable-newgrp \
--disable-chfn-chsh \
--disable-login \
--disable-nologin \
--disable-sulogin \
--disable-su \
--disable-runuser \
--disable-ul \
--disable-more \
--disable-pg \
--disable-setterm \
--disable-schedutils \
--disable-wall \
--disable-write \
--disable-bash-completion \
--disable-pylibmount \
--disable-pg-bell \
--disable-sulogin-emergency-mount \
--disable-makeinstall-chown \
--disable-makeinstall-setuid \
--disable-use-tty-group \
--disable-colors-default \
--with-gnu-ld \
--without-util \
--without-libiconv-prefix \
--without-selinux \
--without-audit \
--without-udev \
--without-user \
--without-python \
--without-ncurses \
--without-ncursesw \
--without-slang \
--without-tinfo \
--without-readline \
--without-utempter \
--without-cap-ng \
--without-user \
--without-btrfs \
--without-systemd \
--without-smack

UTLX_CFLAGS := ""
UTLX_CONFLDFLAGS := ""
UTLX_MAKELDFLAGS := "-s"

$(OUTPUT)/sources/$(UTLX_NAME)-$(UTLX_VERSION).$(UTLX_TAREXT): | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget $(UTLX_URLDIR)/$(UTLX_NAME)-$(UTLX_VERSION).$(UTLX_TAREXT)

$(OUTPUT)/sources/.lh_$(UTLX_NAME)_dled: $(OUTPUT)/sources/$(UTLX_NAME)-$(UTLX_VERSION).$(UTLX_TAREXT)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(UTLX_NAME)_copied: $(OUTPUT)/sources/.lh_$(UTLX_NAME)_dled sub/util-linux/nowall.patch | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/src
	exec setuidgid $(NORMALUSER) s6-mkdir -p $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)
	exec setuidgid $(NORMALUSER) makenamelink $(OUTPUT)/build-build/opt $(UTLX_NAME) $(UTLX_NAME)-$(UTLX_VERSION) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION) tar $(UTLX_TARLETTER)xpvf $(OUTPUT)/sources/$(UTLX_NAME)-$(UTLX_VERSION).$(UTLX_TAREXT)
	exec setuidgid $(NORMALUSER) s6-rename $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/$(UTLX_NAME)-$(UTLX_VERSION) $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/src
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION) redirfd -r 0 $(WD)/sub/util-linux/nowall.patch patch -p1
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(UTLX_NAME)_configured: $(OUTPUT)/build-build/.lh_$(UTLX_NAME)_copied $(OUTPUT)/build-build/.lh_kernel_headers_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/src export CFLAGS $(UTLX_CFLAGS) export LDFLAGS $(UTLX_CONFLDFLAGS) ./configure --prefix=$(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION) $(UTLX_CONFIGURE_OPTIONS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(UTLX_NAME)_built: $(OUTPUT)/build-build/.lh_$(UTLX_NAME)_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/src $(MAKE) LDFLAGS=$(UTLX_MAKELDFLAGS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-build/.lh_$(UTLX_NAME)_installed: $(OUTPUT)/build-build/.lh_$(UTLX_NAME)_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-build/opt/$(UTLX_NAME)-$(UTLX_VERSION)/src $(MAKE) install
	exec setuidgid $(NORMALUSER) makelinks $(OUTPUT)/build-build /bin /opt/$(UTLX_NAME)/bin
	exec setuidgid $(NORMALUSER) makelinks $(OUTPUT)/build-build /bin /opt/$(UTLX_NAME)/sbin
	exec setuidgid $(NORMALUSER) s6-touch $@
