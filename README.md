# ONIE for Beaglebone

## eMMC Memory Layout

| LOCATION                 | BLOCK           | SIZE.B   | DESCRIPTION                    |
| ------------------------ | --------------- | -------- | ------------------------------ |
| 0x00000000 - 0x0000FE00  | 0x0000 - 0x007F | 65024    | MBR or GPT table               |
| 0x00010000 - 0x0001FE00  | 0x0080 - 0x00FF | 65024    | FDT                            |
| 0x00020000 - 0x0003FE00  | 0x0100 - 0x01FF | 130560   | SPL.backup1 (first copy used)  |
| 0x00040000 - 0x0005FE00  | 0x0200 - 0x02FF | 130560   | SPL.backup2 (second copy used) |
| 0x00060000 - 0x000DFE00  | 0x0300 - 0x06FF | 519936   | U-Boot                         |
| 0x000e0000 - 0x0011FE00  | 0x0700 - 0x08FF | 261632   | U-Boot Env                     |
| 0x00120000 - 0x01F20000  | 0x0900 - 0xF900 | 31457280 | ONIE                           |

## Build Instruction
```
$ git clone https://github.com/jjangmua/onie.git
$ git checkout ti_bone-r0
$ cd onie/build-config/
$ make MACHINEROOT=../machine/ti MACHINE=ti_bone all
```
Once the compile has been finished you will be found the output file on onie/build/images/ directory
* ti_bone-r0.MLO
* ti_bone-r0.boot.img
* ti_bone-r0.dtb
* ti_bone-r0.itb

## Installation
### Bootloader(SPL, U-boot)
```
=> mmc dev 1
=> tftp $loadaddr ti_bone-r0.MLO
=> mmc write $loadaddr 100 100
=> mmc write $loadaddr 200 100

=> tftp $loadaddr ti_bone-r0.boot.img
=> mmc write $loadaddr 300 400
```
### ONIE
```
=> mmc dev 1
=> tftp $loadaddr ti_bone-r0.itb
=> mmc write $loadaddr 900 f000
```

After the installation has been completed, you can run "run onie_rescue" in the uboot to bootup to the ONIE
