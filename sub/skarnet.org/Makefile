
# Sources

url := git://git.skarnet.org
suffix :=

# No VERSION variables, we always use the git head for skarnet.org tools.
# Because if something breaks, I don't want you to work around it:
# I want you to report it to me so I can fix it. :)

$(OUTPUT)/sources/.lh_skalibs_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/skalibs ; then cd $(OUTPUT)/sources/skalibs && setuidgid $(NORMALUSER) git pull ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/skalibs$(suffix) skalibs ; fi
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_execline_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/execline ; then cd $(OUTPUT)/sources/execline && setuidgid $(NORMALUSER) git pull ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/execline$(suffix) execline ; fi
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_s6pu_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/s6-portable-utils ; then cd $(OUTPUT)/sources/s6-portable-utils && setuidgid $(NORMALUSER) git pull ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/s6-portable-utils$(suffix) s6-portable-utils ; fi
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_s6lu_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/s6-linux-utils ; then cd $(OUTPUT)/sources/s6-linux-utils && setuidgid $(NORMALUSER) git pull ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/s6-linux-utils$(suffix) s6-linux-utils ; fi
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_s6dns_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/s6-dns ; then cd $(OUTPUT)/sources/s6-dns && setuidgid $(NORMALUSER) git pull ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/s6-dns$(suffix) s6-dns ; fi
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_s6net_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/s6-networking ; then cd $(OUTPUT)/sources/s6-networking && setuidgid $(NORMALUSER) git pull ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/s6-networking$(suffix) s6-networking ; fi
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_s6_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/s6 ; then cd $(OUTPUT)/sources/s6 && setuidgid $(NORMALUSER) git pull ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/s6$(suffix) s6 ; fi
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_s6rc_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/s6-rc ; then cd $(OUTPUT)/sources/s6-rc && setuidgid $(NORMALUSER) git pull ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/s6-rc$(suffix) s6-rc ; fi
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_s6li_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/s6-linux-init ; then cd $(OUTPUT)/sources/s6-linux-init && setuidgid $(NORMALUSER) git pull ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/s6-linux-init$(suffix) s6-linux-init ; fi
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/sources/.lh_mdevd_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if test -d $(OUTPUT)/sources/mdevd ; then cd $(OUTPUT)/sources/mdevd && setuidgid $(NORMALUSER) git pull ; else cd $(OUTPUT)/sources && setuidgid $(NORMALUSER) git clone $(url)/mdevd$(suffix) mdevd ; fi
	exec setuidgid $(NORMALUSER) touch $@



# Build-build

$(OUTPUT)/build-build/.lh_skalibs_copied: $(OUTPUT)/sources/.lh_skalibs_cloned
	exec setuidgid $(NORMALUSER) rm -rf -- $(OUTPUT)/build-build/tmp/skalibs
	exec setuidgid $(NORMALUSER) cp -RP -- $(OUTPUT)/sources/skalibs $(OUTPUT)/build-build/tmp/skalibs
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_skalibs_configured: $(OUTPUT)/build-build/.lh_skalibs_copied $(OUTPUT)/build-build/.lh_gcc
	cd $(OUTPUT)/build-build/tmp/skalibs && setuidgid $(NORMALUSER) ./configure --enable-tai-clock --enable-slashpackage --with-default-path=/command:/bin --disable-shared
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

$(OUTPUT)/build-build/.lh_execline_configured: $(OUTPUT)/build-build/.lh_execline_copied $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_gcc
	cd $(OUTPUT)/build-build/tmp/execline && setuidgid $(NORMALUSER) ./configure --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/build-build/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/build-build/package/prog/skalibs/include --with-lib=$(OUTPUT)/build-build/package/prog/skalibs/library
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

$(OUTPUT)/build-build/.lh_s6pu_configured: $(OUTPUT)/build-build/.lh_s6pu_copied $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_gcc
	cd $(OUTPUT)/build-build/tmp/s6-portable-utils && setuidgid $(NORMALUSER) ./configure --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/build-build/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/build-build/package/prog/skalibs/include --with-lib=$(OUTPUT)/build-build/package/prog/skalibs/library
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

