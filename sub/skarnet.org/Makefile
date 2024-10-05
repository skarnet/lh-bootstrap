
SKALIBS_VERSION := 18290598b001146c684d5b67762007fee0182071
# SKALIBS_VERSION := v2.14.3.0

NSSS_VERSION := 058cb099026db5839fb62da38570a9066fc3e280
# NSSS_VERSION := v0.2.0.5

# UTMPS_VERSION := bb5f31c4d294f26cd3d4d03bd540f0dd0526b810
UTMPS_VERSION := v0.1.2.2

EXECLINE_VERSION := 7966e2038925e3be60e82402673dcf080b6b3a89
# EXECLINE_VERSION := v2.9.6.1

S6_VERSION := 83af5922365b2c6e9decc7c8d6168deb76994e85
# S6_VERSION := v2.13.1.0

S6_RC_VERSION := 7ea129564e5df90963fe0d3302dd3244050fa3af
# S6_RC_VERSION := v0.5.5.0

S6_LINUX_INIT_VERSION := 69f6e33e931e0302c94ceea83c691644d64a943d
# S6_LINUX_INIT_VERSION := v1.1.2.1

S6_PORTABLE_UTILS_VERSION := 133a98cfccabd660afe2d59c142e0f83ebd88b28
# S6_PORTABLE_UTILS_VERSION := v2.3.0.4

S6_LINUX_UTILS_VERSION := 8de20625f671a4c45abfc46821651476cf6d5fe6
# S6_LINUX_UTILS_VERSION := v2.6.2.1

S6_DNS_VERSION := 0d15ddfe8aaa1faf94a3734091c70739fcbb28e4
# S6_DNS_VERSION := v2.3.8.0

S6_NETWORKING_VERSION := f7965cf9e2f22d94b33aec470479f31cedc2e4f8
# S6_NETWORKING_VERSION := v2.7.0.4

MDEVD_VERSION := 80460c48ad1553dcb3396a70ccd86e9194371277
# MDEVD_VERSION := v0.1.6.5

TIPIDEE_VERSION := 9cbb088ed47e72665efd40c9cabef37be77edd40
# TIPIDEE_VERSION := v0.0.5.1

SHIBARI_VERSION := 6fbe5f610abf1dada9f94672643d5fc6c01d4cfc
# SHIBARI_VERSION := v0.0.1.2

BCNM_VERSION := 16107f18da64ac348026b8bfcf3ed39e9ff5d558
# BCNM_VERSION := v0.0.1.8

DNSFUNNEL_VERSION := ff4f1c3e5bdee68fe0baebd55b9b55e7e9b99e5a
# DNSFUNNEL_VERSION := v0.0.2.0

APASTE_VERSION := 9456f992cc1f9afc221c61ad9010d9c9eddfa240
# APASTE_VERSION := v0.0.2.1

SKAWARE := SKALIBS NSSS UTMPS EXECLINE S6 S6_RC S6_LINUX_INIT S6_PORTABLE_UTILS S6_LINUX_UTILS S6_DNS S6_NETWORKING MDEVD TIPIDEE SHIBARI BCNM DNSFUNNEL APASTE
SKAWARE_BUILD := SKALIBS NSSS UTMPS EXECLINE S6 S6_RC S6_LINUX_INIT S6_PORTABLE_UTILS S6_LINUX_UTILS

SKALIBS_DEPENDENCIES :=
NSSS_DEPENDENCIES := SKALIBS
UTMPS_DEPENDENCIES := SKALIBS NSSS
EXECLINE_DEPENDENCIES := SKALIBS NSSS
S6_DEPENDENCIES := SKALIBS EXECLINE NSSS
S6_RC_DEPENDENCIES := SKALIBS EXECLINE S6
S6_LINUX_INIT_DEPENDENCIES := SKALIBS NSSS UTMPS EXECLINE S6
S6_PORTABLE_UTILS_DEPENDENCIES := SKALIBS
S6_LINUX_UTILS_DEPENDENCIES := SKALIBS NSSS
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
S6_PORTABLE_UTILS_TOKEN := s6-ln
S6_LINUX_UTILS_TOKEN := s6-ps
S6_DNS_TOKEN := s6-dnsip
S6_NETWORKING_TOKEN := s6-tlsd-io
MDEVD_TOKEN := mdevd
TIPIDEE_TOKEN := tipideed
SHIBARI_TOKEN := shibari-server-udp
BCNM_TOKEN := bcnm-waitif
DNSFUNNEL_TOKEN := dnsfunneld
APASTE_TOKEN := apaste

SKAWARE_ENV := $(if $(filter true,$(TARGET_STATIC)),,env LDFLAGS=-Wl,-rpath-link,$(OUTPUT)/rootfs/library.so)
SKAWARE_OPTIONS := --enable-slashpackage --enable-nsss $(if $(filter true,$(TARGET_STATIC)),--enable-static-libc --disable-shared,--enable-shared --disable-allstatic)
SKAWARE_BUILD_OPTIONS := --enable-slashpackage --disable-shared --enable-allstatic 
SKALIBS_OPTIONS := --with-default-path=/command:/usr/bin:/bin --with-sysdep-devurandom=yes --with-sysdep-grndinsecure=no --with-sysdep-posixspawnearlyreturn=no
NSSS_OPTIONS := --enable-libc-includes
UTMPS_OPTIONS := --enable-libc-includes
EXECLINE_OPTIONS := --disable-pedantic-posix --enable-multicall
S6_OPTIONS :=
S6_RC_OPTIONS :=
S6_LINUX_INIT_OPTIONS := --enable-utmps
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
