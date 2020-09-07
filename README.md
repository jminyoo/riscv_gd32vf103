                        RISCV Dev. Board How-to


                                     Jaemin Yoo (jmin.yoo@gmail.com)

-----------------------------------------------------------------------------

There are many RISC-V implementations but I just ordered a development
board from SeeedStudio. AP is from GigaDevice and it provides detailed
datasheet for programmers. So I choosed the board.

	https://www.gigadevice.com/products/microcontrollers/gd32/risc-v/

	GD32VF103VBT6 RISC-V MCU @108MHz
	128KB on-chip Flash + 8MB on-board Flash
	32K SRAM


32K SRAM seems too small but codes and read only data can be fetched
and executed from on-chip flash. 32K SRAM can be used for solely RW data,
stack and heap. So it seems enough for RTOS and baremetal firmwares.

You can buy the dev. board from seeedstudio.

    https://www.seeedstudio.com/SeeedStudio-GD32-RISC-V-kit-with-LCD-p-4303.html

You also need usb jtag to debug FW using openocd. So you'll need this.

    https://www.seeedstudio.com/Sipeed-USB-JTAG-TTL-RISC-V-Debugger-p-2910.html

You also need a usb UART for UART IO. IO voltage level is 3.3v, so get usb
UART that supports 3.3v.

You also need several jumper wires. So get some female-female jumpers for
JTAG and UART. Also male-female wires for configuring boot option.


[Development Environment Setup]

You'll need toolchain(gcc, gdb and bin tools). Also openocd for JTAG. And
dfu-util for downloading FW to the dev. board.

For the cross toolchain and utilities, you can just download from some open
source platforms such as platformio or eclipse cdt.

I used mint linux. But ubuntu should have no problem for installing the tools.

    sudo apt-get install python3 python3-pip
    pip3 install -U platformio

