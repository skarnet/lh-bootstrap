README.md for sub/busybox
-------------------------

host-full-config and host-mdev-config are two different
configuration files for busybox, which is actually built
twice during the bootstrap:

- host-full-config is the "full" configuration for busybox, i.e.
it instructs the build process to build a busybox binary that
contains all the basic commands our host will need: coreutils,
modprobe, ifconfig, mdev, etc. That's the binary that will be
installed in /opt/busybox and linked in /bin.

- host-mdev-config is "mdev-only". It instructs the build process
to build a busybox binary that contains *only* the mdev command
and its dependencies. That one will be copied into the initramfs:
the initramfs uses "mdev" and "mdev -s" commands, this is necessary
for coldplugging devices at boot. We don't need busybox to provide
any other commands in the initramfs because all the rest is done by
skarnet.org binaries.
