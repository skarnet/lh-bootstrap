MUSL_BASE ?= /opt/musl-git

# Latest version at 2019-05-03
MUSL_VERSION := 2df8b1d806c3e1fd4b6b10e13794855a93fe6628


# Build-build

$(OUTPUT)/sources/.lh_musl_cloned: | $(OUTPUT)/tmp/.lh_prepared
	if ! test -d $(OUTPUT)/sources/musl ; then cd $(OUTPUT)/sources && git clone git://git.musl-libc.org/musl musl && cd musl && git checkout $(MUSL_VERSION) ; fi
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/.lh_gcc: $(OUTPUT)/build-build/bin/gcc
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/build-build/bin/gcc: | $(OUTPUT)/tmp/.lh_prepared
	exec setuidgid $(NORMALUSER) ln -sf $(BUILD_BUILD_CC) $(OUTPUT)/build-build/bin/gcc


# Build-host

$(OUTPUT)/build-host/bin/muslgcc: $(OUTPUT)/build-host/kernel/.lh_headers_installed | $(OUTPUT)/tmp/.lh_layout_installed $(OUTPUT)/build-build/.lh_skarnet_installed
	exec setuidgid $(NORMALUSER) sub/musl/muslgccmake-buildhost $(OUTPUT) $(TRIPLE) $(BUILD_HOST_CC)
	exec setuidgid $(NORMALUSER) s6-ln -sf $(TRIPLE)-muslgcc $@
