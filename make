#!/bin/sh -e

# the bootstrap can only run as root
test $(id -u) -eq 0 || { echo './make: fatal: you are not root. Please read the README.md file.' 1>&2 ; exit 1 ; }


# sourcing your configuration file
. ./lh-config


# checking if the configuration file is missing some variables, if that's the case we exit with an error
if test -z "$NORMALUSER" || test -z "$ROOTFS_SIZE" || test -z "$TRIPLE" ; then
  echo "./make: fatal: some variable definitions are missing from lh-config." 1>&2
  exit 1
fi


WD=$(pwd)
BUILD_BUILD_CC=${BUILD_BUILD_CC:-gcc}
OUTPUT=${OUTPUT:-$WD/output}
BUILD_HOST_CC="$TRIPLE-${CROSS_CC:-gcc}"

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

KERNEL_CONFIG=${KERNEL_CONFIG:-sub/kernel/qemu-system-${hostarch}-config}
PATH="$WD/bin:$OUTPUT/build-build/command:$OUTPUT/build-build/bin:$OUTPUT/build-host/bin:$CROSS_BASE/bin:$PATH"

umask 022
exec env -i $crossenv LH_MAKE_MARKER=1 "WD=$WD" "NORMALUSER=$NORMALUSER" "TRIPLE=$TRIPLE" "OUTPUT=$OUTPUT" "PATH=$PATH" \
  "ROOTFS_SIZE=$ROOTFS_SIZE" \
  "BUILD_HOST_CC=$BUILD_HOST_CC" "BUILD_HOST_CC_FULL=$BUILD_HOST_CC_FULL" "BUILD_HOST_SYSROOT=$BUILD_HOST_SYSROOT" "BUILD_HOST_PREFIX=$BUILD_HOST_PREFIX" \
  "KERNEL_ARCH=$KERNEL_ARCH" "KERNEL_GENERIC_ARCH=$KERNEL_GENERIC_ARCH" "QEMU_ARCH=$QEMU_ARCH" "KERNEL_CONFIG=$KERNEL_CONFIG" \
  "BUILD_BUILD_CC=$BUILD_BUILD_CC" SHELL=/bin/sh "CONSOLE=$CONSOLE" \
  make "$@"