$(OUTPUT)/build-build/.lh_s6_configured: $(OUTPUT)/build-build/.lh_s6_copied $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_execline_installed $(OUTPUT)/build-build/.lh_gcc
	cd $(OUTPUT)/build-build/tmp/s6 && setuidgid $(NORMALUSER) ./configure --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/build-build/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/build-build/package/prog/skalibs/include --with-lib=$(OUTPUT)/build-build/package/prog/skalibs/library --with-include=$(OUTPUT)/build-build/package/admin/execline/include --with-lib=$(OUTPUT)/build-build/package/admin/execline/library
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6_built: $(OUTPUT)/build-build/.lh_s6_configured $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_execline_installed
	cd $(OUTPUT)/build-build/tmp/s6 && setuidgid $(NORMALUSER) $(MAKE) all strip
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6_installed: $(OUTPUT)/build-build/.lh_s6_built
	cd $(OUTPUT)/build-build/tmp/s6 && setuidgid $(NORMALUSER) $(MAKE) install update global-links DESTDIR=$(OUTPUT)/build-build
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-build/.lh_s6rc_copied: $(OUTPUT)/sources/.lh_s6rc_cloned
	exec setuidgid $(NORMALUSER) rm -rf $(OUTPUT)/build-build/tmp/s6-rc
	exec setuidgid $(NORMALUSER) cp -a $(OUTPUT)/sources/s6-rc $(OUTPUT)/build-build/tmp/s6-rc
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6rc_configured: $(OUTPUT)/build-build/.lh_s6rc_copied $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_execline_installed $(OUTPUT)/build-build/.lh_s6_installed $(OUTPUT)/build-build/.lh_gcc $(OUTPUT)/build-build/.lh_s6_installed
	cd $(OUTPUT)/build-build/tmp/s6-rc && setuidgid $(NORMALUSER) ./configure --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/build-build/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/build-build/package/prog/skalibs/include --with-lib=$(OUTPUT)/build-build/package/prog/skalibs/library --with-include=$(OUTPUT)/build-build/package/admin/execline/include --with-lib=$(OUTPUT)/build-build/package/admin/execline/library --with-include=$(OUTPUT)/build-build/package/admin/s6/include --with-lib=$(OUTPUT)/build-build/package/admin/s6/library
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6rc_built: $(OUTPUT)/build-build/.lh_s6rc_configured $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_execline_installed $(OUTPUT)/build-build/.lh_s6_installed
	cd $(OUTPUT)/build-build/tmp/s6-rc && setuidgid $(NORMALUSER) $(MAKE) all strip
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6rc_installed: $(OUTPUT)/build-build/.lh_s6rc_built
	cd $(OUTPUT)/build-build/tmp/s6-rc && setuidgid $(NORMALUSER) $(MAKE) install update global-links DESTDIR=$(OUTPUT)/build-build
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-build/.lh_s6dns_copied: $(OUTPUT)/sources/.lh_s6dns_cloned
	exec setuidgid $(NORMALUSER) rm -rf $(OUTPUT)/build-build/tmp/s6-dns
	exec setuidgid $(NORMALUSER) cp -a $(OUTPUT)/sources/s6-dns $(OUTPUT)/build-build/tmp/s6-dns
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6dns_configured: $(OUTPUT)/build-build/.lh_s6dns_copied $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_gcc
	cd $(OUTPUT)/build-build/tmp/s6-dns && setuidgid $(NORMALUSER) ./configure --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/build-build/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/build-build/package/prog/skalibs/include --with-lib=$(OUTPUT)/build-build/package/prog/skalibs/library
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6dns_built: $(OUTPUT)/build-build/.lh_s6dns_configured $(OUTPUT)/build-build/.lh_skalibs_installed
	cd $(OUTPUT)/build-build/tmp/s6-dns && setuidgid $(NORMALUSER) $(MAKE) all strip
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_s6dns_installed: $(OUTPUT)/build-build/.lh_s6dns_built
	cd $(OUTPUT)/build-build/tmp/s6-dns && setuidgid $(NORMALUSER) $(MAKE) install update global-links DESTDIR=$(OUTPUT)/build-build
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-build/.lh_skarnet_installed: $(OUTPUT)/build-build/.lh_skalibs_installed $(OUTPUT)/build-build/.lh_execline_installed $(OUTPUT)/build-build/.lh_s6pu_installed $(OUTPUT)/build-build/.lh_s6_installed $(OUTPUT)/build-build/.lh_s6rc_installed $(OUTPUT)/build-build/.lh_s6dns_installed
	exec setuidgid $(NORMALUSER) touch $@



# Build-host


$(OUTPUT)/build-host/.lh_skalibs_copied: $(OUTPUT)/sources/.lh_skalibs_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/skalibs
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/skalibs $(OUTPUT)/build-host/skalibs
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_skalibs_configured: $(OUTPUT)/build-host/.lh_skalibs_copied $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/skalibs export CC muslgcc ./configure --host=$(TRIPLE) --with-sysdeps=$(WD)/sysdeps/$(TRIPLE) --enable-tai-clock --enable-slashpackage --with-default-path=/command:/bin --disable-shared
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_skalibs_built: $(OUTPUT)/build-host/.lh_skalibs_configured $(OUTPUT)/build-host/bin/muslgcc| $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/skalibs $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_skalibs_installed: $(OUTPUT)/build-host/.lh_skalibs_built $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	cd $(OUTPUT)/build-host/skalibs && $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) touch $@


