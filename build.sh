#!/bin/bash

PATH=$PATH:/home/jmin/.platformio/packages/toolchain-gd32v/bin

if [[ $1 == "clean" ]]; then
	rm -f bld/*.o
	rm -f *.a
	rm -f firmware*
	echo "CLEAN DONE"
	exit 0
fi

riscv-nuclei-elf-gcc -c -std=gnu11 -Wall -march=rv32imac -mabi=ilp32 -mcmodel=medlow -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -Og -g2 -ggdb2 -DPLATFORMIO=40304 -DUSE_STDPERIPH_DRIVER -DHXTAL_VALUE=8000000U -D__PLATFORMIO_BUILD_DEBUG__ -Iinclude -Isrc -I./bsp/GD32VF103_standard_peripheral -I./bsp/GD32VF103_standard_peripheral/Include -I./bsp/GD32VF103_usbfs_driver -I./bsp/GD32VF103_usbfs_driver/Include -I./bsp/RISCV/drivers -I./bsp/RISCV/env_Eclipse -I./bsp/RISCV/stubs -I./app/src -I./app/include ./app/src/gd32v103v_eval.c ./app/src/main.c ./app/src/systick.c

riscv-nuclei-elf-gcc -c -std=gnu11 -Wall -march=rv32imac -mabi=ilp32 -mcmodel=medlow -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -Og -g2 -ggdb2 -DPLATFORMIO=40304 -DUSE_STDPERIPH_DRIVER -DHXTAL_VALUE=8000000U -D__PLATFORMIO_BUILD_DEBUG__ -I./bsp/GD32VF103_standard_peripheral -I./bsp/GD32VF103_standard_peripheral/Include -I./bsp/GD32VF103_usbfs_driver -I./bsp/GD32VF103_usbfs_driver/Include -I./bsp/RISCV/drivers -I./bsp/RISCV/env_Eclipse -I./bsp/RISCV/stubs ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_adc.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_bkp.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_can.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_crc.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_dac.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_dbg.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_dma.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_eclic.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_exmc.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_exti.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_fmc.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_fwdgt.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_gpio.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_i2c.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_pmu.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_rcu.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_rtc.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_spi.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_timer.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_usart.c ./bsp/GD32VF103_standard_peripheral/Source/gd32vf103_wwdgt.c ./bsp/GD32VF103_standard_peripheral/system_gd32vf103.c

riscv-nuclei-elf-gcc -x assembler-with-cpp -Wall -march=rv32imac -mabi=ilp32 -mcmodel=medlow -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -Og -g2 -ggdb2 -DPLATFORMIO=40304 -DUSE_STDPERIPH_DRIVER -DHXTAL_VALUE=8000000U -D__PLATFORMIO_BUILD_DEBUG__ -I./bsp/GD32VF103_standard_peripheral -I./bsp/GD32VF103_standard_peripheral/Include -I./bsp/GD32VF103_usbfs_driver -I./bsp/GD32VF103_usbfs_driver/Include -I./bsp/RISCV/drivers -I./bsp/RISCV/env_Eclipse -I./bsp/RISCV/stubs -c ./bsp/RISCV/env_Eclipse/entry.S ./bsp/RISCV/env_Eclipse/start.S

riscv-nuclei-elf-gcc -c -std=gnu11 -Wall -march=rv32imac -mabi=ilp32 -mcmodel=medlow -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -fno-common -Og -g2 -ggdb2 -DPLATFORMIO=40304 -DUSE_STDPERIPH_DRIVER -DHXTAL_VALUE=8000000U -D__PLATFORMIO_BUILD_DEBUG__ -I./bsp/GD32VF103_standard_peripheral -I./bsp/GD32VF103_standard_peripheral/Include -I./bsp/GD32VF103_usbfs_driver -I./bsp/GD32VF103_usbfs_driver/Include -I./bsp/RISCV/drivers -I./bsp/RISCV/env_Eclipse -I./bsp/RISCV/stubs ./bsp//RISCV/drivers/n200_func.c ./bsp//RISCV/env_Eclipse/handlers.c ./bsp//RISCV/env_Eclipse/init.c ./bsp//RISCV/env_Eclipse/your_printf.c ./bsp//RISCV/stubs/_exit.c ./bsp//RISCV/stubs/close.c ./bsp//RISCV/stubs/fstat.c ./bsp//RISCV/stubs/isatty.c ./bsp//RISCV/stubs/lseek.c ./bsp//RISCV/stubs/read.c ./bsp//RISCV/stubs/sbrk.c ./bsp//RISCV/stubs/write.c ./bsp//RISCV/stubs/write_hex.c

#Build library for riscv
riscv-nuclei-elf-gcc-ar rc libriscv.a n200_func.o entry.o handlers.o init.o start.o your_printf.o _exit.o close.o fstat.o isatty.o lseek.o read.o sbrk.o write.o write_hex.o

riscv-nuclei-elf-gcc-ranlib libriscv.a

riscv-nuclei-elf-gcc-ar rc libstandard_peripheral.a gd32vf103_adc.o gd32vf103_bkp.o gd32vf103_can.o gd32vf103_crc.o gd32vf103_dac.o gd32vf103_dbg.o gd32vf103_dma.o gd32vf103_eclic.o gd32vf103_exmc.o gd32vf103_exti.o gd32vf103_fmc.o gd32vf103_fwdgt.o gd32vf103_gpio.o gd32vf103_i2c.o gd32vf103_pmu.o gd32vf103_rcu.o gd32vf103_rtc.o gd32vf103_spi.o gd32vf103_timer.o gd32vf103_usart.o gd32vf103_wwdgt.o system_gd32vf103.o

riscv-nuclei-elf-gcc-ranlib libstandard_peripheral.a

#build main fw
riscv-nuclei-elf-gcc -o firmware.elf -T ./bsp/RISCV/env_Eclipse/GD32VF103xB.lds -march=rv32imac -mabi=ilp32 -mcmodel=medlow -nostartfiles -Xlinker --gc-sections --specs=nano.specs -Og -g2 -ggdb2 gd32v103v_eval.o main.o systick.o -L. -Wl,--start-group libstandard_peripheral.a libriscv.a -lc -lc -Wl,--end-group

riscv-nuclei-elf-objcopy -O ihex firmware.elf firmware.hex

riscv-nuclei-elf-objcopy -O binary firmware.elf firmware.bin

mv -f *.o ./bld

echo "======================================="
echo "              Build Done"
echo "======================================="

