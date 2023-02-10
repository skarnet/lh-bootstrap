SKAWARE := SKALIBS UTMPS EXECLINE S6 S6_RC S6_LINUX_INIT S6_PORTABLE_UTILS S6_LINUX_UTILS S6_DNS S6_NETWORKING MDEVD BCNM

# SKALIBS_VERSION := v2.13.1.0
SKALIBS_VERSION := a10514072f27ff9f4a6ab308b3bccfd4628ef2aa
UTMPS_VERSION := v0.1.2.1
# EXECLINE_VERSION := v2.9.2.0
EXECLINE_VERSION := 9c2bebec16aafefb9067c1db83ef3c765e13610b
# S6_VERSION := v2.11.3.0
S6_VERSION := 47e886410b0e1e9e2f40a3447d6a9a9c1c07928f
# S6_RC_VERSION := v0.5.3.4
S6_RC_VERSION := 949964fa25c8b4cd088f34ccad636e185a878da5
S6_LINUX_INIT_VERSION := v1.0.8.1
S6_PORTABLE_UTILS_VERSION := v2.2.5.1
# S6_LINUX_UTILS_VERSION := v2.6.1.0
S6_LINUX_UTILS_VERSION := 3caba3fd8f3825544c065ec62e4298c6edc76b28
S6_DNS_VERSION := v2.3.5.5
# S6_NETWORKING_VERSION := v2.5.1.3
S6_NETWORKING_VERSION := 850ab0b4dc5546c408cd8566dafd5e2416d60f43
MDEVD_VERSION := v0.1.6.1
BCNM_VERSION := v0.0.1.6


SKALIBS_DEPENDENCIES :=
UTMPS_DEPENDENCIES := SKALIBS
EXECLINE_DEPENDENCIES := SKALIBS
S6_DEPENDENCIES := SKALIBS EXECLINE
S6_RC_DEPENDENCIES := SKALIBS EXECLINE S6
S6_LINUX_INIT_DEPENDENCIES := SKALIBS EXECLINE S6
S6_PORTABLE_UTILS_DEPENDENCIES := SKALIBS
S6_LINUX_UTILS_DEPENDENCIES := SKALIBS
S6_DNS_DEPENDENCIES := SKALIBS
S6_NETWORKING_DEPENDENCIES := SKALIBS EXECLINE S6 S6_DNS
MDEVD_DEPENDENCIES := SKALIBS
BCNM_DEPENDENCIES := SKALIBS

SKALIBS_CATEGORY := prog
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
BCNM_CATEGORY := admin

SKALIBS_TOKEN := libskarnet.a.xyzzy
UTMPS_TOKEN := utmps-utmpd
EXECLINE_TOKEN := execlineb
S6_TOKEN := s6-supervise
S6_RC_TOKEN := s6-rc
S6_LINUX_INIT_TOKEN := s6-linux-init-maker
S6_PORTABLE_UTILS_TOKEN := s6-test
S6_LINUX_UTILS_TOKEN := s6-ps
S6_DNS_TOKEN := s6-dnsip4
S6_NETWORKING_TOKEN := s6-tlsd-io
MDEVD_TOKEN := mdevd
BCNM_TOKEN := bcnm-waitif

SKAWARE_ENV := $(if $(filter true,$(TARGET_STATIC)),,env LDFLAGS=-Wl,-rpath-link,$(OUTPUT)/rootfs/library.so)
SKAWARE_OPTIONS := --enable-slashpackage $(if $(filter true,$(TARGET_STATIC)),--enable-static-libc --disable-shared,--enable-shared --disable-allstatic)
SKAWARE_BUILD_OPTIONS := --enable-slashpackage --disable-shared --enable-allstatic
SKALIBS_OPTIONS := --with-default-path=/command:/usr/bin:/bin --with-sysdep-devurandom=yes --with-sysdep-grndinsecure=no
UTMPS_OPTIONS := --enable-libc-includes
EXECLINE_OPTIONS := --disable-pedantic-posix --enable-multicall
S6_OPTIONS :=
S6_RC_OPTIONS :=
S6_LINUX_INIT_OPTIONS :=
S6_PORTABLE_UTILS_OPTIONS :=
S6_LINUX_UTILS_OPTIONS :=
S6_DNS_OPTIONS :=
S6_NETWORKING_OPTIONS := --enable-ssl=bearssl --with-ssl-path=$(OUTPUT)/staging-$(ARCH)
MDEVD_OPTIONS :=
BCNM_OPTIONS :=

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

.PHONY: $$($(1)_NAME)-download $$($(1)_NAME)-prepare $$($(1)_NAME)-configure $$($(1)_NAME)-build $$($(1)_NAME)-install

$$($(1)_NAME)-download: $(OUTPUT)/sources/$$($(1)_NAME)/Makefile
$$($(1)_NAME)-prepare: $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/Makefile
$$($(1)_NAME)-configure: $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/config.mak
$$($(1)_NAME)-build: $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/$$($(1)_TOKEN)
$$($(1)_NAME)-install: $(OUTPUT)/staging-$(TRIPLE)/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include/$$($(1)_NAME)/config.h

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
	cd $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) $(SKAWARE_ENV) ./configure --host=$(TRIPLE) $(SKAWARE_OPTIONS) $$($(1)_OPTIONS)

$(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/$$($(1)_TOKEN): $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/config.mak
	cd $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) $(MAKE) all strip

$(OUTPUT)/rootfs/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include/$$($(1)_NAME)/config.h: $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/$$($(1)_TOKEN)
	cd $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION) && $(MAKE) -L install update global-links DESTDIR=$(OUTPUT)/rootfs

