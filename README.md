
# lh-bootstrap: building a disk image with Linux, musl, and skarnet.org tools from scratch

Laurent Bercot
last modified: 2017-05-22


## License

`lh-bootstrap` is distributed under the terms of the
[GNU General Public License version 2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html).


## Goal

`lh-bootstrap` builds a disk image for use with qemu or other VM emulators -
and the files can also be copied to real hardware.

 The image contains a Linux kernel and a collection of small user-space
tools such as [busybox](http://busybox.net/), [dropbear](https://matt.ucc.asn.au/dropbear/dropbear.html)
and the [skarnet.org tools](http://skarnet.org/software/), all statically
linked against the [musl libc](http://musl-libc.org/). It includes
the minimal amount of necessary software and client configuration to get
a machine up, running (with [s6](http://skarnet.org/software/s6) as
process 1 and [s6-rc](http://skarnet.org/software/s6-rc) as service
manager) and connected to the Internet.

 The image is built from scratch: every package is compiled from source.
The toolchains and the minimal initial development environment for the
BUILD machine, however, are not provided. See below.


### Explicitly Not A Goal

`lh-bootstrap` **is not**:

- A distribution. It will not include any more software than is
strictly necessary to get a minimal usable image up and running.
Future versions of lh-bootstrap may include a "development" flavour,
which would also include a basic C/Unix development environment on
the image, but that's as far as it will go.

- Turnkey, polished, for end users. Lots of work have been put
into it so most build machines can run it out of the box, but the tasks
here are complex and involve lots of different packages from different
sources, which all evolve rapidly - so bitrot is to be expected, and
users should not be afraid to go tweak Makefiles to set the correct
versions of the packages.

- Lightweight. Unlike other skarnet.org tools, `lh-bootstrap` is a
heavy development package that needs significant resources to run.


## Terminology

You have installed this package on the BUILD machine.
You are making an image that will work on a TARGET machine.
The supported TARGETs include x86_64, i486, armv7, armv8 (aarch64).

The TARGET machine can also be referred to as the HOST machine.
This is GNU terminology: when you configure a package with a GNU
configure script, the --build option tells what machine you're
building the software on, and the --host option tells what machine
the software is going to run on.

We will use HOST or TARGET indiscriminately. There is one case
where HOST and TARGET are not synonyms: when building a toolchain.
(In that case, HOST refers to the machine that the toolchain
being built will run on, and TARGET refers to the machine that
the toolchain will produce binaries for.)
Since we are not building a toolchain, HOST and TARGET are entirely
synonymous to us.

 HOST is generally a confusing term, because it is often
used to designate the native, real computer, a "host" as opposed
to a "guest" running in a virtual machine. But here, "host" is
not opposed to "guest", it's opposed to "build", and your native,
real computer is "build".


## Requirements

### Be root

You must be root on your BUILD machine. The build scripts will not
work properly if you are not root, *even if they do not write error
messages!*
Don't worry, most of the work is performed as a non-root user; but
root privileges are still needed for a few operations, so it is
necessary that you start the build script as root.

(It is still better to be root and lose privileges for the operations
that do not require them than to not be root and have to gain
privileges for some operations via sudo or other mechanisms.
Under Unix, it is best to avoid privilege gain whenever you can.)


### Build requirements

For the build to work, you need:

- A GNU or other Linux-based OS. Unfortunately, some Linux-specific
operations need to be performed on the BUILD machine (loopback
mounting, among others).

- A powerful BUILD machine. skarnet.org tools are small and efficient,
but building a complete system image from scratch requires significant
computing power.

- A native development environment for the BUILD machine. This means
a gcc toolchain running on your BUILD machine and producing code intended
to run on your BUILD machine. You should have this on any distribution,
and your compiler should just be called `gcc`. If you do not have this,
you can get a native toolchain [here](http://skarnet.org/toolchains/).

- An unrestricted Internet connection on the BUILD machine.

- The ability to loop-mount filesystems on the BUILD machine.

- A few necessary tools for the BUILD machine:
  + GNU `make`, version 3.81 or later
  + `bc`, Perl 5 (necessary for the Linux kernel compilation as well as syslinux)
  + `su`, `patch`, `sed`
  + `git`
  + a `tar` that supports .gz, .bz2 and .xz archives
  + a `wget` that supports HTTPS
  + `dd`, `chown`, `cpio`
  + `mkfs.ext4`, from e2fsprogs
  + `qemu-system-$TARGET` to boot your target machine

- A musl cross-development environment from the BUILD machine to the TARGET
machine. This means a gcc toolchain running on your BUILD machine and
producing code intended to run on your TARGET machine, linking the TARGET
binaries against the musl libc.
Even if you are building for the same TARGET as your BUILD machine
(example: you are building for x86_64 on an x86_64), **you cannot use
your stock distribution's native compiler for this!** Pick one of the
cross toolchains available [here](http://skarnet.org/toolchains/).

- A native musl development environment for the TARGET machine. This means a
gcc toolchain running on your TARGET machine and producing code intended
to run on your TARGET machine, linking the TARGET binaries against the musl
libc. Pick one of the native toolchains available
[here](http://skarnet.org/toolchains/).


## Usage

### Configuring

Copy the `lh-config.dist` file to `lh-config`. This file is your own configuration
and should NOT be checked into git.
Edit the `lh-config` file to configure the system to be built.

It is important that the NORMALUSER variable be set to an existing
non-root user on your BUILD system. If you don't have one, use `nobody`.

You can set the OUTPUT variable to the name of the directory the
system will be built in. There must be *a lot* of available disk
space for the output, because that's where all the builds will
take place. By default, OUTPUT is `./output`, which
means the system will be built right where you are.

TRIPLE is the triplet representing your target.
It should be `x86_64-linux-musl` for x86_64,
`arm-linux-musleabihf` for ARM,
`aarch64-linux-musl` for arm64,
`i486-linux-musl` for i486, etc.
Only triplets that appear in the `sysdeps` subdirectory are supported.

CROSS_BASE is the path where your cross-toolchain is installed.
This means the toolchain from your BUILD to your TARGET, even if
BUILD and TARGET are the same.

HOST_HOST_BASE is the path where your native toolchain for the TARGET
is installed.

COUNTRY_CODE, LOCAL_IP and ROUTER_IP are configuration variables
for your TARGET. COUNTRY_CODE is one of `uk`, `fr`, `rs`, `vn` or `cn`.
LOCAL_IP is the IP your guest will have; ROUTER_IP is the router
address your guest will use. (On Linux, you can get your router
(gateway) ip via `route -n`.) They should be on the same class C
network.

USE_DHCP should be true if you want your image to get its IP address
via a DHCP client (in which case LOCAL_IP and ROUTER_IP will be
ignored). It should be false if you want your image to have the
LOCAL_IP static IPv4 address.

ROOTFS_SIZE, SWAP_SIZE, RWFS_SIZE, USERFS_SIZE and EXTRA_SIZE are
the size of the partitions that will be created, in megabytes.
They are big by default, so the virtual disk can be used to build
any distribution. The disk files are sparse, so it doesn't matter
that they're big - but you should modify the environment variables
if you want a smaller image.



### Building

You must be root to invoke `./make`. Most build commands will still
run unprivileged, as the user you specified in the NORMALUSER variable
in `lh-config`, but root privileges are needed for some steps in the
creation of the image: loopback mounting, for instance.

If you need a clean build, type `./make clean`. The output directory
will be erased, except for the downloaded sources. If you need to
also erase the downloaded sources, type `./make distclean`.

To start the build, type `./make`.
Not just `make`, but `./make`, i.e. the provided script. This script
sets a few important environment variables before calling the real
`make` with all its command line. You can give `./make` all the
options and arguments you would give `make`, for instance `-j6`.

The filesystems will be built under the `./output` directory, or
whatever directory you specified in the OUTPUT variable in `lh-config`.

Under this directory, once the build has completed:
- `rootfs`, `rwfs` and `userfs` are the contents of the
respective filesystems of the target. You can use those to make tarballs,
for instance.
- `kernel` is the kernel binary, to be given to qemu.
- `disk-image.raw` is the complete raw disk image, suitable for qemu or to be
burned onto a real disk or SD card. By default it is huge, but it's a
sparse file, i.e. it's not really using all that space, only the parts
that have actually been written to (which is a small portion of the total
space).
- Previous versions of `lh-bootstrap` built an initramfs. This has
been removed.


### Running on backends

To launch qemu on an image you just created, run `./make qemu-boot`.
This will start a qemu process running the image you just created.
You can look at the ./qemu-boot script to see exactly what it does.

You can also "./make vmware-image" or "./make virtualbox-image" to create
a "disk-image.vmdk" file, which will be suitable as a main disk image
for VMWare or Virtualbox. Running those emulators, however, is out of
scope for this document.

