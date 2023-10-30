
SKALIBS_VERSION=50da02706335d2f7a45a97ba3b6bdbe223e214a8
# SKALIBS_VERSION := v2.14.0.0

NSSS_VERSION := b773c2e7bda84ccc98f6826edcde7bab8741830e
# NSSS_VERSION := v0.2.0.4

UTMPS_VERSION := d5c9e14276ccda11cb01dff110623075f0f330a5
# UTMPS_VERSION := v0.1.2.2

EXECLINE_VERSION=813ab6fe79edab2af685bcb7e025966f163da672
# EXECLINE_VERSION := v2.9.4.0

S6_VERSION=0c3cf16e675a65a15b9167c45179cf5c66b826e7
# S6_VERSION := v2.12.0.0

S6_RC_VERSION=940e4bb20f7927a54c9ee92bcea1c54f8b60666d
# S6_RC_VERSION := v0.5.4.2

S6_LINUX_INIT_VERSION=421ff132dee36124fd6fe4eaaffe3576179c3812
# S6_LINUX_INIT_VERSION := v1.1.2.0

S6_PORTABLE_UTILS_VERSION=5be24a3642c294e4fcec465c9c6f19d66cf2220d
# S6_PORTABLE_UTILS_VERSION := v2.3.0.3

S6_LINUX_UTILS_VERSION=7b5f71fd0128ff3f848841b28ce53b0eb9bf3e5e
# S6_LINUX_UTILS_VERSION=v2.6.2.0

S6_DNS_VERSION=2ac33222d297ad53bfdc15aa10563cf2c7eea042
# S6_DNS_VERSION=v2.3.6.0

S6_NETWORKING_VERSION=6342cffb3485d64340563b9e86d54a667b7148ce
# S6_NETWORKING_VERSION=v2.6.0.0

MDEVD_VERSION := 83b89bedea1bf97e5b103ad2a0cb2fcaeaa41de1
# MDEVD_VERSION := v0.1.6.3

BCNM_VERSION := 4de021fc19b521b73178c0e90cd0d9efec679d95
# BCNM_VERSION := v0.0.1.7

TIPIDEE_VERSION := 28e7bfc363aefc591955794e9c031f6962274368
# TIPIDEE_VERSION := v0.0.1.0

SKAWARE := SKALIBS NSSS UTMPS EXECLINE S6 S6_RC S6_LINUX_INIT S6_PORTABLE_UTILS S6_LINUX_UTILS S6_DNS S6_NETWORKING MDEVD BCNM TIPIDEE
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
BCNM_DEPENDENCIES := SKALIBS
TIPIDEE_DEPENDENCIES := SKALIBS

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
BCNM_CATEGORY := admin
TIPIDEE_CATEGORY := web

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
BCNM_TOKEN := bcnm-waitif
TIPIDEE_TOKEN := tipideed

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
BCNM_OPTIONS :=
TIPIDEE_OPTIONS :=

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
	+cd $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) $(MAKE) all strip

$(OUTPUT)/rootfs/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include/$$($(1)_NAME)/config.h: $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION)/$$($(1)_TOKEN) $(OUTPUT)/tmp/.lh_layout_installed
	+cd $(OUTPUT)/build-$(TRIPLE)/$$($(1)_NAME)-$$($(1)_VERSION) && $(MAKE) -L install update global-links DESTDIR=$(OUTPUT)/rootfs
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
	cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) env "CC=$(BUILD_CC)" DESTDIR=$(OUTPUT)/build-build ./configure $(SKAWARE_BUILD_OPTIONS) $$($(1)_OPTIONS)

$(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/$$($(1)_TOKEN): $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/config.mak
	+cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && setuidgid $(NORMALUSER) $(MAKE) all strip

$(OUTPUT)/build-build/package/$$($(1)_CATEGORY)/$$($(1)_NAME)/include/$$($(1)_NAME)/config.h: $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION)/$$($(1)_TOKEN)
	+cd $(OUTPUT)/build-build/$$($(1)_NAME)-$$($(1)_VERSION) && $(MAKE) -L install update global-links DESTDIR=$(OUTPUT)/build-build
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
