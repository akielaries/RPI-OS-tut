# Makefile compiling our project into an image
CC 			= arm-none-eabi-gcc
CXX 		= arm-none-eabi-g++
CC_STD		= -std=gnu99
CXX_STD		= -std=c++2a

# set variables based on Raspberry Pi Model
ifeq ($(RASPI_MODEL), 1)
	CPU 		= arm1176jzf-s
	MEM			= 512
	DIRECTIVES 	= -D PI_1
	HOST		= raspi1ap
endif

ifeq ($(RASPI_MODEL), 2)
	CPU 		= cortex-a7
	MEM			= 1024
	DIRECTIVES 	= -D PI_2
	BOOT 		= boot_aarch32.S
	LINK		= linker_aarch32.ld
	HOST      	= raspi2b
endif

ifeq ($(RASPI_MODEL), 3)
    CPU 		= cortex-a53
	DIRECTIVES 	= -D PI_3
	BOOT 		= boot_aarch64.S
	LINK		= linker_aarch64.ld
	HOST		= raspi3
endif

ifeq ($(RASPI_MODEL), 4)
    CPU 		= cortex-a72
	DIRECTIVES 	= -D PI_4
endif

ifeq ($(RASPI_MODEL), 5)
    CPU 		= cortex-a76
	DIRECTIVES 	= -D PI_5
endif

CPU_FLGS	= -mcpu=$(CPU)
C_FLGS		= -fpic -ffreestanding
ADD_C_FLGS	= -g -Wno-unused-result -Wparentheses -Wsign-compare -DNDEBUG -Wall -Wextra -O2
# source files
SRCS		= kernel.c core.c uart.c mem.c
# corresponding object files
OBJS		= $(SRCS:.c=.o)
# final binary name
ELF			= piOS.elf

entrypoint: boot.o
boot.o: $(BOOT)
	$(CC) $(CPU_FLGS) $(C_FLGS) -c $(BOOT) -o boot.o

%.o: %.c
	$(CC) $(CPU_FLGS) $(C_FLGS) $(ADD_C_FLGS) -c $< -o $@

compile_kernel: entrypoint $(OBJS)
	$(CC) $(CPU_FLGS) -T $(LINK) -o $(ELF) $(C_FLGS) $(ADD_C_FLGS) -nostdlib boot.o $(OBJS)


cpp_compile:
	$(CXX) -mcpu=cortex-a7 -fpic -ffreestanding -fno-exceptions -c boot_aarch32.S -o boot.o
	$(CXX) -mcpu=cortex-a7 -fpic -ffreestanding -fno-exceptions -c kernel.c -o kernel.o
	$(CXX) -T linker_aarch32.ld -o piOS.elf -ffreestanding -fno-exceptions -O2 -nostdlib boot.o kernel.o

QEMU_ARM	= qemu-system-arm
Q_MEM		= -m $(MEM)
Q_HOST		= -M $(HOST)
Q_FLGS		= -serial stdio -kernel

piOS_qemu:
	$(QEMU_ARM) $(Q_MEM) $(Q_HOST) $(Q_FLGS) $(ELF)

run:
	qemu-system-arm -m 1024 -M raspi2b -serial stdio -kernel piOS.elf

clean:
	rm -rf *.o *.elf
