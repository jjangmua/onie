#!/bin/sh

#  Copyright (C) 2014,2015 Curt Brune <curt@cumulusnetworks.com>
#  Copyright (C) 2015 david_yang <david_yang@accton.com>
#
#  SPDX-License-Identifier:     GPL-2.0

set -e

cd $(dirname $0)
. ./machine.conf

os_install_dev_target=/dev/mmcblk1
os_install_part_target=/dev/mmcblk1p1

installer_dir=$(pwd)

echo "Bone Installer: platform: $platform"

create_partition() {
	fdisk $os_install_dev_target <<EOF
o
n
p
1
1024

p
w
EOF
	mkfs.ext4 $os_install_part_target
}

install_uimage() {
	echo "Installing $platform rootfs"
	create_partition
	mkdir /tmpfs
	mount -t ext4 $os_install_part_target /tmpfs
	cd /tmpfs && xz -dc < $installer_dir/demo.initrd | cpio -idm && cd /
	sync
	umount /tmpfs
}

. ./platform.conf

install_uimage

echo "Updating U-Boot environment variables"
(cat <<EOF
nos_initargs setenv bootargs console=\$consoledev,\$baudrate root=$os_install_part_target rw rootfstype=ext4;
nos_bootcmd ext4load mmc 1:1 \$kernel_addr_r /boot/vmlinuz; ext4load mmc 1:1 \$fdt_addr_r /boot/dtb; run nos_initargs; bootz \$kernel_addr_r - \$fdt_addr_r;
EOF
) > /tmp/env.txt

fw_setenv -s /tmp/env.txt

cd /

# Set NOS mode if available.  For manufacturing diag installers, you
# probably want to skip this step so that the system remains in ONIE
# "installer" mode for installing a true NOS later.
if [ -x /bin/onie-nos-mode ] ; then
    /bin/onie-nos-mode -s
fi
