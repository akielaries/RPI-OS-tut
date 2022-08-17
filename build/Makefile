PROJDIR     = $(realpath $(CURDIR)/..)
GCCPATH		= /home/linuxbrew/.linuxbrew/Cellar/aarch64-elf-gcc/12.1.0/bin
CC          = $(GCCPATH)/aarch64-elf-gcc

UTILSPATH	= /home/linuxbrew/.linuxbrew/Cellar/aarch64-elf-binutils/2.38/bin
LINK		= $(UTILSPATH)/aarch64-elf-ld
LINKFILE	= linker_aarch64.ld
OBJCPY		= $(UTILSPATH)/aarch64-elf-objcopy

CFILES		= $(wildcard *.c)
OFILES 		= $(CFILES:.c=.o)
BOOT		= ../src/kernel/
CFLAGS		= -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles

TARGET1		= kernel8.elf
TARGET2		= main

all: clean kernel8.img


boot.o: $(BOOT)/boot_aarch64.S
	$(CC) $(CFLAGS) -c $(BOOT)/boot_aarch64.S $(BOOT)/-o boot_aarch64.o

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

kernel8.img: $(BOOT)/boot_aarch64.o $(OFILES)
	$(LINK) -nostdlib $(BOOT)/boot_aarch64.o $(OFILES) -T $(LINKFILE) -o $(TARGET)
	$(OBJCPY) -O binary $(TARGET) kernel8.img

clean:
	/bin/rm $(TARGET) *.o *.img > /dev/null 2> /dev/null || true

