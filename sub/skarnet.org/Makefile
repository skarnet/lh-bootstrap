
# Sources

url := git://git.skarnet.org
suffix :=

SKALIBS_VERSION := d200635a4c624c687b3387f937425d12239eb5c3
EXECLINE_VERSION := 1c14235c4055f9e9ae5664c81909d6f1b2e4ba1e
S6_PORTABLE_UTILS_VERSION := c7bd01088dc5a15500fb91d58f4fff5bbe4d3438
S6_DNS_VERSION := 4a27fef217491f03aab8497d899ecb58289897d2
S6_NETWORKING_VERSION := cfc739a5ec6e408faadef3b17250c50bca0f0b38
S6_VERSION := 4ad28c83818e3b7b351ac328e3753d8dab8b2804
S6_RC_VERSION := 40939adadfae8f06835f202aca7d243210c25226
S6_LINUX_INIT_VERSION := 90640f6c94285b035d57faf786726f8084962c1b
MDEVD_VERSION := 7430c9be1d379ae1eb0626ec67968b6edcfbf7d6
BCNM_VERSION := fe28e76256c4ff7d1af53ad3940bf737f6000107

SKARNET_CONF_STATIC := $(if $(filter true,$(BUILD_HOST_STATIC)),--enable-static-libc,--enable-shared --disable-allstatic)
SKALIBS_FIND_OPTIONS := --with-sysdeps=$(OUTPUT)/rootfs/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/rootfs/package/prog/skalibs/include --with-lib=$(OUTPUT)/rootfs/package/prog/skalibs/library --with-dynlib=$(OUTPUT)/rootfs/package/prog/skalibs/library.so
EXECLINE_FIND_OPTIONS := --with-include=$(OUTPUT)/rootfs/package/admin/execline/include --with-lib=$(OUTPUT)/rootfs/package/admin/execline/library --with-dynlib=$(OUTPUT)/rootfs/package/admin/execline/library.so
S6_FIND_OPTIONS := --with-include=$(OUTPUT)/rootfs/package/admin/s6/include --with-lib=$(OUTPUT)/rootfs/package/admin/s6/library --with-dynlib=$(OUTPUT)/rootfs/package/admin/s6/library.so
S6_DNS_FIND_OPTIONS := --with-include=$(OUTPUT)/rootfs/package/web/s6-dns/include --with-lib=$(OUTPUT)/rootfs/package/web/s6-dns/library --with-dynlib=$(OUTPUT)/rootfs/package/web/s6-dns/library.so


ifeq ($(CONSOLE),)
EARLY_GETTY :=
else
EARLY_GETTY := -G "getty -H lh-$(word 1,$(subst (-, ,$(TRIPLE))) $(CONSOLE)"
endif