$(OUTPUT)/build-host/.lh_execline_copied: $(OUTPUT)/sources/.lh_execline_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/execline
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/execline $(OUTPUT)/build-host/execline
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_execline_configured: $(OUTPUT)/build-host/.lh_execline_copied $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/execline export CC muslgcc ./configure --host=$(TRIPLE) --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/rootfs/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/rootfs/package/prog/skalibs/include --with-lib=$(OUTPUT)/rootfs/package/prog/skalibs/library
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_execline_built: $(OUTPUT)/build-host/.lh_execline_configured $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/execline $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_execline_installed: $(OUTPUT)/build-host/.lh_execline_built $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/execline $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_s6pu_copied: $(OUTPUT)/sources/.lh_s6pu_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/s6-portable-utils
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/s6-portable-utils $(OUTPUT)/build-host/s6-portable-utils
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6pu_configured: $(OUTPUT)/build-host/.lh_s6pu_copied $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-portable-utils export CC muslgcc ./configure --host=$(TRIPLE) --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/rootfs/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/rootfs/package/prog/skalibs/include --with-lib=$(OUTPUT)/rootfs/package/prog/skalibs/library
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6pu_built: $(OUTPUT)/build-host/.lh_s6pu_configured $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-portable-utils $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6pu_installed: $(OUTPUT)/build-host/.lh_s6pu_built $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/s6-portable-utils $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_s6lu_copied: $(OUTPUT)/sources/.lh_s6lu_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/s6-linux-utils
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/s6-linux-utils $(OUTPUT)/build-host/s6-linux-utils
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6lu_configured: $(OUTPUT)/build-host/.lh_s6lu_copied $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-linux-utils export CC muslgcc ./configure --host=$(TRIPLE) --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/rootfs/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/rootfs/package/prog/skalibs/include --with-lib=$(OUTPUT)/rootfs/package/prog/skalibs/library
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6lu_built: $(OUTPUT)/build-host/.lh_s6lu_configured $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-linux-utils $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6lu_installed: $(OUTPUT)/build-host/.lh_s6lu_built $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/s6-linux-utils $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_s6dns_copied: $(OUTPUT)/sources/.lh_s6dns_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/s6-dns
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/s6-dns $(OUTPUT)/build-host/s6-dns
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6dns_configured: $(OUTPUT)/build-host/.lh_s6dns_copied $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-dns export CC muslgcc ./configure --host=$(TRIPLE) --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/rootfs/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/rootfs/package/prog/skalibs/include --with-lib=$(OUTPUT)/rootfs/package/prog/skalibs/library
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6dns_built: $(OUTPUT)/build-host/.lh_s6dns_configured $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-dns $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6dns_installed: $(OUTPUT)/build-host/.lh_s6dns_built $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/s6-dns $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_s6net_copied: $(OUTPUT)/sources/.lh_s6net_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/s6-networking
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/s6-networking $(OUTPUT)/build-host/s6-networking
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6net_configured: $(OUTPUT)/build-host/.lh_s6net_copied $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_s6dns_installed $(OUTPUT)/build-host/.lh_execline_installed $(OUTPUT)/build-host/.lh_s6_installed $(OUTPUT)/build-host/.lh_bearssl_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-networking export CC muslgcc ./configure --host=$(TRIPLE) --enable-slashpackage --enable-static-libc --enable-ssl=bearssl --with-ssl-path=$(OUTPUT)/rootfs/opt/bearssl --with-sysdeps=$(OUTPUT)/rootfs/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/rootfs/package/prog/skalibs/include --with-lib=$(OUTPUT)/rootfs/package/prog/skalibs/library --with-include=$(OUTPUT)/rootfs/package/web/s6-dns/include --with-lib=$(OUTPUT)/rootfs/package/web/s6-dns/library --with-include=$(OUTPUT)/rootfs/package/admin/execline/include --with-lib=$(OUTPUT)/rootfs/package/admin/execline/library --with-include=$(OUTPUT)/rootfs/package/admin/s6/include --with-lib=$(OUTPUT)/rootfs/package/admin/s6/library
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6net_built: $(OUTPUT)/build-host/.lh_s6net_configured $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_s6dns_installed $(OUTPUT)/build-host/.lh_execline_installed $(OUTPUT)/build-host/.lh_s6_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-networking $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6net_installed: $(OUTPUT)/build-host/.lh_s6net_built $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/s6-networking $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_s6_copied: $(OUTPUT)/sources/.lh_s6_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/s6
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/s6 $(OUTPUT)/build-host/s6
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6_configured: $(OUTPUT)/build-host/.lh_s6_copied $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_execline_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6 export CC muslgcc ./configure --host=$(TRIPLE) --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/rootfs/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/rootfs/package/prog/skalibs/include --with-lib=$(OUTPUT)/rootfs/package/prog/skalibs/library --with-include=$(OUTPUT)/rootfs/package/admin/execline/include --with-lib=$(OUTPUT)/rootfs/package/admin/execline/library
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6_built: $(OUTPUT)/build-host/.lh_s6_configured $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_execline_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6 $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6_installed: $(OUTPUT)/build-host/.lh_s6_built $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/s6 $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_s6rc_copied: $(OUTPUT)/sources/.lh_s6rc_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/s6-rc
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/s6-rc $(OUTPUT)/build-host/s6-rc
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6rc_configured: $(OUTPUT)/build-host/.lh_s6rc_copied $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_execline_installed $(OUTPUT)/build-host/.lh_s6_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-rc export CC muslgcc ./configure --host=$(TRIPLE) --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/rootfs/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/rootfs/package/prog/skalibs/include --with-lib=$(OUTPUT)/rootfs/package/prog/skalibs/library --with-include=$(OUTPUT)/rootfs/package/admin/execline/include --with-lib=$(OUTPUT)/rootfs/package/admin/execline/library --with-include=$(OUTPUT)/rootfs/package/admin/s6/include --with-lib=$(OUTPUT)/rootfs/package/admin/s6/library
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-host/.lh_s6rc_built: $(OUTPUT)/build-host/.lh_s6rc_configured $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_execline_installed $(OUTPUT)/build-host/.lh_s6_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-rc $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6rc_installed: $(OUTPUT)/build-host/.lh_s6rc_built $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/s6-rc $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_s6li_copied: $(OUTPUT)/sources/.lh_s6li_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/s6-linux-init
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/s6-linux-init $(OUTPUT)/build-host/s6-linux-init
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6li_configured: $(OUTPUT)/build-host/.lh_s6li_copied $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-linux-init export CC muslgcc ./configure --host=$(TRIPLE) --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/rootfs/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/rootfs/package/prog/skalibs/include --with-lib=$(OUTPUT)/rootfs/package/prog/skalibs/library
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-host/.lh_s6li_built: $(OUTPUT)/build-host/.lh_s6li_configured $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/s6-linux-init $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_s6li_installed: $(OUTPUT)/build-host/.lh_s6li_built $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/s6-linux-init $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_mdevd_copied: $(OUTPUT)/sources/.lh_mdevd_cloned | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/mdevd
	exec setuidgid $(NORMALUSER) s6-hiercopy $(OUTPUT)/sources/mdevd $(OUTPUT)/build-host/mdevd
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_mdevd_configured: $(OUTPUT)/build-host/.lh_mdevd_copied $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/mdevd export CC muslgcc ./configure --host=$(TRIPLE) --enable-slashpackage --enable-static-libc --with-sysdeps=$(OUTPUT)/rootfs/package/prog/skalibs/sysdeps --with-include=$(OUTPUT)/rootfs/package/prog/skalibs/include --with-lib=$(OUTPUT)/rootfs/package/prog/skalibs/library
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-host/.lh_mdevd_built: $(OUTPUT)/build-host/.lh_mdevd_configured $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/mdevd $(MAKE) all strip
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_mdevd_installed: $(OUTPUT)/build-host/.lh_mdevd_built $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec cd $(OUTPUT)/build-host/mdevd $(MAKE) install update global-links DESTDIR=$(OUTPUT)/rootfs
	exec setuidgid $(NORMALUSER) s6-touch $@


$(OUTPUT)/build-host/.lh_skarnet_installed: $(OUTPUT)/build-host/.lh_skalibs_installed $(OUTPUT)/build-host/.lh_execline_installed $(OUTPUT)/build-host/.lh_s6pu_installed $(OUTPUT)/build-host/.lh_s6lu_installed $(OUTPUT)/build-host/.lh_s6dns_installed $(OUTPUT)/build-host/.lh_s6net_installed $(OUTPUT)/build-host/.lh_s6_installed $(OUTPUT)/build-host/.lh_s6rc_installed $(OUTPUT)/build-host/.lh_s6li_installed $(OUTPUT)/build-host/.lh_mdevd_installed $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@
