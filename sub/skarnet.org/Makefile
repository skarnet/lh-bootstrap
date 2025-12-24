
# SKALIBS_VERSION := a7a811f80956aac8e5cee56f72aa63558c5dc544
SKALIBS_VERSION := v2.14.5.0

# NSSS_VERSION := 9505a88682b9dbbdf4e6afd60cde94e5be197886
NSSS_VERSION := v0.2.1.1

# UTMPS_VERSION := c79ac86f0c819340d4a56b2151fb4808b6356d7f
UTMPS_VERSION := v0.1.3.2

# EXECLINE_VERSION := 588cf3120765c542020ba6a9504d0cdbd3b82afd
EXECLINE_VERSION := v2.9.8.0

# S6_VERSION := 89a629b874e129397c248924d43fd67a45224155
S6_VERSION := v2.14.0.0

S6_RC_VERSION := 84ed647a78bb7a90582c2a1d7a68aaf8db3b296d
# S6_RC_VERSION := v0.6.0.0

# S6_LINUX_INIT_VERSION := fef5a089c5fd31fad9b915d73df70e9e8f0a3c02
S6_LINUX_INIT_VERSION := v1.2.0.0

S6_FRONTEND_VERSION := d831d111b8176875cd0e83de798d6c3f5ec593c6
# S6_FRONTEND_VERSION := v0.0.1.0

# S6_PORTABLE_UTILS_VERSION := 93f521eb8c444dea0ae297e9f961a950c93d9575
S6_PORTABLE_UTILS_VERSION := v2.3.1.1

# S6_LINUX_UTILS_VERSION := 6623b6180743596f083e21d319b42f8456975a1d
S6_LINUX_UTILS_VERSION := v2.6.4.0

# S6_DNS_VERSION := 8b27fed89fe3607e0bbfb86f93c51888deade6e7
S6_DNS_VERSION := v2.4.1.1

# S6_NETWORKING_VERSION := f9dd94e40b93bc3b68f951317919c99ea2cb62c5
S6_NETWORKING_VERSION := v2.7.2.0

# MDEVD_VERSION := be99b4554611b44acc6a3501843aa8af086c073c
MDEVD_VERSION := v0.1.8.0

# TIPIDEE_VERSION := 0c8c659e9e3c7e0378562b8ddc4583ca6431a2c7
TIPIDEE_VERSION := v0.0.7.0

# SHIBARI_VERSION := 209cca0b20e4e4a74bab8378502cd3028d8afa51
SHIBARI_VERSION := v0.0.2.1

# BCNM_VERSION := fad1291d004397261db645293e9a45676015b863
BCNM_VERSION := v0.0.2.1

# DNSFUNNEL_VERSION := 51030e93f82f02418e3dabca6afea37b14cac36a
DNSFUNNEL_VERSION := v0.0.3.1

# APASTE_VERSION := b829fb79265869563408e97dcd45049112824fad
APASTE_VERSION := v0.0.3.1

SKAWARE := SKALIBS NSSS UTMPS EXECLINE S6 S6_RC S6_LINUX_INIT S6_PORTABLE_UTILS S6_LINUX_UTILS S6_DNS S6_NETWORKING MDEVD TIPIDEE SHIBARI BCNM DNSFUNNEL APASTE S6_FRONTEND
SKAWARE_BUILD := SKALIBS NSSS UTMPS EXECLINE S6 S6_RC S6_LINUX_INIT S6_PORTABLE_UTILS S6_LINUX_UTILS

SKALIBS_DEPENDENCIES :=
NSSS_DEPENDENCIES := SKALIBS
UTMPS_DEPENDENCIES := SKALIBS NSSS
EXECLINE_DEPENDENCIES := SKALIBS NSSS
S6_DEPENDENCIES := SKALIBS EXECLINE NSSS
S6_RC_DEPENDENCIES := SKALIBS EXECLINE S6
S6_LINUX_INIT_DEPENDENCIES := SKALIBS NSSS UTMPS EXECLINE S6
S6_FRONTEND_DEPENDENCIES := SKALIBS NSSS EXECLINE S6 S6_RC S6_LINUX_INIT
S6_PORTABLE_UTILS_DEPENDENCIES := SKALIBS
S6_LINUX_UTILS_DEPENDENCIES := SKALIBS NSSS EXECLINE
S6_DNS_DEPENDENCIES := SKALIBS
S6_NETWORKING_DEPENDENCIES := SKALIBS NSSS EXECLINE S6 S6_DNS
MDEVD_DEPENDENCIES := SKALIBS NSSS
TIPIDEE_DEPENDENCIES := SKALIBS
SHIBARI_DEPENDENCIES := SKALIBS S6 S6_DNS
BCNM_DEPENDENCIES := SKALIBS
DNSFUNNEL_DEPENDENCIES := SKALIBS S6_DNS
APASTE_DEPENDENCIES := SKALIBS S6_NETWORKING

