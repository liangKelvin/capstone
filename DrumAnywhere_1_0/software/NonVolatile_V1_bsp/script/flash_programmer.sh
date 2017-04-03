#!/bin/sh
#
# This file was automatically generated.
#
# It can be overwritten by nios2-flash-programmer-generate or nios2-flash-programmer-gui.
#

#
# Converting ELF File: /afs/ualberta.ca/home/l/i/liangmah/ECE492/capstone/DrumAnywhere_1_0/software/NonVolatile_V1/NonVolatile_V1.elf to: "../flash/NonVolatile_V1_generic_tristate_controller_0.flash"
#
elf2flash --input="/afs/ualberta.ca/home/l/i/liangmah/ECE492/capstone/DrumAnywhere_1_0/software/NonVolatile_V1/NonVolatile_V1.elf" --output="../flash/NonVolatile_V1_generic_tristate_controller_0.flash" --boot="$SOPC_KIT_NIOS2/components/altera_nios2/boot_loader_cfi.srec" --base=0x1400000 --end=0x1800000 --reset=0x1400000 

#
# Programming File: "../flash/NonVolatile_V1_generic_tristate_controller_0.flash" To Device: generic_tristate_controller_0
#
nios2-flash-programmer "../flash/NonVolatile_V1_generic_tristate_controller_0.flash" --base=0x1400000 --sidp=0x1909118 --id=0x0 --accept-bad-sysid --device=1 --instance=0 '--cable=USB-Blaster on localhost [2-1.6]' --program 

