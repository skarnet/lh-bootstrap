


# Internals of lh-bootstrap

Laurent Bercot
last modified: 2017-04-07

## Definitions

BUILD is the machine you're running this set of scripts on.
HOST is the machine you're building the image for.
TARGET has the same meaning as HOST. See the `README.md` file.


## General organization

### ./lh-config and ./make

All your configuration should happen in the `lh-config` file. It is a series
of variable assignments, in shell syntax.

`./make` is a shell script that reads `lh-config`, provides reasonable
defaults for variables not specified in `lh-config`, exports a set of
variables into the environment then executes into `make` with the exact
same command line that it was given. So you can use make options, specify
a make target, etc.


### Other files and directories

The main `Makefile` includes sub-Makefiles that are in the subdirectories
of the `sub` directory, roughly one per software package. Those subdirectories
also may contain various scripts and patches necessary to make the software
package compile and/or run properly.

The `bin` directory contains scripts that are used throughout the whole
build process. They have been designed for maximum portability, not efficiency.

The `sysdeps` directory contains "system dependencies" for the various HOSTs
that lh-bootstrap supports, i.e. a textual description of the
HOST architecture's capabilities and quirks, such as endianness, sizes of
certain types, etc. These descriptions are used when cross-compiling the
skarnet.org packages.

The `layout` directory contains the base layout for all the filesystems
that are used to build our image:

- *rootfs* is the basic one, the root filesystem. It will be mounted
read-only.
- *rwfs* is a read-write directory we use to store our configuration
and other read-write data for normal operation of the machine. It is
not accessible to "normal" users. For instance, `/var` is a part of
rwfs.
- *userfs* is a read-write directory that will be used to store user
data. For instance, `/home` is a part of userfs.
- *stagingfs* is unused for now. It will be used for safe firmware
updates.

 All the files under `layout` must be text or otherwise editable
files: there must be absolutely no binary files in it. Currently,
the timezone files (`/etc/zoneinfo`) are an exception to that rule;
at some point I will remove them and make a sub-package script to
install them.


## Dependencies and build order

`./make` first builds a set of tools for the BUILD. The goal is to make the
build work on as many BUILD machines as possible, with as few dependencies
as possible. For instance, parts of a recent `util-linux` package are
installed because the build needs the `-P` option to the `losetup` binary
and not all distributions ship a `util-linux` version with `losetup -P`.

Then `./make` builds the software for the HOST, installing it into the
`rootfs` subdirectory of the output.


### Topological list of the BUILD tools

- Linux kernel headers
- musl
- skarnet.org packages
- some binaries from util-linux
- xz-utils
- kmod


### Topological list of the HOST packages

 For now, the HOST packages are a mix of "production" bootstrap packages,
i.e. software that is needed to get a host up and running without
aiming for development on that host, and "development" bootstrap packages,
i.e. software that is needed to turn the host into a native development
platform (in order to build and install software that is difficult to
cross-compile). A better separation between those two sets of packages
is planned for future versions of lh-bootstrap.

- Linux kernel
- musl
- bearssl
- skarnet.org packages
- busybox
- dnscache (from djbdns)
- dropbear
- a native host toolchain (for now just copied from a location)
