#!/bin/sh -e

# the bootstrap can only run as root
test $(id -u) -eq 0 || { echo './make: fatal: you are not root. Please read the README.md file.' 1>&2 ; exit 1 ; }


# sourcing your configuration file
. ./lh-config


# checking if the configuration file is missing some variables, if that's the case we exit with an error
if test -z "$USE_DHCP" || test -z "$NORMALUSER" || test -z "$ROOTFS_SIZE" || test -z "$SWAP_SIZE" || test -z "$RWFS_SIZE" || test -z "$USERFS_SIZE" || test -z "$EXTRA_SIZE" || test -z "$TRIPLE" || test -z "$USE_GRAPHIC" ; then
  echo "./make: fatal: some variable definitions are missing from lh-config." 1>&2
  exit 1
fi


WD=$(pwd)
BUILD_BUILD_CC=${BUILD_BUILD_CC:-/usr/bin/gcc} # do not change this: it needs to be an absolute path. Users can override it in lh-config.
OUTPUT=${OUTPUT:-$WD/output}
BUILD_HOST_CC="$TRIPLE-${CROSS_CC:-gcc}"
USE_TAP=${USE_TAP:-false}   # TODO: backend specific, move to backends
USE_VIRTIO_NETWORK=${USE_VIRTIO_NETWORK:-false} # allow end user to choose
USE_VIRTIO_DISK=${USE_VIRTIO_DISK:-false}

# Properly build musl and friends if the default toolchain produces PIE
if ${BUILD_BUILD_CC} -dM -E - < /dev/null | grep -qF __PIE__ ; then
  BUILD_BUILD_CC="$BUILD_BUILD_CC -fPIC"
fi

# By default, give up if all services aren't up 30 seconds after boot.
# This allows shutting down the machine (via s6-poweroff) even if the
# network fails to start, for instance.
S6RC_TIMEOUT=${S6RC_TIMEOUT:-30000}

if test -n "$CROSS_BASE" ; then
  crossenv=""
else
  crossenv="LH_MAKE_CROSS=1"
  CROSS_BASE="$OUTPUT/build-host/$TRIPLE"
fi

BUILD_HOST_CC_FULL="$CROSS_BASE/bin/$BUILD_HOST_CC"
BUILD_HOST_SYSROOT="$CROSS_BASE/$TRIPLE"
BUILD_HOST_PREFIX="$CROSS_BASE/bin/$TRIPLE"

hostarch=$(echo $TRIPLE | cut -f1 -d-)
# This is used extensively throughout the whole build: different subsystems have different names for the architecture
case $hostarch in
  i?86) KERNEL_ARCH=$hostarch ; QEMU_ARCH=i386 ; KERNEL_GENERIC_ARCH=x86 ;;
  x86_64) KERNEL_ARCH=$hostarch ; QEMU_ARCH=$hostarch ; KERNEL_GENERIC_ARCH=x86 ;;
  arm*) KERNEL_ARCH=arm ; QEMU_ARCH=arm ; KERNEL_GENERIC_ARCH=arm ;;
  aarch64*) KERNEL_ARCH=arm64 ; QEMU_ARCH=aarch64 ; KERNEL_GENERIC_ARCH=arm64 ;;
  default) echo "make: fatal: invalid TRIPLE variable" 1>&2 ; exit 100 ;;
esac

KERNEL_CONFIG=${KERNEL_CONFIG:-./sub/kernel/qemu-system-${QEMU_ARCH}-config}
PATH="$WD/bin:$OUTPUT/build-build/command:$OUTPUT/build-build/bin:$OUTPUT/build-host/bin:$CROSS_BASE/bin:$PATH"

umask 022
exec env -i $crossenv LH_MAKE_MARKER=1 "WD=$WD" "LOCAL_IP=$LOCAL_IP" "ROUTER_IP=$ROUTER_IP" "COUNTRY_CODE=$COUNTRY_CODE" "NORMALUSER=$NORMALUSER" "TRIPLE=$TRIPLE" "OUTPUT=$OUTPUT" "PATH=$PATH" \
  "ROOTFS_SIZE=$ROOTFS_SIZE" "SWAP_SIZE=$SWAP_SIZE" "RWFS_SIZE=$RWFS_SIZE" "USERFS_SIZE=$USERFS_SIZE" "EXTRA_SIZE=$EXTRA_SIZE" \
  "HOST_HOST_BASE=$HOST_HOST_BASE" "BUILD_HOST_CC=$BUILD_HOST_CC" "BUILD_HOST_CC_FULL=$BUILD_HOST_CC_FULL" "BUILD_HOST_SYSROOT=$BUILD_HOST_SYSROOT" "BUILD_HOST_PREFIX=$BUILD_HOST_PREFIX" \
  "KERNEL_ARCH=$KERNEL_ARCH" "KERNEL_GENERIC_ARCH=$KERNEL_GENERIC_ARCH" "QEMU_ARCH=$QEMU_ARCH" "USE_DHCP=$USE_DHCP" "KERNEL_CONFIG=$KERNEL_CONFIG" \
  "BUILD_BUILD_CC=$BUILD_BUILD_CC" SHELL=/bin/sh "USE_GRAPHIC=$USE_GRAPHIC" "USE_TAP=$USE_TAP" "USE_VIRTIO_NETWORK=$USE_VIRTIO_NETWORK" "USE_VIRTIO_DISK=$USE_VIRTIO_DISK" \
  "S6RC_TIMEOUT=$S6RC_TIMEOUT" \
  make "$@"
