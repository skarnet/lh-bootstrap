
$(OUTPUT)/sources/socklog-2.1.0.tar.gz: | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/sources wget http://smarden.org/socklog/socklog-2.1.0.tar.gz

$(OUTPUT)/sources/.lh_socklog_dled: $(OUTPUT)/sources/socklog-2.1.0.tar.gz | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_socklog_copied: $(OUTPUT)/sources/.lh_socklog_dled | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-rmrf $(OUTPUT)/build-host/package/admin/socklog-2.1.0
	exec setuidgid $(NORMALUSER) s6-mkdir -p -- $(OUTPUT)/build-host/package
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/package tar zxpvf $(OUTPUT)/sources/socklog-2.1.0.tar.gz
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_socklog_patched: $(OUTPUT)/build-host/.lh_socklog_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) sed -f $(WD)/sub/socklog/patch.sed $(OUTPUT)/build-host/package/admin/socklog-2.1.0/src/Makefile > $(OUTPUT)/build-host/package/admin/socklog-2.1.0/src/Makefile.patched
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_socklog_configured: $(OUTPUT)/build-host/.lh_socklog_copied | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) s6-echo "muslgcc -O2 -Wimplicit -Wunused -Wcomment -Wchar-subscripts -Wuninitialized -Wshadow -Wcast-qual -Wcast-align -Wwrite-strings -include errno.h" > $(OUTPUT)/build-host/package/admin/socklog-2.1.0/src/conf-cc
	exec setuidgid $(NORMALUSER) s6-echo "muslgcc -s -static" > $(OUTPUT)/build-host/package/admin/socklog-2.1.0/src/conf-ld
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_socklog_built: $(OUTPUT)/build-host/.lh_socklog_configured $(OUTPUT)/build-host/.lh_socklog_patched $(OUTPUT)/build-host/bin/muslgcc | $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) cd $(OUTPUT)/build-host/package/admin/socklog-2.1.0/src $(MAKE) -f Makefile.patched socklog
	exec setuidgid $(NORMALUSER) s6-touch $@

$(OUTPUT)/build-host/.lh_socklog_installed: $(OUTPUT)/build-host/.lh_socklog_built | $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build/.lh_skarnet_installed
	exec s6-mkdir -p -m 0755 $(OUTPUT)/rootfs/package/admin/socklog-2.1.0/command
	exec makenamelink $(OUTPUT)/rootfs/package/admin socklog socklog-2.1.0 $(OUTPUT)/tmp
	exec cp -f $(OUTPUT)/build-host/package/admin/socklog-2.1.0/src/socklog $(OUTPUT)/rootfs/package/admin/socklog-2.1.0/command/socklog
	exec makelinks $(OUTPUT)/rootfs /command /package/admin/socklog/command
	exec setuidgid $(NORMALUSER) s6-touch $@
