#Makefile fragment for NXP LS1043ARDB

# Copyright 2017 NXP Semiconductor, Inc.
#
# SPDX-License-Identifier:     GPL-2.0

ONIE_ARCH ?= armv7a
SWITCH_ASIC_VENDOR = none

VENDOR_REV ?= ONIE

# Translate hardware revision to ONIE hardware revision
ifeq ($(VENDOR_REV),ONIE)
  MACHINE_REV = 0
else
  $(warning Unknown VENDOR_REV '$(VENDOR_REV)' for MACHINE '$(MACHINE)')
  $(error Unknown VENDOR_REV)
endif

#UBOOT_MACHINE = ls1043ardb_ONIE_$(MACHINE_REV)
#KERNEL_DTB = freescale/fsl-ls1043a-rdb.dtb
#KERNEL_DTB_PATH = dts/$(KERNEL_DTB)

#FDT_LOAD_ADDRESS = 0x90000000


#enable u-boot dtb
#UBOOT_DTB_ENABLE = yes

# Set the desired U-Boot version
UBOOT_VERSION = 2018.03
UBOOT_MACHINE = am335x_boneblack

KERNEL_LOAD_ADDRESS = 0x820000d8
KERNEL_ENTRY_POINT = 0x820000d8

KERNEL_DTB    = am335x-boneblack.dtb
KERNEL_DTB_PATH = dts/$(KERNEL_DTB)

# Specify Linux kernel version -- comment out to use the default
LINUX_VERSION = 4.9
LINUX_MINOR_VERSION = 95

#---------------------------------------------------------
#
# Local Variables:
# mode: makefile-gmake
# End:
