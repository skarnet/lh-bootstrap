#
# This is the top Makefile for lh-bootstrap
# It is invoked by running "./make" after editing lh-config
#
# Each target, for instance "$(OUTPUT)/tmp/.lh_installed",
# is a witness file, ie the file is not needed anywhere but is
# used by make to handle dependencies. Each of these files is
# being touch-ed at the end of each recipe to update its date,
# since make relies on dates to handle updates of targets.
# 
# * why these "exec" at the beginning at each line?
# => make spawns a shell for every line in every recipe.
# The "exec" keyword at the beginning of the recipe lines
# is just a small optimization: it ensures that the shell
# doesn't stay around while the recipe line is running,
# so it saves a little RAM and CPU. On most build machines,
# this should not be noticeable.
#
# * why these "setuidgid $(NORMALUSER)" ?
# => to drop privileges, from root to a normal user, for recipes
# that do not need root privileges. The user's name is defined in
# lh-config.
#
# * why do we need to be root?
# => Because some unavoidable operations in the build process need root privileges:
#     + correctly handling several different uids for the target.
#     + manipulating and deleting a loopback device, to create the disk images.
#
# * why is skarnet.org often an order-only prerequisite in the sub-Makefiles?
# => When it's the case, it means the build process, not the target,
# depends on a skarnet.org tool (for instance s6-touch) built for the
# BUILD machine. There's no need to rebuild everything if the tool
# changes, since the HOST image does not depend on its details; we
# just need to ensure that the tool is there.


ifndef LH_MAKE_MARKER
$(error Please use "./make target" instead of "make target")
endif


NORMALUSER_UID := $(shell id -u $(NORMALUSER))
NORMALUSER_GID := $(shell id -g $(NORMALUSER))


it: all

.PHONY: it all clean distclean qemu-boot qemu-image virtualbox-image vmware-image


all: qemu-image



# clean everything
distclean:
	exec rm -rf $(OUTPUT)

# clean everything (same as above), minus the sources that were downloaded over the internet
clean:
	ls -1 $(OUTPUT) | grep -vF sources | while read a ; do rm -rf $(OUTPUT)/"$$a" & : ; done ; true
	
# other available targets to clean subsystems:
# clean-busybox
# clean-dropbear
#
# can be called with: ./make clean-busybox
#
# these targets are defined in the corresponding subsystem Makefile


# Prepare the output directory. This is at the bottom of the dependency tree.

$(OUTPUT)/tmp/.lh_prepared: lh-config
	exec mkdir -p -m 0755 -- $(OUTPUT)/tmp $(OUTPUT)/initramfs $(OUTPUT)/rootfs $(OUTPUT)/rwfs $(OUTPUT)/userfs $(OUTPUT)/build-build/bin $(OUTPUT)/build-build/opt $(OUTPUT)/build-build/tmp $(OUTPUT)/build-host/bin $(OUTPUT)/build-host/opt $(OUTPUT)/build-host/tmp $(OUTPUT)/host-host $(OUTPUT)/sources
	exec chown -R -- $(NORMALUSER_UID):$(NORMALUSER_GID) $(OUTPUT)/tmp $(OUTPUT)/build-build $(OUTPUT)/build-host $(OUTPUT)/host-host
	exec chown -- $(NORMALUSER_UID):$(NORMALUSER_GID) $(OUTPUT)/sources $(OUTPUT)
	exec setuidgid $(NORMALUSER) touch $@


# This target builds all the build-time native tools, the real part of the build depends on this target

$(OUTPUT)/build-build/.lh_done: $(OUTPUT)/build-build/.lh_gcc $(OUTPUT)/build-build/.lh_skarnet_installed $(OUTPUT)/build-build/.lh_util-linux_installed $(OUTPUT)/build-build/.lh_kmod_installed
	exec setuidgid $(NORMALUSER) touch $@


# The rootfs

$(OUTPUT)/tmp/.lh_rootfs_installed: $(OUTPUT)/tmp/.lh_layout_installed $(OUTPUT)/build-host/.lh_skarnet_installed $(OUTPUT)/build-host/.lh_socklog_installed $(OUTPUT)/build-host/.lh_bb_installed $(OUTPUT)/build-host/.lh_bbsuid_installed $(OUTPUT)/build-host/.lh_dnscache_installed $(OUTPUT)/build-host/.lh_dropbear_installed $(OUTPUT)/tmp/.lh_initramfs_done $(OUTPUT)/build-host/kernel/.lh_installed
	exec setuidgid $(NORMALUSER) touch $@


# Disk images (raw for qemu, vmdk for virtualbox and vmware)

$(OUTPUT)/tmp/.lh_installed: $(OUTPUT)/tmp/.lh_rootfs_installed $(OUTPUT)/tmp/.lh_initramfs_done $(OUTPUT)/build-host/kernel/.lh_installed
	exec setuidgid $(NORMALUSER) touch $@

$(OUTPUT)/tmp/.lh_diskimage_done: $(OUTPUT)/tmp/.lh_installed $(OUTPUT)/build-build/.lh_done

ifeq ($(KERNEL_GENERIC_ARCH),x86)
include sub/syslinux/Makefile
$(OUTPUT)/tmp/.lh_diskimage_done: $(OUTPUT)/build-build/.lh_$(SYSLINUX_NAME)_installed
endif

$(OUTPUT)/tmp/.lh_diskimage_done:
	exec sub/disk-image/make-disk-image $(OUTPUT) $(ROOTFS_SIZE) $(SWAP_SIZE) $(RWFS_SIZE) $(USERFS_SIZE) $(EXTRA_SIZE)
	exec setuidgid $(NORMALUSER) touch $@

qemu-image: $(OUTPUT)/tmp/.lh_diskimage_done

$(OUTPUT)/disk-image.vmdk: $(OUTPUT)/tmp/.lh_diskimage_done
	exec setuidgid $(NORMALUSER) qemu-img convert -f raw -O vmdk $(OUTPUT)/disk-image.raw $(OUTPUT)/disk-image.vmdk

virtualbox-image: $(OUTPUT)/disk-image.vmdk

vmware-image: $(OUTPUT)/disk-image.vmdk

qemu-boot: $(OUTPUT)/tmp/.lh_diskimage_done
	./qemu-boot $(OUTPUT)



# Subsystems

## libc, toolchains, utilities, for the build itself, or for building the host

include sub/kernel/Makefile
include sub/musl/Makefile
include sub/util-linux/Makefile
include sub/xz/Makefile
include sub/kmod/Makefile


## rootfs contents, what's necessary to get an image to boot and connect to it via ssh

include sub/layout/Makefile
include sub/initramfs/Makefile
include sub/bearssl/Makefile
include sub/skarnet.org/Makefile
include sub/socklog/Makefile
include sub/busybox/Makefile
include sub/dnscache/Makefile
include sub/dropbear/Makefile