PlatformIO (https://platformio.org)is a open source project to supply whole
FW development environment easily. Visual Code is a main IDE and development
environments can be easily configured. But you don't know what is going on
under the hood of platformio and need to setup your own environment. Then
you can just install toolchain and other tools. Then configure build environment
by yourself.

    sudo apt-get install python3 python3-pip	<=== Install PIP
    pip3 install -U platformio					<=== install platformio
    platformio platform install gd32v			<=== install toolchain and tools

You will see toolchain and tools are installed under ~/.platformio

    ~/.platformio$ ls -la
    합계 36
    drwxrwxr-x  7 jmin jmin 4096  8월 30 20:19 .
    drwxr-xr-x 36 jmin jmin 4096  9월  6 15:49 ..
    drwxrwxr-x  6 jmin jmin 4096  8월 18 14:05 .cache
    -rw-rw-r--  1 jmin jmin  186  8월 30 20:19 appstate.json
    -rw-rw-r--  1 jmin jmin  192  8월 13 14:41 homestate.json
    drwxrwxr-x  2 jmin jmin 4096  8월 11 14:17 lib
    drwxrwxr-x 13 jmin jmin 4096  8월 25 14:57 packages		<=== toolchain and tools
    drwxr-xr-x  5 jmin jmin 4096  8월 12 19:45 penv
    drwxrwxr-x  3 jmin jmin 4096  8월 11 14:18 platforms


    ~/.platformio/packages$ ls -la
    합계 52
    drwxrwxr-x 13 jmin jmin 4096  8월 25 14:57 .
    drwxrwxr-x  7 jmin jmin 4096  8월 30 20:19 ..
    drwx------  4 jmin jmin 4096  8월 11 14:28 contrib-piohome
    drwx------ 50 jmin jmin 4096  8월 25 14:57 contrib-pysite
    drwx------  5 jmin jmin 4096  8월 13 14:37 framework-arduino-gd32v
    drwx------  5 jmin jmin 4096  8월 11 14:24 framework-gd32vf103-sdk
    drwx------  5 jmin jmin 4096  8월 13 14:44 tool-cppcheck
    drwx------  5 jmin jmin 4096  8월 12 13:43 tool-dfuutil
    drwx------  2 jmin jmin 4096  8월 12 13:43 tool-gd32vflash	<== FW download
    drwx------  5 jmin jmin 4096  8월 12 13:43 tool-openocd-gd32v	<== jtag debug
    drwx------  4 jmin jmin 4096  8월 11 14:14 tool-scons
    drwx------  2 jmin jmin 4096  8월 13 14:41 tool-unity
    drwx------  8 jmin jmin 4096  8월 11 14:20 toolchain-gd32v		<== toolchain


There are many directories. But you just need tool-gd32vflash, tool-openocd-gd32v
and toolchain-gd32v.

Eclispe CDT is also enables to fetch similar tools with ease. Please refer this.

    https://gnu-mcu-eclipse.github.io/plugins/download/


[Sample Code]

I pushed a sample code and its configuration at github. You can get it at

    https://github.com/jminyoo/riscv_gd32vf103


Clone it. Open and edit build.sh regarding PATH for toolchain. And simply
execute build.sh. It will generate firmware.bin It can be loaded to the board
through DFU.

I'll explain little bit about the DFU. You need to connect the board to host
pc by a usb-c type cable. DFU will be done through the usb cable. I don't know
the details. DFU seems hardcoded in  GD32V's rom.

[DFU]

Before downloading FW on the board. You need to boot the board for DFU.
If 'BOOT0' pin near usb port is connected to 3V3, the board boot for DFU.
You can simply move the jumper for it. Don't forget to return it for normal
booting after DFU's done.

If you succeed to boot the board for DFU, you should see 2 'Found DFU' lines
as below from dfu-util.


    $ dfu-util -l
    dfu-util 0.9

    Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
    Copyright 2010-2016 Tormod Volden and Stefan Schmidt
    This program is Free Software and has ABSOLUTELY NO WARRANTY
    Please report bugs to http://sourceforge.net/p/dfu-util/tickets/

    dfu-util: Cannot open DFU device 0a5c:21e1
    Found DFU: [28e9:0189] ver=1000, devnum=9, cfg=1, intf=0, path="1-1.2.1.1", alt=1, name="@Option Bytes  /0x1FFFF800/01*016 g", serial="??"
    Found DFU: [28e9:0189] ver=1000, devnum=9, cfg=1, intf=0, path="1-1.2.1.1", alt=0, name="@Internal Flash  /0x08000000/512*002Kg", serial="??"


Then, DFU can be executed by this command.

    sudo ~/.platformio/packages/tool-gd32vflash/dfu-util -a 0 -d 28e9:0189 -s 0x8000000 -D .\firmware.bin

    dfu-util 0.9

    Copyright 2005-2009 Weston Schmidt, Harald Welte and OpenMoko Inc.
    Copyright 2010-2016 Tormod Volden and Stefan Schmidt
    This program is Free Software and has ABSOLUTELY NO WARRANTY
    Please report bugs to http://sourceforge.net/p/dfu-util/tickets/

    dfu-util: Invalid DFU suffix signature
    dfu-util: A valid DFU suffix will be required in a future dfu-util release!!!
    Opening DFU capable USB device...
    ID 28e9:0189
    Run-time device DFU version 011a
    Claiming USB DFU Interface...
    Setting Alternate Setting #0 ...
    Determining device status: state = dfuERROR, status = 10
    dfuERROR, clearing status
    Determining device status: state = dfuIDLE, status = 0
    dfuIDLE, continuing
    DFU mode device DFU version 011a
    Device returned transfer size 2048
    GD32 flash memory access detected
    Device model: GD32VF103VB
    Memory segment (0x08000000 - 0801ffff)(rew)
    Erase size 1024, page count 128
    Downloading to address = 0x08000000, size = 6752
    Download	[=========================] 100%         6752 bytes
    Download done.
    File downloaded successfully


If you successfully DFU the firmware binary, you should see following.
Then return the BOOT0's jumper connect itself to GND and press reset.
You should see 'Hello'

don't forget to connect TX of the board to RX of host and RX to TX. Baud
rate is 115200. (8-1-none parity, no hw/sw flow control)


[JTAG Debug]

You'll need JTAG to dig into the board. You need to connect 6 pins of JTAG
on the board to USB-JTAG. 6 pins are  GND TDO NRST, TOK TMS TDI


store this to some file. ex) openocd.cfg

    adapter_khz     1000

    interface ftdi
    ftdi_vid_pid 0x0403 0x6010

    transport select jtag
    ftdi_layout_init 0x0008 0x001b
    ftdi_layout_signal nSRST -oe 0x0020 -data 0x0020

    set _CHIPNAME riscv
    jtag newtap $_CHIPNAME cpu -irlen 5 -expected-id 0x1e200a6d

    set _TARGETNAME $_CHIPNAME.cpu
    target create $_TARGETNAME riscv -chain-position $_TARGETNAME
    $_TARGETNAME configure -work-area-phys 0x20000000 -work-area-size 10000 -work-area-backup 1

    set _FLASHNAME $_CHIPNAME.flash
    flash bank $_FLASHNAME gd32vf103 0x08000000 0 0 0 $_TARGETNAME

    init

    halt

