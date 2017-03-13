#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting ELF File: /afs/ualberta.ca/home/l/i/liangmah/ECE492/capstone/DrumAnywhere_1_0/software/capstone/capstone.elf to: "../flash/capstone_generic_tristate_controller_0.flash"
#
elf2flash --input="/afs/ualberta.ca/home/l/i/liangmah/ECE492/capstone/DrumAnywhere_1_0/software/capstone/capstone.elf" --output="../flash/capstone_generic_tristate_controller_0.flash" --boot="$SOPC_KIT_NIOS2/components/altera_nios2/boot_loader_cfi.srec" --base=0x0 --end=0x400000 --reset=0x0 

#
# Programming File: "../flash/capstone_generic_tristate_controller_0.flash" To Device: generic_tristate_controller_0
#
nios2-flash-programmer "../flash/capstone_generic_tristate_controller_0.flash" --base=0x0 --sidp=0x11090B8 --id=0x0 --timestamp=1489183579 --device=1 --instance=0 '--cable=USB-Blaster on localhost [2-1.6]' --program 

