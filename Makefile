#
# This is the top Makefile for lh-bootstrap
# It is invoked by running "./make" after editing lh-config
#
# Each target, for instance "$(OUTPUT)/tmp/.lh_installed",
# is a witness file, ie the file is not needed anywhere but is
# used by make to handle dependencies. Each of these files is
# being touched at the end of each recipe to update its date,
# since make relies on dates to handle updates of targets.


ifndef LH_MAKE_MARKER
$(error Please use "./make target" instead of "make target")
endif


NORMALUSER_UID := $(shell id -u $(NORMALUSER))
NORMALUSER_GID := $(shell id -g $(NORMALUSER))


it: all

.PHONY: it all kernel rootfs rwfs userfs images qemu-boot clean distclean


all: kernel rootfs rwfs userfs images
kernel: $(OUTPUT)/build-$(TRIPLE)/kernel/.lh_installed $(OUTPUT)/build-$(TRIPLE)/kernel/.lh_modules_installed
rootfs: $(OUTPUT)/tmp/.lh_rootfs_installed
rwfs: $(OUTPUT)/tmp/.lh_rwfs_installed
userfs: $(OUTPUT)/tmp/.lh_userfs_installed
images: $(OUTPUT)/tmp/.lh_diskimages_done

ifeq ($(LH_DEV),true)
include sub/dev/Makefile.strace
include sub/dev/Makefile.make
include sub/dev/Makefile.zlib
include sub/dev/Makefile.libressl
include sub/dev/Makefile.curl
include sub/dev/Makefile.git
LH_DEV_TARGETS := $(OUTPUT)/build-$(TRIPLE)/.lh_strace_installed $(OUTPUT)/build-$(TRIPLE)/.lh_make_installed $(OUTPUT)/build-$(TRIPLE)/.lh_zlib_installed $(OUTPUT)/build-$(TRIPLE)/.lh_libressl_installed $(OUTPUT)/build-$(TRIPLE)/.lh_curl_installed $(OUTPUT)/build-$(TRIPLE)/.lh_git_installed
else
LH_DEV_TARGETS :=
endif

# clean everything
distclean:
	exec rm -rf $(OUTPUT)

# clean everything (same as above), minus the sources that were downloaded over the internet
clean:
	ls -1 $(OUTPUT) | grep -vF sources | while read a ; do rm -rf $(OUTPUT)/"$$a" & : ; done ; true
	

# Prepare the output directory. This is at the bottom of the dependency tree.

$(OUTPUT)/tmp/.lh_prepared: lh-config
	exec mkdir -p -m 0755 -- $(OUTPUT)/tmp $(OUTPUT)/rootfs $(OUTPUT)/rwfs $(OUTPUT)/userfs $(OUTPUT)/build-build/bin $(OUTPUT)/build-build/opt $(OUTPUT)/build-build/tmp $(OUTPUT)/build-$(TRIPLE)/bin $(OUTPUT)/build-$(TRIPLE)/opt $(OUTPUT)/build-$(TRIPLE)/tmp $(OUTPUT)/sources
	exec chown -R -- $(NORMALUSER_UID):$(NORMALUSER_GID) $(OUTPUT)/tmp $(OUTPUT)/build-build $(OUTPUT)/build-$(TRIPLE)
	exec chown -- $(NORMALUSER_UID):$(NORMALUSER_GID) $(OUTPUT)/sources $(OUTPUT)
	exec setuidgid $(NORMALUSER) touch $@


# This target builds all the build-time native tools, the real part of the build depends on this target

$(OUTPUT)/build-build/.lh_done: $(OUTPUT)/build-build/.lh_skarnet_installed $(OUTPUT)/build-build/.lh_util-linux_installed $(OUTPUT)/build-build/.lh_kmod_installed $(OUTPUT)/build-build/.lh_e2fsprogs_installed
	exec setuidgid $(NORMALUSER) touch $@


# The filesystems

$(OUTPUT)/tmp/.lh_rootfs_installed: $(OUTPUT)/tmp/.lh_layout_installed $(OUTPUT)/build-$(TRIPLE)/.lh_skarnet_installed $(OUTPUT)/build-$(TRIPLE)/.lh_bb_installed $(OUTPUT)/build-$(TRIPLE)/.lh_dropbear_installed $(LH_DEV_TARGETS)

	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/tmp/.lh_rwfs_installed: $(OUTPUT)/tmp/.lh_layout_installed
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/tmp/.lh_userfs_installed: $(OUTPUT)/tmp/.lh_layout_installed
	exec setuidgid $(NORMALUSER) touch $@


# The qemu disk images (requires qemu)

$(OUTPUT)/tmp/.lh_diskimages_done: $(OUTPUT)/build-$(TRIPLE)/kernel/.lh_modules_installed $(OUTPUT)/tmp/.lh_rootfs_installed $(OUTPUT)/tmp/.lh_rwfs_installed $(OUTPUT)/tmp/.lh_userfs_installed | $(OUTPUT)/build-build/.lh_done
	setuidgid $(NORMALUSER) makeqcow2 $(OUTPUT)/rootfs $(ROOTFS_SIZE) & \
	setuidgid $(NORMALUSER) makeqcow2 $(OUTPUT)/rwfs $(RWFS_SIZE) & \
	setuidgid $(NORMALUSER) makeqcow2 $(OUTPUT)/userfs $(USERFS_SIZE) & wait
	exec setuidgid $(NORMALUSER) touch $@

qemu-boot:
	exec setuidgid $(NORMALUSER) ./run-qemu


# Subsystems

## libc, toolchains, utilities, for the build itself, or for building the host

include sub/kernel/Makefile
include sub/xz/Makefile
include sub/kmod/Makefile
include sub/e2fsprogs/Makefile


## rootfs contents, what's necessary to get an image to boot and connect to it via ssh

include sub/layout/Makefile
include sub/bearssl/Makefile
include sub/skarnet.org/Makefile
include sub/busybox/Makefile
include sub/dropbear/Makefile