SKALIBS_CATEGORY := prog
NSSS_CATEGORY := admin
UTMPS_CATEGORY := admin
EXECLINE_CATEGORY := admin
S6_CATEGORY := admin
S6_RC_CATEGORY := admin
S6_LINUX_INIT_CATEGORY := admin
S6_FRONTEND_CATEGORY := admin
S6_PORTABLE_UTILS_CATEGORY := admin
S6_LINUX_UTILS_CATEGORY := admin
S6_DNS_CATEGORY := web
S6_NETWORKING_CATEGORY := net
MDEVD_CATEGORY := admin
TIPIDEE_CATEGORY := web
SHIBARI_CATEGORY := web
BCNM_CATEGORY := admin
DNSFUNNEL_CATEGORY := web
APASTE_CATEGORY := web

SKALIBS_TOKEN := libskarnet.a.xyzzy
NSSS_TOKEN := nsssd-unix
UTMPS_TOKEN := utmps-utmpd
EXECLINE_TOKEN := execline
S6_TOKEN := s6-supervise
S6_RC_TOKEN := s6-rc
S6_LINUX_INIT_TOKEN := s6-linux-init-maker
S6_FRONTEND_TOKEN := s6-frontend
S6_PORTABLE_UTILS_TOKEN := s6-portable-utils
S6_LINUX_UTILS_TOKEN := s6-linux-utils
S6_DNS_TOKEN := s6-dnsip
S6_NETWORKING_TOKEN := s6-tlsd-io
MDEVD_TOKEN := mdevd
TIPIDEE_TOKEN := tipideed
SHIBARI_TOKEN := shibari-server-udp
BCNM_TOKEN := bcnm-waitif
DNSFUNNEL_TOKEN := dnsfunneld
APASTE_TOKEN := apaste

SKAWARE_ENV := $(if $(filter true,$(TARGET_STATIC)),,env LDFLAGS=-Wl,-rpath-link,$(OUTPUT)/rootfs/library.so)
SKAWARE_OPTIONS := --enable-slashpackage --enable-nsss --enable-pkgconfig $(if $(filter true,$(TARGET_STATIC)),--enable-static-libc --disable-shared,--enable-shared --disable-allstatic)
SKAWARE_BUILD_OPTIONS := --enable-slashpackage --disable-shared --enable-allstatic
SKALIBS_OPTIONS := --with-default-path=/command:/usr/bin:/bin --with-sysdep-devurandom=yes --with-sysdep-grndinsecure=no --with-sysdep-posixspawnearlyreturn=no --with-sysdep-procselfexe=/proc/self/exe
NSSS_OPTIONS := --enable-libc-includes
UTMPS_OPTIONS := --enable-libc-includes --enable-utmp
EXECLINE_OPTIONS := --disable-pedantic-posix --enable-multicall
S6_OPTIONS := --enable-aliases-daemontools --enable-aliases-runit 
S6_RC_OPTIONS :=
S6_LINUX_INIT_OPTIONS := --enable-utmps
S6_FRONTEND_OPTIONS :=
S6_PORTABLE_UTILS_OPTIONS := --enable-multicall
S6_LINUX_UTILS_OPTIONS := --enable-multicall
S6_DNS_OPTIONS :=
S6_NETWORKING_OPTIONS := --enable-ssl=bearssl --with-ssl-path=$(OUTPUT)/rootfs/opt/bearssl
MDEVD_OPTIONS :=
TIPIDEE_OPTIONS :=
SHIBARI_OPTIONS :=
BCNM_OPTIONS :=
DNSFUNNEL_OPTIONS :=
APASTE_OPTIONS :=

