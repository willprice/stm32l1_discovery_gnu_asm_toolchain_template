SYSTEM_DEPS = System_Init.s

SRCS = Lab1-Task1.s
PROJ_NAME = main

CC_PREFIX     = arm-none-eabi-
CC            = $(CC_PREFIX)gcc
OBJCOPY       = $(CC_PREFIX)objcopy
GDB           = $(CC_PREFIX)gdb
STARTUP       = startup_stm32l1xx_md.s
CFLAGS       += -mcpu=cortex-m3 -mthumb -nostdlib -g
LINKER_SCRIPT = ld/stm32.ld

## ST-UTIL ##
STUTIL        = st-util
STFLASH       = st-flash


## TARGETS ##
all: flash

debug: $(PROJ_NAME).elf $(SRCS)	
	$(GDB) $(PROJ_NAME).elf -ex="tar extended-remote :4242" -ex="load"	

%.elf: %.s $(SYSTEM_DEPS)
	$(CC) $(CFLAGS) -T $(LINKER_SCRIPT) $^ $(STARTUP) -o $@

%.bin: %.elf
	$(OBJCOPY) -O binary $< $@

flash: $(PROJ_NAME).bin
	$(STFLASH) write $< 0x08000000 

clean:
	rm *.elf *.bin

.PHONY: all clean debug program flash
