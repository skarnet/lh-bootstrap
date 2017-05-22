
$(OUTPUT)/sources/djbdns-1.05.tar.gz: | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget http://cr.yp.to/djbdns/djbdns-1.05.tar.gz

$(OUTPUT)/sources/.lh_djbdns_dled: $(OUTPUT)/sources/djbdns-1.05.tar.gz | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_djbdns_copied: $(OUTPUT)/sources/.lh_djbdns_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/djbdns-1.05
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host tar zxpvf $(OUTPUT)/sources/djbdns-1.05.tar.gz
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/djbdns-1.05 redirfd -r 0 $(WD)/sub/dnscache/djbdns-readiness-notification.patch patch -p1
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_djbdns_patched: $(OUTPUT)/build-host/.lh_djbdns_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) sed -f $(WD)/sub/dnscache/patch.sed $(OUTPUT)/build-host/djbdns-1.05/Makefile > $(OUTPUT)/build-host/djbdns-1.05/Makefile.patched
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_djbdns_configured: $(OUTPUT)/build-host/.lh_djbdns_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-echo "muslgcc -O2 -Wimplicit -Wunused -Wcomment -Wchar-subscripts -Wuninitialized -Wshadow -Wcast-qual -Wcast-align -Wwrite-strings -include errno.h" > $(OUTPUT)/build-host/djbdns-1.05/conf-cc
	exec setuidgid $(NORMALUSER) s6-echo "muslgcc -s -static" > $(OUTPUT)/build-host/djbdns-1.05/conf-ld
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_dnscache_built: $(OUTPUT)/build-host/.lh_djbdns_configured $(OUTPUT)/build-host/.lh_djbdns_patched $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/djbdns-1.05 $(MAKE) -f Makefile.patched dnscache
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_dnscache_installed: $(OUTPUT)/build-host/.lh_dnscache_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec s6-mkdir -p -m 0755 $(OUTPUT)/rootfs/opt/djbdns-1.05/bin
	exec makenamelink $(OUTPUT)/rootfs/opt djbdns djbdns-1.05 $(OUTPUT)/tmp
	exec cp -f $(OUTPUT)/build-host/djbdns-1.05/dnscache $(OUTPUT)/rootfs/opt/djbdns-1.05/bin/dnscache
	exec makelinks $(OUTPUT)/rootfs /bin /opt/djbdns/bin
	exec setuidgid $(NORMALUSER) s6-touch $@