$(OUTPUT)/build-$(TRIPLE)/s6-networking-$(S6_NETWORKING_VERSION)/config.mak: $(OUTPUT)/build-$(TRIPLE)/.lh_bearssl_installed

ifeq ($(CONSOLE),)
EARLY_GETTY :=
else
EARLY_GETTY := -G "getty -H lh-$(word 1,$(subst -, ,$(TRIPLE))) 115200 $(CONSOLE)"
endif

.PHONY: skaware-install

define skaware_rules_definition

$(1)_NAME := $(subst _,-,$(shell echo $(1) | tr A-Z a-z))
$(1)_INCLUDE_LOCATION := $(OUTPUT)/rootfs/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include
$(1)_LIBRARY_LOCATION := $(OUTPUT)/rootfs/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/library
$(1)_DYNLIB_LOCATION := $(OUTPUT)/rootfs/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/library.so

$(OUTPUT)/sources/$$($(1)_NAME)/Makefile: | $(OUTPUT)/tmp/.lh_prepared
	exec setuidgid $(NORMALUSER) rm -rf $(OUTPUT)/sources/$$($(1)_NAME)
	cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone git://git.skarnet.org/$$($(1)_NAME)
	exec setuidgid $(NORMALUSER) touch $$@

$(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/Makefile: $(OUTPUT)/sources/$$($(1)_NAME)/Makefile | $(OUTPUT)/tmp/.lh_prepared
	exec setuidgid $(NORMALUSER) rm -rf $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)
	exec setuidgid $(NORMALUSER) cp -a $(OUTPUT)/sources/$$($(1)_NAME) $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)
	cd $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) git checkout $$($(1)_VERSION) && rm -rf .git
	exec touch $$@

$(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/config.mak: $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/Makefile $$(foreach dep,$$($(1)_DEPENDENCIES),$(OUTPUT)/rootfs/package/$$($$(dep)_CATEGORY)/$$($$(dep)_NAME)/include/$$($$(dep)_NAME)/config.h)
	cd $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) $(SKAWARE_ENV) env DESTDIR=$(OUTPUT)/rootfs ./configure --host=$(TRIPLE) $(SKAWARE_OPTIONS) $$($(1)_OPTIONS)

$(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/$$($(1)_TOKEN): $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/config.mak
	cd $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) $(MAKE) all
	+cd $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) $(MAKE) strip

$(OUTPUT)/rootfs/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include/$$($(1)_NAME)/config.h: $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/$$($(1)_TOKEN) $(OUTPUT)/tmp/.lh_layout_installed
	cd $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION) && $(MAKE) install DESTDIR=$(OUTPUT)/rootfs
	cd $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION) && $(MAKE) -L update DESTDIR=$(OUTPUT)/rootfs
	cd $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION) && $(MAKE) -L global-links DESTDIR=$(OUTPUT)/rootfs
	exec touch $$@

$(OUTPUT)/build-$(TRIPLE)/.lh_skarnet_installed: $(OUTPUT)/rootfs/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include/$$($(1)_NAME)/config.h

endef

$(foreach pkg,$(SKAWARE),$(eval $(call skaware_rules_definition,$(pkg))))


$(OUTPUT)/build-$(TRIPLE)/.lh_s6li_laidout: $(OUTPUT)/rootfs/package/admin/s6-linux-init/include/s6-linux-init/config.h | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed $(OUTPUT)/tmp/.lh_layout_installed
	exec mkdir -p $(OUTPUT)/rootfs/etc/s6-linux-init
	exec rm -rf $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir
	exec s6-linux-init-maker -u $(NORMALUSER) $(EARLY_GETTY) -1 -p /command:/bin -s /run/kernel_env -f $(OUTPUT)/build-build/etc/s6-linux-init/skel -- $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir
	exec sed -i 's/s6-setuidgid "$(NORMALUSER)"/s6-setuidgid catchlog/' $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir/run-image/service/s6-svscan-log/run
	exec rm -rf $(OUTPUT)/rootfs/etc/s6-linux-init/current
	exec mv -f $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir $(OUTPUT)/rootfs/etc/s6-linux-init/current
	exec $(OUTPUT)/build-build/command/s6-chown -u 98 -g 98 -- $(OUTPUT)/rootfs/etc/s6-linux-init/current/run-image/uncaught-logs
	exec $(OUTPUT)/build-build/command/s6-chown -u 98 -g 98 -- $(OUTPUT)/rootfs/etc/s6-linux-init/current/run-image/service/s6-svscan-log/fifo
	exec $(OUTPUT)/build-build/command/s6-chmod 02750 $(OUTPUT)/rootfs/etc/s6-linux-init/current/run-image/uncaught-logs
	for i in `ls -1 $(OUTPUT)/rootfs/etc/s6-linux-init/current/bin` ; do ln -sf ../etc/s6-linux-init/current/bin/$$i $(OUTPUT)/rootfs/bin/$$i ; done
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_skarnet_installed: $(OUTPUT)/build-$(TRIPLE)/.lh_s6li_laidout