$(OUTPUT)/sources/.lh_skalibs_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/skalibs ; then cd $(OUTPUT)/sources/skalibs && setuidgid $(NORMALUSER) git fetch ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/skalibs$(suffix) skalibs ; fi
	exec setuidgid $(NORMALUSER) sh -c "cd $(OUTPUT)/sources/skalibs && git checkout $(SKALIBS_VERSION) && :> package/deps-build"
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_execline_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/execline ; then cd $(OUTPUT)/sources/execline && setuidgid $(NORMALUSER) git fetch ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/execline$(suffix) execline ; fi
	exec setuidgid $(NORMALUSER) sh -c "cd $(OUTPUT)/sources/execline && git checkout $(EXECLINE_VERSION) && :> package/deps-build"
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_s6pu_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/s6-portable-utils ; then cd $(OUTPUT)/sources/s6-portable-utils && setuidgid $(NORMALUSER) git fetch ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/s6-portable-utils$(suffix) s6-portable-utils ; fi
	exec setuidgid $(NORMALUSER) sh -c "cd $(OUTPUT)/sources/s6-portable-utils && git checkout $(S6_PORTABLE_UTILS_VERSION) && :> package/deps-build"
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_s6dns_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/s6-dns ; then cd $(OUTPUT)/sources/s6-dns && setuidgid $(NORMALUSER) git fetch ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/s6-dns$(suffix) s6-dns ; fi
	exec setuidgid $(NORMALUSER) sh -c "cd $(OUTPUT)/sources/s6-dns && git checkout $(S6_DNS_VERSION) && :> package/deps-build"
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_s6net_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/s6-networking ; then cd $(OUTPUT)/sources/s6-networking && setuidgid $(NORMALUSER) git fetch ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/s6-networking$(suffix) s6-networking ; fi
	exec setuidgid $(NORMALUSER) sh -c "cd $(OUTPUT)/sources/s6-networking && git checkout $(S6_NETWORKING_VERSION) && :> package/deps-build"
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_s6_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/s6 ; then cd $(OUTPUT)/sources/s6 && setuidgid $(NORMALUSER) git fetch ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/s6$(suffix) s6 ; fi
	exec setuidgid $(NORMALUSER) sh -c "cd $(OUTPUT)/sources/s6 && git checkout $(S6_VERSION) && :> package/deps-build"
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_s6li_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/s6-linux-init ; then cd $(OUTPUT)/sources/s6-linux-init && setuidgid $(NORMALUSER) git fetch ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/s6-linux-init$(suffix) s6-linux-init ; fi
	exec setuidgid $(NORMALUSER) sh -c "cd $(OUTPUT)/sources/s6-linux-init && git checkout $(S6_LINUX_INIT_VERSION) && :> package/deps-build"
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_mdevd_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/mdevd ; then cd $(OUTPUT)/sources/mdevd && setuidgid $(NORMALUSER) git fetch ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/mdevd$(suffix) mdevd ; fi
	exec setuidgid $(NORMALUSER) sh -c "cd $(OUTPUT)/sources/mdevd && git checkout $(MDEVD_VERSION) && :> package/deps-build"
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_bcnm_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/bcnm ; then cd $(OUTPUT)/sources/bcnm && setuidgid $(NORMALUSER) git fetch ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/bcnm$(suffix) bcnm ; fi
	exec setuidgid $(NORMALUSER) sh -c "cd $(OUTPUT)/sources/bcnm && git checkout $(BCNM_VERSION) && :> package/deps-build"
	exec setuidgid $(NORMALUSER) touch $@



# Build-build

