
# lh-bootstrap: software built for the BUILD machine

Laurent Bercot
2016-03-31


This file documents the software installed and run on the BUILD
machine prior to building the HOST image.

Please read the INTERNALS.md file first, for the general organization
of the build, and basic definitions.


## BUILD tools

### Linux kernel headers

Makefile directory: sub/kernel

The Linux kernel is downloaded and will be configured and compiled
to boot a qemu image for the HOST. Since it will be downloaded
anyway, we reuse the source to process and install the kernel headers
for the BUILD.
Those kernel headers, coupled with the musl libc's headers, are
necessary to compile Linux-specific software such as util-linux and skarnet-org.


### musl libc

Makefile directory: sub/musl

 We have no control over the BUILD's native compiler and libc. Most
likely, it's gcc and produces binaries that are dynamically linked
against the glibc - but we're not certain; we would like certainty,
even for the build tools. We do not want our tools' behaviour to
depend on external factors such as a misconfigured libc or dynamic
linker.

 So, we download the musl libc (which we would download for use in
the HOST anyway) and compile it for the BUILD. We then link all our
BUILD tools against it.


### skarnet.org packages

Makefile directory: sub/skarnet.org

 The HOST uses s6-rc as its service manager. We provide a template
for the database in source format in `layout/rootfs/etc/s6-rc/source-base`;
this template is preprocessed and added to the rootfs at layout
installation time, at the beginning of the HOST build.
 However, in order to boot, the HOST needs the database in compiled
form, not in source form: so we must run s6-rc-compile before the HOST
boots. Since the source and compiled formats are platform-independent,
we just run s6-rc-compile on the BUILD. Which means we need to compile
s6-rc for the BUILD, with the same settings that the HOST is using.
So we end up compiling most of the skarnet.org stack.

 Since we have to compile skalibs anyway, which is by far the heaviest
component of the stack, we also use the opportunity to compile
s6-portable-utils for the BUILD: the time spent compiling this package
is negligible once skalibs is built, and it contains
alternative tools that we use subsequently in the build, because their
behaviour is more predictible than the tools provided by the BUILD's
distribution.

 Note: since we need to mirror the HOST's layout for s6-rc-compile
to work properly, we compile the skarnet.org stack following the
slashpackage convention, with --enable-slashpackage. However, we
obviously don't install a slashpackage hierarchy on the BUILD's root
filesystem, we use the $(OUTPUT)/build-build staging directory.
The consequence is that skarnet.org binaries that exec other binaries
via slashpackage paths will not work. This is ok for our use since
the main tool we need is s6-rc-compile, which does not exec anything
else, but it's something to keep in mind. It's the reason why we do
not use s6-setuidgid even after building s6: we stick to the hackish
and inefficient bin/setuidgid script to drop privileges, because our
temporary installation of s6-setuidgid simply does not work.


#### skalibs

 The library which all other skarnet.org packages depend on.


#### execline

 The scripting language used by s6 and s6-rc.


#### s6

 The supervision suite used by s6-rc.


#### s6-rc

 The service manager used by the HOST. We compile it for the BUILD in
order to use s6-rc-compile to compile the service database before
booting the HOST.


#### s6-portable-utils

 Some utilities are akin to POSIX tools, but will have reproducible behavior
no matter what distribution is used. We have had trouble with
differences across BUILD distributions, with some distributions
slightly deviating from the standard (looking at you, Ubuntu); using
our own tools is insurance against that.


### xz-utils

Makefile directory: sub/xz

 xz-utils includes another compression library (liblzma), which
is also a dependency of kmod - actually, this is the one that
interests us. So we have to build the xz-utils package for
BUILD.


### kmod

Makefile directory: sub/kmod

 Ah, kmod.

 We build the Linux kernel for HOST with module support, for
practicality. Modules are compressed, to save storage space.
Traditionally, there are compressed with gzip (and have extension
`.ko.gz`), but xz is generally a better compressor than gzip:
the compressed data is smaller.
So we use xz to compress the modules (extension `.ko.xz`). On the
HOST, we load the modules with busybox modprobe, which supports
both extensions. So far, so good.

 Except that xz support for kmod is relatively recent, and some
distributions insist on providing an ancient version of kmod,
which *does not* allows modules to be compressed with xz.
(And the kernel's build system does not report the error - the
modules silently fail to be installed, which makes diagnostic
fun!)

 So, we have to provide our own version of kmod.

 I have to say that kmod is the single worst package that appears
in this whole build. The software itself works, but the
build system is *extremely* buggy and requires several workarounds,
that have all been implemented in the Makefile. Please do not
attempt to "simplify" this Makefile by using "correct" configure
options and eliminating make variables: that will not work.