Then, execute openocd first 

    /home/jmin/.platformio/packages/tool-openocd-gd32v/bin/openocd -f openocd.cfg


    Open On-Chip Debugger 0.10.0+dev-00911-gcfbca74bd (2019-09-12-09:31)
    Licensed under GNU GPL v2
    For bug reports, read
	    http://openocd.org/doc/doxygen/bugs.html
    Info : clock speed 1000 kHz
    Info : JTAG tap: riscv.cpu tap/device found: 0x1000563d (mfg: 0x31e (Andes Technology Corporation), part: 0x0005, ver: 0x1)
    Warn : JTAG tap: riscv.cpu       UNEXPECTED: 0x1000563d (mfg: 0x31e (Andes Technology Corporation), part: 0x0005, ver: 0x1)
    Error: JTAG tap: riscv.cpu  expected 1 of 1: 0x1e200a6d (mfg: 0x536 (Nuclei System Technology Co.,Ltd.), part: 0xe200, ver: 0x1)
    Info : JTAG tap: auto0.tap tap/device found: 0x790007a3 (mfg: 0x3d1 (GigaDevice Semiconductor (Beijing)), part: 0x9000, ver: 0x7)
    Error: Trying to use configured scan chain anyway...
    Warn : AUTO auto0.tap - use "jtag newtap auto0 tap -irlen 5 -expected-id 0x790007a3"
    Warn : Bypassing JTAG setup events due to errors
    Info : datacount=4 progbufsize=2
    Info : Examined RISC-V core; found 1 harts
    Info :  hart 0: XLEN=32, misa=0x40901105
    Info : Listening on port 3333 for gdb connections
    Info : Listening on port 6666 for tcl connections
    Info : Listening on port 4444 for telnet connections


Then, execute gdb with the elf file you just built by build.sh

    /home/jmin/.platformio/packages/toolchain-gd32v/bin/riscv-nuclei-elf-gdb firmware.elf
    GNU gdb (GDB) 8.3.0.20190516-git
    Copyright (C) 2019 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.
    Type "show copying" and "show warranty" for details.
    This GDB was configured as "--host=x86_64-pc-linux-gnu --target=riscv-nuclei-elf".
    Type "show configuration" for configuration details.
    For bug reporting instructions, please see:
    <http://www.gnu.org/software/gdb/bugs/>.
    Find the GDB manual and other documentation resources online at:
        <http://www.gnu.org/software/gdb/documentation/>.

    For help, type "help".
    Type "apropos word" to search for commands related to "word"...
    Reading symbols from /home/jmin/work/tinybasic/firmware.elf...
    (gdb) target extended-remote:3333    <==== type this to connect to board through openocd.
    Remote debugging using :3333
    Info : accepting 'gdb' connection on tcp/3333
    Info : device id = 0x19060410
    Info : flash_size_in_kb = 0x00000080
    Info : flash size = 128kbytes
    main () at ./app/src/main.c:68
    68	    }
    (gdb) l main            <=== now you can debug using GDB
    44	    \param[in]  none
    45	    \param[out] none
    46	    \retval     none
    47	*/
    48	int main(void)
    49	{
    50	    gd_eval_com_init(EVAL_COM0);
    51	
    52	    usart_data_transmit(USART0, (uint32_t)'h');
    53	    while (usart_flag_get(USART0, USART_FLAG_TBE) == RESET) {}


For GDB, un-intrusive attach seems not possible aka 'no-stop'. Anyway you can use GDB now.