$(OUTPUT)/build-build/.lh_skalibs_copied: $(OUTPUT)/sources/.lh_skalibs_cloned
	exec setuidgid $(NORMALUSER) rm -rf -- $(OUTPUT)/build-build/tmp/skalibs
	exec setuidgid $(NORMALUSER) cp -RP -- $(OUTPUT)/sources/skalibs $(OUTPUT)/build-build/tmp/skalibs
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_skalibs_configured: $(OUTPUT)/build-build/.lh_skalibs_copied
	cd $(OUTPUT)/build-build/tmp/skalibs && setuidgid $(NORMALUSER) env CC="$(BUILD_BUILD_CC)" ./configure --enable-tai-clock --enable-slashpackage --with-default-path=/command:/bin --disable-shared --with-sysdep-devurandom=yes
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_skalibs_built: $(OUTPUT)/build-build/.lh_skalibs_configured
	cd $(OUTPUT)/build-build/tmp/skalibs && setuidgid $(NORMALUSER) $(MAKE) all strip
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_skalibs_installed: $(OUTPUT)/build-build/.lh_skalibs_built
	cd $(OUTPUT)/build-build/tmp/skalibs && setuidgid $(NORMALUSER) $(MAKE) install update global-links DESTDIR=$(OUTPUT)/build-build
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-build/.lh_execline_copied: $(OUTPUT)/sources/.lh_execline_cloned
	exec setuidgid $(NORMALUSER) rm -rf -- $(OUTPUT)/build-build/tmp/execline
	exec setuidgid $(NORMALUSER) cp -RP -- $(OUTPUT)/sources/execline $(OUTPUT)/build-build/tmp/execline
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_execline_configured: $(OUTPUT)/build-build/.lh_execline_copied $(OUTPUT)/build-build/.lh_skalibs_installed
	cd $(OUTPUT)/build-build/tmp/execline && setuidgid $(NORMALUSER) env CC="$(BUILD_BUILD_CC)" ./configure --enable-slashpackage --disable-shared --with-sysdeps=$(OUTPUT)/build-build/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/build-build/package/prog/skalibs/include --with-lib=$(OUTPUT)/build-build/package/prog/skalibs/library
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_execline_built: $(OUTPUT)/build-build/.lh_execline_configured $(OUTPUT)/build-build/.lh_skalibs_installed
	cd $(OUTPUT)/build-build/tmp/execline && setuidgid $(NORMALUSER) $(MAKE) all strip
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_execline_installed: $(OUTPUT)/build-build/.lh_execline_built
	cd $(OUTPUT)/build-build/tmp/execline && setuidgid $(NORMALUSER) $(MAKE) install update global-links DESTDIR=$(OUTPUT)/build-build
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-build/.lh_s6pu_copied: $(OUTPUT)/sources/.lh_s6pu_cloned
	exec setuidgid $(NORMALUSER) rm -rf -- $(OUTPUT)/build-build/tmp/s6-portable-utils
	exec setuidgid $(NORMALUSER) cp -RP -- $(OUTPUT)/sources/s6-portable-utils $(OUTPUT)/build-build/tmp/s6-portable-utils
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6pu_configured: $(OUTPUT)/build-build/.lh_s6pu_copied $(OUTPUT)/build-build/.lh_skalibs_installed
	cd $(OUTPUT)/build-build/tmp/s6-portable-utils && setuidgid $(NORMALUSER) env CC="$(BUILD_BUILD_CC)" ./configure --enable-slashpackage --with-sysdeps=$(OUTPUT)/build-build/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/build-build/package/prog/skalibs/include --with-lib=$(OUTPUT)/build-build/package/prog/skalibs/library
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6pu_built: $(OUTPUT)/build-build/.lh_s6pu_configured $(OUTPUT)/build-build/.lh_skalibs_installed
	cd $(OUTPUT)/build-build/tmp/s6-portable-utils && setuidgid $(NORMALUSER) $(MAKE) all strip
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6pu_installed: $(OUTPUT)/build-build/.lh_s6pu_built
	cd $(OUTPUT)/build-build/tmp/s6-portable-utils && setuidgid $(NORMALUSER) $(MAKE) install update global-links DESTDIR=$(OUTPUT)/build-build
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-build/.lh_s6_copied: $(OUTPUT)/sources/.lh_s6_cloned
	exec setuidgid $(NORMALUSER) rm -rf $(OUTPUT)/build-build/tmp/s6
	exec setuidgid $(NORMALUSER) cp -a $(OUTPUT)/sources/s6 $(OUTPUT)/build-build/tmp/s6
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6_configured: $(OUTPUT)/build-build/.lh_s6_copied $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_execline_installed
	cd $(OUTPUT)/build-build/tmp/s6 && setuidgid $(NORMALUSER) export CC "$(BUILD_BUILD_CC)" ./configure --enable-slashpackage --disable-shared --with-sysdeps=$(OUTPUT)/build-build/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/build-build/package/prog/skalibs/include --with-lib=$(OUTPUT)/build-build/package/prog/skalibs/library --with-include=$(OUTPUT)/build-build/package/admin/execline/include --with-lib=$(OUTPUT)/build-build/package/admin/execline/library
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6_built: $(OUTPUT)/build-build/.lh_s6_configured $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_execline_installed
	cd $(OUTPUT)/build-build/tmp/s6 && setuidgid $(NORMALUSER) $(MAKE) all strip
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6_installed: $(OUTPUT)/build-build/.lh_s6_built
	cd $(OUTPUT)/build-build/tmp/s6 && setuidgid $(NORMALUSER) $(MAKE) install update global-links DESTDIR=$(OUTPUT)/build-build
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-build/.lh_s6li_copied: $(OUTPUT)/sources/.lh_s6li_cloned
	exec setuidgid $(NORMALUSER) rm -rf $(OUTPUT)/build-build/tmp/s6-linux-init
	exec setuidgid $(NORMALUSER) cp -a $(OUTPUT)/sources/s6-linux-init $(OUTPUT)/build-build/tmp/s6-linux-init
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6li_configured: $(OUTPUT)/build-build/.lh_s6li_copied $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_execline_installed $(OUTPUT)/build-build/.lh_s6_installed
	cd $(OUTPUT)/build-build/tmp/s6-linux-init && setuidgid $(NORMALUSER) export CC "$(BUILD_BUILD_CC)" ./configure --enable-slashpackage --disable-shared --with-sysdeps=$(OUTPUT)/build-build/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/build-build/package/prog/skalibs/include --with-lib=$(OUTPUT)/build-build/package/prog/skalibs/library --with-include=$(OUTPUT)/build-build/package/admin/execline/include --with-lib=$(OUTPUT)/build-build/package/admin/execline/library --with-include=$(OUTPUT)/build-build/package/admin/s6/include --with-lib=$(OUTPUT)/build-build/package/admin/s6/library
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6li_built: $(OUTPUT)/build-build/.lh_s6li_configured $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_execline_installed $(OUTPUT)/build-build/.lh_s6_installed
	cd $(OUTPUT)/build-build/tmp/s6-linux-init && setuidgid $(NORMALUSER) $(MAKE) all strip
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6li_installed: $(OUTPUT)/build-build/.lh_s6li_built sub/skarnet.org/rc.init sub/skarnet.org/rc.shutdown sub/skarnet.org/rc.shutdown.final sub/skarnet.org/runlevel
	exec setuidgid $(NORMALUSER) mkdir -p $(OUTPUT)/build-build/etc/s6-linux-init/skel
	cd $(OUTPUT)/build-build/tmp/s6-linux-init && setuidgid $(NORMALUSER) $(MAKE) install update global-links DESTDIR=$(OUTPUT)/build-build
	exec setuidgid $(NORMALUSER) s6-hiercopy sub/skarnet.org/rc.init $(OUTPUT)/build-build/etc/s6-linux-init/skel/rc.init
	exec setuidgid $(NORMALUSER) s6-hiercopy sub/skarnet.org/rc.shutdown $(OUTPUT)/build-build/etc/s6-linux-init/skel/rc.shutdown
	exec setuidgid $(NORMALUSER) s6-hiercopy sub/skarnet.org/rc.shutdown.final $(OUTPUT)/build-build/etc/s6-linux-init/skel/rc.shutdown.final
	exec setuidgid $(NORMALUSER) s6-hiercopy sub/skarnet.org/runlevel $(OUTPUT)/build-build/etc/s6-linux-init/skel/runlevel
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-build/.lh_s6dns_copied: $(OUTPUT)/sources/.lh_s6dns_cloned
	exec setuidgid $(NORMALUSER) rm -rf $(OUTPUT)/build-build/tmp/s6-dns
	exec setuidgid $(NORMALUSER) cp -a $(OUTPUT)/sources/s6-dns $(OUTPUT)/build-build/tmp/s6-dns
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6dns_configured: $(OUTPUT)/build-build/.lh_s6dns_copied $(OUTPUT)/build-build/.lh_skalibs_installed
	cd $(OUTPUT)/build-build/tmp/s6-dns && setuidgid $(NORMALUSER) env CC="$(BUILD_BUILD_CC)" ./configure --enable-slashpackage --disable-shared --with-sysdeps=$(OUTPUT)/build-build/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/build-build/package/prog/skalibs/include --with-lib=$(OUTPUT)/build-build/package/prog/skalibs/library
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6dns_built: $(OUTPUT)/build-build/.lh_s6dns_configured $(OUTPUT)/build-build/.lh_skalibs_installed
	cd $(OUTPUT)/build-build/tmp/s6-dns && setuidgid $(NORMALUSER) $(MAKE) all strip
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6dns_installed: $(OUTPUT)/build-build/.lh_s6dns_built
	cd $(OUTPUT)/build-build/tmp/s6-dns && setuidgid $(NORMALUSER) $(MAKE) install update global-links DESTDIR=$(OUTPUT)/build-build
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-build/.lh_skarnet_installed: $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_execline_installed $(OUTPUT)/build-build/.lh_s6pu_installed $(OUTPUT)/build-build/.lh_s6_installed $(OUTPUT)/build-build/.lh_s6li_installed $(OUTPUT)/build-build/.lh_s6dns_installed
	exec setuidgid $(NORMALUSER) touch $@



