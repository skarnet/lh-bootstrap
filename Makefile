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
kernel: $(OUTPUT)/build-host/kernel/.lh_installed $(OUTPUT)/build-host/kernel/.lh_modules_installed
rootfs: $(OUTPUT)/tmp/.lh_rootfs_installed
rwfs: $(OUTPUT)/tmp/.lh_rwfs_installed
userfs: $(OUTPUT)/tmp/.lh_userfs_installed
images: $(OUTPUT)/tmp/.lh_diskimages_done


# clean everything
distclean:
	exec rm -rf $(OUTPUT)

# clean everything (same as above), minus the sources that were downloaded over the internet
clean:
	ls -1 $(OUTPUT) | grep -vF sources | while read a ; do rm -rf $(OUTPUT)/"$$a" & : ; done ; true
	

# Prepare the output directory. This is at the bottom of the dependency tree.

$(OUTPUT)/tmp/.lh_prepared: lh-config
	exec mkdir -p -m 0755 -- $(OUTPUT)/tmp $(OUTPUT)/rootfs $(OUTPUT)/rwfs $(OUTPUT)/userfs $(OUTPUT)/build-build/bin $(OUTPUT)/build-build/opt $(OUTPUT)/build-build/tmp $(OUTPUT)/build-host/bin $(OUTPUT)/build-host/opt $(OUTPUT)/build-host/tmp $(OUTPUT)/host-host $(OUTPUT)/sources
	exec chown -R -- $(NORMALUSER_UID):$(NORMALUSER_GID) $(OUTPUT)/tmp $(OUTPUT)/build-build $(OUTPUT)/build-host $(OUTPUT)/host-host
	exec chown -- $(NORMALUSER_UID):$(NORMALUSER_GID) $(OUTPUT)/sources $(OUTPUT)
	exec setuidgid $(NORMALUSER) touch $@


# This target builds all the build-time native tools, the real part of the build depends on this target

$(OUTPUT)/build-build/.lh_done: $(OUTPUT)/build-build/.lh_skarnet_installed $(OUTPUT)/build-build/.lh_util-linux_installed $(OUTPUT)/build-build/.lh_kmod_installed
	exec setuidgid $(NORMALUSER) touch $@


# The filesystems

$(OUTPUT)/tmp/.lh_rootfs_installed: $(OUTPUT)/tmp/.lh_layout_installed $(OUTPUT)/build-host/.lh_skarnet_installed $(OUTPUT)/build-host/.lh_socklog_installed $(OUTPUT)/build-host/.lh_bb_installed $(OUTPUT)/build-host/.lh_dropbear_installed
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/tmp/.lh_rwfs_installed: $(OUTPUT)/tmp/.lh_layout_installed
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/tmp/.lh_userfs_installed: $(OUTPUT)/tmp/.lh_layout_installed
	exec setuidgid $(NORMALUSER) touch $@


# The qemu disk images (requires qemu and libguestfs-tools)

$(OUTPUT)/tmp/.lh_diskimages_done: $(OUTPUT)/build-host/kernel/.lh_modules_installed $(OUTPUT)/tmp/.lh_rootfs_installed $(OUTPUT)/tmp/.lh_rwfs_installed $(OUTPUT)/tmp/.lh_userfs_installed
	virt-make-fs --format=qcow2 --type=ext4 --size=$(ROOTFS_SIZE) $(OUTPUT)/rootfs $(OUTPUT)/rootfs.qcow2 & \
	virt-make-fs --format=qcow2 --type=ext4 --size=$(RWFS_SIZE) $(OUTPUT)/rwfs $(OUTPUT)/rwfs.qcow2 & \
	virt-make-fs --format=qcow2 --type=ext4 --size=$(USERFS_SIZE) $(OUTPUT)/userfs $(OUTPUT)/userfs.qcow2 & wait
	exec chown $(NORMALUSER_UID):$(NORMALUSER_GID) $(OUTPUT)/rootfs.qcow2 $(OUTPUT)/rwfs.qcow2 $(OUTPUT)/userfs.qcow2
	exec setuidgid $(NORMALUSER) touch $@

qemu-boot: $(OUTPUT)/build-host/kernel/.lh_installed $(OUTPUT)/tmp/.lh_diskimages_done run-qemu
	exec setuidgid $(NORMALUSER) ./run-qemu


# Subsystems

## libc, toolchains, utilities, for the build itself, or for building the host

include sub/kernel/Makefile
include sub/xz/Makefile
include sub/kmod/Makefile


## rootfs contents, what's necessary to get an image to boot and connect to it via ssh

include sub/layout/Makefile
include sub/bearssl/Makefile
include sub/skarnet.org/Makefile
include sub/socklog/Makefile
include sub/busybox/Makefile
include sub/dropbear/Makefile
