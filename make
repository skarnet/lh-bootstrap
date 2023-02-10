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


WD=`pwd`
OUTPUT=${OUTPUT:-$WD/output}
if test $OUTPUT = ${OUTPUT#/} ; then
  OUTPUT="$WD/$OUTPUT"
fi

BUILD_CC=${BUILD_CC:-gcc}
TARGET_CC="$TRIPLE-${CROSS_CC:-gcc}"
ROOTFS_SIZE=${ROOTFS_SIZE:-1024M}
RWFS_SIZE=${RWFS_SIZE:-512M}
USERFS_SIZE=${USERFS_SIZE:-512M}
LH_DEV=${DEVELOPMENT:-false}
LIBGUESTFS_PATH=${LIBGUESTFS_PATH:-/usr/lib/guestfs}

build=`${BUILD_CC} -dumpmachine`
if echo "$build" | grep -q -- '-.*-.*-' ; then
  BUILD_QUADRUPLE="$build"
else
  BUILD_QUADRUPLE="${build%%-*}-none-${build#*-}"
fi

if test -z "$TARGET_STATIC" ; then
  case "$TRIPLE" in
    *-*-musl*) TARGET_STATIC=true ;;
    *) TARGET_STATIC=false ;;
  esac
fi

if test -z "$LIBC_COPY" ; then
  case "$TARGET_STATIC" in
    true) LIBC_COPY=false ;;
    *) LIBC_COPY=true ;;
  esac
fi

if test -n "$CROSS_BASE" ; then
  crossenv=""
else
  crossenv="LH_MAKE_CROSS=1"
  CROSS_BASE="$OUTPUT/build-$TRIPLE/$TRIPLE"
fi

TARGET_CC_FULL="$CROSS_BASE/bin/$TARGET_CC"
TARGET_SYSROOT="$CROSS_BASE/$TRIPLE"
TARGET_PREFIX="$CROSS_BASE/bin/$TRIPLE"
LIBC_SYSROOT=${LIBC_SYSROOT:-$(${TARGET_CC_FULL} -print-sysroot)}

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
PATH="$WD/bin:$OUTPUT/build-build/command:$OUTPUT/build-build/bin:$OUTPUT/build-$TRIPLE/bin:$CROSS_BASE/bin:$PATH"

umask 022
exec env -i $crossenv LH_MAKE_MARKER=1 "WD=$WD" "NORMALUSER=$NORMALUSER" "TRIPLE=$TRIPLE" "OUTPUT=$OUTPUT" "PATH=$PATH" \
  "ROOTFS_SIZE=$ROOTFS_SIZE" "RWFS_SIZE=$RWFS_SIZE" "USERFS_SIZE=$USERFS_SIZE" \
  "TARGET_STATIC=$TARGET_STATIC" "LIBC_SYSROOT=$LIBC_SYSROOT" "LIBC_COPY=$LIBC_COPY" "LH_DEV=$LH_DEV" \
  "TARGET_CC=$TARGET_CC" "TARGET_CC_FULL=$TARGET_CC_FULL" "TARGET_SYSROOT=$TARGET_SYSROOT" "TARGET_PREFIX=$TARGET_PREFIX" \
  "KERNEL_ARCH=$KERNEL_ARCH" "KERNEL_GENERIC_ARCH=$KERNEL_GENERIC_ARCH" "QEMU_ARCH=$QEMU_ARCH" "KERNEL_CONFIG=$KERNEL_CONFIG" \
  "BUILD_QUADRUPLE=$BUILD_QUADRUPLE" "BUILD_CC=$BUILD_CC" SHELL=/bin/sh "CONSOLE=$CONSOLE" "TERM=$TERM" \
  "LIBGUESTFS_PATH=$LIBGUESTFS_PATH" \
  make --jobserver-style=pipe "$@"