# Build-host


$(OUTPUT)/build-host/.lh_skalibs_copied: $(OUTPUT)/sources/.lh_skalibs_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/skalibs
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/skalibs $(OUTPUT)/build-host/skalibs
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_skalibs_configured: $(OUTPUT)/build-host/.lh_skalibs_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/skalibs ./configure --host=$(TRIPLE) --enable-tai-clock --enable-slashpackage --with-default-path=/command:/bin $(SKARNET_CONF_STATIC) --with-sysdep-devurandom=yes
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_skalibs_built: $(OUTPUT)/build-host/.lh_skalibs_configured | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/skalibs $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_skalibs_installed: $(OUTPUT)/build-host/.lh_skalibs_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	cd $(OUTPUT)/build-host/skalibs && $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-host/.lh_execline_copied: $(OUTPUT)/sources/.lh_execline_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/execline
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/execline $(OUTPUT)/build-host/execline
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_execline_configured: $(OUTPUT)/build-host/.lh_execline_copied $(OUTPUT)/build-host/.lh_skalibs_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/execline ./configure --host=$(TRIPLE) --enable-slashpackage $(SKARNET_CONF_STATIC) $(SKALIBS_FIND_OPTIONS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_execline_built: $(OUTPUT)/build-host/.lh_execline_configured $(OUTPUT)/build-host/.lh_skalibs_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/execline $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_execline_installed: $(OUTPUT)/build-host/.lh_execline_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/execline $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_s6dns_copied: $(OUTPUT)/sources/.lh_s6dns_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/s6-dns
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/s6-dns $(OUTPUT)/build-host/s6-dns
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6dns_configured: $(OUTPUT)/build-host/.lh_s6dns_copied $(OUTPUT)/build-host/.lh_skalibs_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-dns ./configure --host=$(TRIPLE) --enable-slashpackage $(SKARNET_CONF_STATIC) $(SKALIBS_FIND_OPTIONS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6dns_built: $(OUTPUT)/build-host/.lh_s6dns_configured $(OUTPUT)/build-host/.lh_skalibs_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-dns $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6dns_installed: $(OUTPUT)/build-host/.lh_s6dns_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/s6-dns $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_s6net_copied: $(OUTPUT)/sources/.lh_s6net_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/s6-networking
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/s6-networking $(OUTPUT)/build-host/s6-networking
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6net_configured: $(OUTPUT)/build-host/.lh_s6net_copied $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_s6dns_installed $(OUTPUT)/build-host/.lh_execline_installed $(OUTPUT)/build-host/.lh_s6_installed $(OUTPUT)/build-host/.lh_bearssl_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-networking ./configure --host=$(TRIPLE) --enable-slashpackage $(SKARNET_CONF_STATIC) --enable-ssl=bearssl --with-ssl-path=$(OUTPUT)/rootfs/opt/bearssl $(SKALIBS_FIND_OPTIONS) $(EXECLINE_FIND_OPTIONS) $(S6_FIND_OPTIONS) $(S6_DNS_FIND_OPTIONS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6net_built: $(OUTPUT)/build-host/.lh_s6net_configured $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_s6dns_installed $(OUTPUT)/build-host/.lh_execline_installed $(OUTPUT)/build-host/.lh_s6_installed $(OUTPUT)/build-host/.lh_bearssl_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-networking $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6net_installed: $(OUTPUT)/build-host/.lh_s6net_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/s6-networking $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_s6_copied: $(OUTPUT)/sources/.lh_s6_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/s6
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/s6 $(OUTPUT)/build-host/s6
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6_configured: $(OUTPUT)/build-host/.lh_s6_copied $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_execline_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6 ./configure --host=$(TRIPLE) --enable-slashpackage $(SKARNET_CONF_STATIC) $(SKALIBS_FIND_OPTIONS) $(EXECLINE_FIND_OPTIONS)
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6_built: $(OUTPUT)/build-host/.lh_s6_configured $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_execline_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6 $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6_installed: $(OUTPUT)/build-host/.lh_s6_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/s6 $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_s6li_copied: $(OUTPUT)/sources/.lh_s6li_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/s6-linux-init
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/s6-linux-init $(OUTPUT)/build-host/s6-linux-init
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6li_configured: $(OUTPUT)/build-host/.lh_s6li_copied $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_execline_installed $(OUTPUT)/build-host/.lh_s6_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-linux-init ./configure --host=$(TRIPLE) --enable-slashpackage $(SKARNET_CONF_STATIC) $(SKALIBS_FIND_OPTIONS) $(EXECLINE_FIND_OPTIONS) $(S6_FIND_OPTIONS)
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-host/.lh_s6li_built: $(OUTPUT)/build-host/.lh_s6li_configured $(OUTPUT)/build-host/.lh_skalibs_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-linux-init $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6li_installed: $(OUTPUT)/build-host/.lh_s6li_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/s6-linux-init $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6li_laidout: $(OUTPUT)/build-host/.lh_s6li_installed | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec mkdir -p $(OUTPUT)/rootfs/etc/s6-linux-init
	exec rm -rf $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir
	exec s6-linux-init-maker -u $(NORMALUSER) $(EARLY_GETTY) -1 -p /command:/bin -s /run/kernel_env -f $(OUTPUT)/build-build/etc/s6-linux-init/skel -- $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir
	exec sed -i 's/ "$(NORMALUSER)" / catchlog /' $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir/run-image/service/s6-svscan-log/run
	exec chown 98:98 $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir/run-image/uncaught-logs
	exec chmod 02750 $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir/run-image/uncaught-logs
	exec rm -rf $(OUTPUT)/rootfs/etc/s6-linux-init/current
	exec mv -f $(OUTPUT)/rootfs/etc/s6-linux-init/s6lidir $(OUTPUT)/rootfs/etc/s6-linux-init/current
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_mdevd_copied: $(OUTPUT)/sources/.lh_mdevd_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/mdevd
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/mdevd $(OUTPUT)/build-host/mdevd
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_mdevd_configured: $(OUTPUT)/build-host/.lh_mdevd_copied $(OUTPUT)/build-host/.lh_skalibs_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/mdevd ./configure --host=$(TRIPLE) --enable-slashpackage $(SKARNET_CONF_STATIC) $(SKALIBS_FIND_OPTIONS)
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-host/.lh_mdevd_built: $(OUTPUT)/build-host/.lh_mdevd_configured $(OUTPUT)/build-host/.lh_skalibs_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/mdevd $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_mdevd_installed: $(OUTPUT)/build-host/.lh_mdevd_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/mdevd $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_bcnm_copied: $(OUTPUT)/sources/.lh_bcnm_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/bcnm
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/bcnm $(OUTPUT)/build-host/bcnm
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_bcnm_configured: $(OUTPUT)/build-host/.lh_bcnm_copied $(OUTPUT)/build-host/.lh_skalibs_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/bcnm ./configure --host=$(TRIPLE) --enable-slashpackage $(SKARNET_CONF_STATIC) $(SKALIBS_FIND_OPTIONS)
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-host/.lh_bcnm_built: $(OUTPUT)/build-host/.lh_bcnm_configured $(OUTPUT)/build-host/.lh_skalibs_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/bcnm $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_bcnm_installed: $(OUTPUT)/build-host/.lh_bcnm_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/bcnm $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_skarnet_installed: $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_execline_installed $(OUTPUT)/build-host/.lh_s6dns_installed $(OUTPUT)/build-host/.lh_s6net_installed $(OUTPUT)/build-host/.lh_s6_installed $(OUTPUT)/build-host/.lh_s6li_laidout $(OUTPUT)/build-host/.lh_mdevd_installed | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@