$(OUTPUT)/build-$(TRIPLE)/.lh_skarnet_installed:
	exec setuidgid $(NORMALUSER) touch $@

define skaware_build_rules_definition

$(1)_BUILD_INCLUDE_LOCATION := $(OUTPUT)/build-build/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include
$(1)_BUILD_LIBRARY_LOCATION := $(OUTPUT)/build-build/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/library
$(1)_BUILD_DYNLIB_LOCATION := $(OUTPUT)/build-build/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/library.so

$(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/Makefile: $(OUTPUT)/sources/$$($(1)_NAME)/Makefile | $(OUTPUT)/tmp/.lh_prepared
	exec setuidgid $(NORMALUSER) rm -rf $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)
	exec setuidgid $(NORMALUSER) cp -a $(OUTPUT)/sources/$$($(1)_NAME) $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)
	cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) git checkout $$($(1)_VERSION) && rm -rf .git
	exec touch $$@

$(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/config.mak: $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/Makefile $$(foreach dep,$$($(1)_DEPENDENCIES),$(OUTPUT)/build-build/package/$$($$(dep)_CATEGORY)/$$($$(dep)_NAME)/include/$$($$(dep)_NAME)/config.h)
	cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) env CC="$(BUILD_CC)" DESTDIR=$(OUTPUT)/build-build ./configure $(SKAWARE_BUILD_OPTIONS) $$($(1)_OPTIONS)

$(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/$$($(1)_TOKEN): $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/config.mak
	cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) $(MAKE) all
	+cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) $(MAKE) strip

$(OUTPUT)/build-build/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include/$$($(1)_NAME)/config.h: $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/$$($(1)_TOKEN)
	cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && $(MAKE) install DESTDIR=$(OUTPUT)/build-build
	cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && $(MAKE) -L update DESTDIR=$(OUTPUT)/build-build
	cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && $(MAKE) -L global-links DESTDIR=$(OUTPUT)/build-build
	exec touch $$@

$(OUTPUT)/build-build/.lh_skarnet_installed: $(OUTPUT)/build-build/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include/$$($(1)_NAME)/config.h

endef

$(foreach pkg,$(SKAWARE_BUILD),$(eval $(call skaware_build_rules_definition,$(pkg))))

$(OUTPUT)/build-build/etc/s6-linux-init/skel/rc.init: $(OUTPUT)/build-build/package/admin/s6-linux-init/include/s6-linux-init/config.h sub/skarnet.org/rc.init sub/skarnet.org/rc.shutdown sub/skarnet.org/rc.shutdown.final sub/skarnet.org/runlevel
	exec setuidgid $(NORMALUSER) mkdir -p $(OUTPUT)/build-build/etc/s6-linux-init/skel
	exec setuidgid $(NORMALUSER) cp -f sub/skarnet.org/rc.shutdown $(OUTPUT)/build-build/etc/s6-linux-init/skel/rc.shutdown
	exec setuidgid $(NORMALUSER) cp -f sub/skarnet.org/rc.shutdown.final $(OUTPUT)/build-build/etc/s6-linux-init/skel/rc.shutdown.final
	exec setuidgid $(NORMALUSER) cp -f sub/skarnet.org/runlevel $(OUTPUT)/build-build/etc/s6-linux-init/skel/runlevel
	exec setuidgid $(NORMALUSER) cp -f sub/skarnet.org/rc.init $@

$(OUTPUT)/build-build/.lh_skarnet_installed: $(OUTPUT)/build-build/etc/s6-linux-init/skel/rc.init

$(OUTPUT)/build-build/.lh_skarnet_installed:
	exec setuidgid $(NORMALUSER) touch $@
