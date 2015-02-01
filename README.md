STM32L1-Discovery arm-none-eabi- toolchain template for asm
=====

This is a template for using the STM32L1-Discovery with the GNU ARM toolchain.
This template assumes you are writing just assembly code.  You can either build
it yourself or use a pre-compiled version from somewhere such as
[launchpad.net](https://launchpad.net/gcc-arm-embedded/+download)

This template is based around the first lab released for COMS20001.

## Code structure
A top level makefile is used to configure CC in such a way to produce
executables (`.bin` and `.hex`) from assembly files (`.s`). There are two other
makefiles that your makefile should inherit from which specify which programmer
you are using, either the `stlink` programmer of `openocd`. Both can be used for
programming and debugging, use which ever is easiest to install.

## Notes

Note: You'll now have to use GNU ASM directives rather than the ones shown in
the original coursework. I've converted all of the ones in the current template
for now but if you need to change later coursework directives they're all pretty
similar and a bit of googling will give you the correct one to use.

If you'd like to use this code outside of the COMS20001 course you can simply
change the jump instruction in `System_Init.s` to something other than
`Lab_Start` in `Init_End:`

You can further modularise this by removing the jump from `System_Init.s` and
uncommenting the application jump in `startup_stm32l1xx_md.s` to jump to your
own application's code.

This template modifies various pieces of other templates:

* `ld/stm32.ld`
* `startup_stm32l1xx_md.s`

and rewrites the provided `System_Init.s` and `Lab1-Task1.s` provided by Simon
to use GNU ASM directives.

## Compile your code
To simply compile your code first make sure all your source files are referenced
in the Makefile SRCS variable. 

You can then just run `make program` to compile your code into both a ELF binary
(can be loaded into gdb) and a bin (for writing straight to flash memory).

an example program is given in the `example` folder


## Flash your code 
This project uses either the `stlink` or `openocd` project to interface with
microcontroller

### stlink
Your makefile should inherit from `STM32-asm-stlink.rules`
You can install the `stlink` project at
[https://github.com/texane/stlink](https://github.com/texane/stlink) or if
you're using OS X `brew` has the package available.

Use `make flash` to compile the sources specified in the Makefile and write them
to device's flash memory. 

If you'd like to understand the Makefile, there's an excellent refcard [Make
refcard][]

### OpenOCD
Your makefile should inherit from `STM32-asm-openocd.rules`

## Debugging
The Makefile provides a target to use the `arm-none-eabi-gdb` for remote
debugging.

You can run this using `make debug` will compile your code, then load it into
gdb. 

You can then run `continue` in the gdb console to start running the code.

Note: This requires you to already be running either `st-util` or `openocd`

## Contributing 
1. Fork and fix it yourself and submit a pull request 
2. Open an issue describing the problem

If you're interested in running OpenOCD I suggest you look at this Makefile
[https://github.com/willprice/STM32L1-Discovery-baremetal-toolchain/blob/master/Makefile](https://github.com/willprice/STM32L1-Discovery-baremetal-toolchain/blob/master/Makefile)

[Make refcard]: http://www.schacherer.de/frank/technology/tools/make.html
