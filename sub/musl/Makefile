MUSL_BASE ?= /opt/musl-git

# release 1.1.18
MUSL_VERSION :=	eb03bde2f24582874cb72b56c7811bf51da0c817


# Build-build

$(OUTPUT)/sources/.lh_musl_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if ! test -d $(OUTPUT)/sources/musl ; then cd $(OUTPUT)/sources && git clone git://git.musl-libc.org/musl musl && cd musl && git checkout $(MUSL_VERSION) ; fi
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build$(MUSL_BASE)/.lh_copied: $(OUTPUT)/sources/.lh_musl_cloned
	exec setuidgid $(NORMALUSER) rm -rf $(OUTPUT)/build-build$(MUSL_BASE)/src
	exec setuidgid $(NORMALUSER) mkdir -p $(OUTPUT)/build-build$(MUSL_BASE)
	exec setuidgid $(NORMALUSER) cp -a $(OUTPUT)/sources/musl $(OUTPUT)/build-build$(MUSL_BASE)/src
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build$(MUSL_BASE)/.lh_configured: $(OUTPUT)/build-build$(MUSL_BASE)/.lh_copied
	cd $(OUTPUT)/build-build$(MUSL_BASE)/src && setuidgid $(NORMALUSER) ./configure --prefix=$(OUTPUT)/build-build$(MUSL_BASE) --enable-warnings --enable-gcc-wrapper "CC=$(BUILD_BUILD_CC)"
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build$(MUSL_BASE)/.lh_built: $(OUTPUT)/build-build$(MUSL_BASE)/.lh_configured
	cd $(OUTPUT)/build-build$(MUSL_BASE)/src && setuidgid $(NORMALUSER) $(MAKE)
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build$(MUSL_BASE)/.lh_installed: $(OUTPUT)/build-build$(MUSL_BASE)/.lh_built $(OUTPUT)/build-build/.lh_kernel_headers_installed
	cd $(OUTPUT)/build-build$(MUSL_BASE)/src && setuidgid $(NORMALUSER) $(MAKE) install syslibdir=$(OUTPUT)/build-build$(MUSL_BASE)
	exec setuidgid $(NORMALUSER) makenamelink $(OUTPUT)/build-build$(dir $(MUSL_BASE)) musl $(notdir $(MUSL_BASE)) $(OUTPUT)/tmp
	exec setuidgid $(NORMALUSER) makelinks $(OUTPUT)/build-build $(MUSL_BASE)/include /opt/linux/include
	exec setuidgid $(NORMALUSER) sub/musl/muslgccmake $(OUTPUT)/build-build$(MUSL_BASE)/bin/musl-gcc $(OUTPUT)/build-build$(MUSL_BASE)/lib/musl-gcc.specs $(BUILD_BUILD_CC) true
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/tmp/libssp_nonshared.o: sub/musl/libssp_nonshared.c | $(OUTPUT)/tmp/.lh_prepared
	exec setuidgid $(NORMALUSER) $(BUILD_BUILD_CC) -O2 -o $@ -c $^

$(OUTPUT)/build-build$(MUSL_BASE)/lib/libssp_nonshared.a: $(OUTPUT)/build-build$(MUSL_BASE)/.lh_installed $(OUTPUT)/build-build/tmp/libssp_nonshared.o
	exec setuidgid $(NORMALUSER) ar cr $@ $(OUTPUT)/build-build/tmp/libssp_nonshared.o

$(OUTPUT)/build-build/.lh_gcc: $(OUTPUT)/build-build$(MUSL_BASE)/.lh_installed $(OUTPUT)/tmp/.lh_prepared $(OUTPUT)/build-build$(MUSL_BASE)/lib/libssp_nonshared.a
	exec setuidgid $(NORMALUSER) makelinks $(OUTPUT)/build-build /bin $(dir $(MUSL_BASE))musl/bin
	exec setuidgid $(NORMALUSER) ln -sf musl-gcc $(OUTPUT)/build-build/bin/gcc
	exec setuidgid $(NORMALUSER) touch $@


# Build-host

$(OUTPUT)/build-host/bin/muslgcc: $(OUTPUT)/build-host/kernel/.lh_headers_installed | $(OUTPUT)/tmp/.lh_layout_installed $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) sub/musl/muslgccmake-buildhost $(OUTPUT) $(TRIPLE) $(BUILD_HOST_CC)
	exec setuidgid $(NORMALUSER) s6-ln -sf $(TRIPLE)-muslgcc $@