$(OUTPUT)/build-$(TRIPLE)/.lh_skarnet_installed: $(OUTPUT)/rootfs/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include/$$($(1)_NAME)/config.h

endef

$(foreach pkg,$(SKAWARE),$(eval $(call skaware_rules_definition,$(pkg))))


$(OUTPUT)/build-$(TRIPLE)/.lh_s6li_laidout: $(OUTPUT)/rootfs/package/admin/s6-linux-init/include/s6-linux-init/config.h | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec mkdir -p $(OUTPUT)/rootfs/etc/s6-linux-init
	exec rm -rf $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir
	exec s6-linux-init-maker -u $(NORMALUSER) $(EARLY_GETTY) -1 -p /command:/bin -s /run/kernel_env -U utmp -f $(OUTPUT)/build-build/etc/s6-linux-init/skel -- $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir
	exec sed -i 's/s6-setuidgid "$(NORMALUSER)"/s6-setuidgid catchlog/' $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir/run-image/service/s6-svscan-log/run
	exec rm -rf $(OUTPUT)/rootfs/etc/s6-linux-init/current
	exec mv -f $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir $(OUTPUT)/rootfs/etc/s6-linux-init/current
	exec $(OUTPUT)/build-build/command/s6-chown -u 98 -g 98 -- $(OUTPUT)/rootfs/etc/s6-linux-init/current/run-image/uncaught-logs
	exec $(OUTPUT)/build-build/command/s6-chown -u 98 -g 98 -- $(OUTPUT)/rootfs/etc/s6-linux-init/current/run-image/service/s6-svscan-log/fifo
	exec $(OUTPUT)/build-build/command/s6-chmod 02750 $(OUTPUT)/rootfs/etc/s6-linux-init/current/run-image/uncaught-logs
	exec $(OUTPUT)/build-build/command/s6-chown -u 99 -g 99 -- $(OUTPUT)/rootfs/etc/s6-linux-init/current/run-image/utmps
	for i in `ls -1 $(OUTPUT)/rootfs/etc/s6-linux-init/current/bin` ; do ln -sf ../etc/s6-linux-init/current/bin/$$i $(OUTPUT)/rootfs/bin/$$i ; done
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-$(TRIPLE)/.lh_skarnet_installed: $(OUTPUT)/build-$(TRIPLE)/.lh_s6li_laidout

$(OUTPUT)/build-$(TRIPLE)/.lh_skarnet_installed:
	exec setuidgid $(NORMALUSER) touch $@



SKAWARE_BUILD := SKALIBS EXECLINE S6 S6_RC S6_LINUX_INIT S6_PORTABLE_UTILS S6_LINUX_UTILS

define skaware_build_rules_definition

$(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/Makefile: $(OUTPUT)/sources/$$($(1)_NAME)/Makefile | $(OUTPUT)/tmp/.lh_prepared
	exec setuidgid $(NORMALUSER) rm -rf $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)
	exec setuidgid $(NORMALUSER) cp -a $(OUTPUT)/sources/$$($(1)_NAME) $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)
	cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) git checkout $$($(1)_VERSION) && rm -rf .git
	exec touch $$@

$(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/config.mak: $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/Makefile $$(foreach dep,$$($(1)_DEPENDENCIES),$(OUTPUT)/build-build/package/$$($$(dep)_CATEGORY)/$$($$(dep)_NAME)/include/$$($$(dep)_NAME)/config.h)
	cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) env CC="$(BUILD_CC)" ./configure $(SKAWARE_BUILD_OPTIONS) $$($(1)_OPTIONS)

$(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/$$($(1)_TOKEN): $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/config.mak
	cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) $(MAKE) all strip

$(OUTPUT)/build-build/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include/$$($(1)_NAME)/config.h: $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/$$($(1)_TOKEN)
	cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && $(MAKE) -L install update global-links DESTDIR=$(OUTPUT)/build-build

$(OUTPUT)/build-build/.lh_skarnet_installed: $(OUTPUT)/build-build/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include/$$($(1)_NAME)/config.h

endef

$(foreach pkg,$(SKAWARE_BUILD),$(eval $(call skaware_build_rules_definition,$(pkg))))

$(OUTPUT)/build-build/etc/s6-linux-init/skel/rc.init: $(OUTPUT)/build-build/package/admin/s6-linux-init/include/s6-linux-init/config.h sub/skarnet.org/rc.init sub/skarnet.org/rc.shutdown sub/skarnet.org/rc.shutdown.final sub/skarnet.org/runlevel
	exec setuidgid $(NORMALUSER) mkdir -p $(OUTPUT)/build-build/etc/s6-linux-init/skel
	exec setuidgid $(NORMALUSER) cp -f sub/skarnet.org/rc.shutdown $(OUTPUT)/build-build/etc/s6-linux-init/skel/rc.shutdown
	exec setuidgid $(NORMALUSER) cp -f sub/skarnet.org/rc.shutdown.final $(OUTPUT)/build-build/etc/s6-linux-init/skel/rc.shutdown.final
	exec setuidgid $(NORMALUSER) cp -f sub/skarnet.org/runlevel $(OUTPUT)/build-build/etc/s6-linux-init/skel/runlevel
	exec setuidgid $(NORMALUSER) cp -f sub/skarnet.org/rc.init $@
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_skarnet_installed: $(OUTPUT)/build-build/etc/s6-linux-init/skel/rc.init

$(OUTPUT)/build-build/.lh_skarnet_installed:
	exec setuidgid $(NORMALUSER) touch $@
