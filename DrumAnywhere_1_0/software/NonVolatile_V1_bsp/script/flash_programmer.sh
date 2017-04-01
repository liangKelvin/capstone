#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting ELF File: /afs/ualberta.ca/home/l/i/liangmah/ECE492/capstone/DrumAnywhere_1_0/software/capstone_NonVolatile/capstone_NonVolatile.elf to: "../flash/capstone_NonVolatile_generic_tristate_controller_0.flash"
#
elf2flash --input="/afs/ualberta.ca/home/l/i/liangmah/ECE492/capstone/DrumAnywhere_1_0/software/capstone_NonVolatile/capstone_NonVolatile.elf" --output="../flash/capstone_NonVolatile_generic_tristate_controller_0.flash" --boot="$SOPC_KIT_NIOS2/components/altera_nios2/boot_loader_cfi.srec" --base=0x1400000 --end=0x1800000 --reset=0x1400000 

#
# Programming File: "../flash/capstone_NonVolatile_generic_tristate_controller_0.flash" To Device: generic_tristate_controller_0
#
nios2-flash-programmer "../flash/capstone_NonVolatile_generic_tristate_controller_0.flash" --base=0x1400000 --sidp=0x19090C8 --id=0x0 --timestamp=1490989383 --device=1 --instance=0 '--cable=USB-Blaster on localhost [2-1.6]' --program 

