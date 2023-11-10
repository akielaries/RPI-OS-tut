# Makefile compiling our project into an image
CC 		= arm-none-eabi-gcc
CXX 	= arm-none-eabi-g++

compile:
	${CC} -mcpu=cortex-a7 -fpic -ffreestanding -c boot_aarch32.S -o boot.o
	${CC} -mcpu=cortex-a7 -fpic -ffreestanding -std=gnu99 -c kernel.c -o kernel.o
	${CC} -T linker_aarch32.ld -o piOS.elf -ffreestanding -O2 -nostdlib boot.o kernel.o


cpp_compile:
	${CXX} -mcpu=cortex-a7 -fpic -ffreestanding -fno-exceptions -c boot_aarch32.S -o boot.o
	${CXX} -mcpu=cortex-a7 -fpic -ffreestanding -fno-exceptions -c kernel.c -o kernel.o
	${CXX} -T linker_aarch32.ld -o piOS.elf -ffreestanding -fno-exceptions -O2 -nostdlib boot.o kernel.o

QEMU		= qemu-system-arm
MEM			= -m 1024
HOST		= -M raspi2b
QEMU_FLGS	= -serial stdio -kernel

run:
	qemu-system-arm -m 1024 -M raspi2b -serial stdio -kernel piOS.elf

clean:
	rm -rf *.o *.elf
