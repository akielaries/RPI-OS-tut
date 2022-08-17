# Makefile compiling our project into an image
#
# Go thru and comment this file in detail

PROJDIR     = $(realpath $(CURDIR)/..)
GCCPATH		= /home/linuxbrew/.linuxbrew/Cellar/aarch64-elf-gcc/12.1.0/bin
CC          = $(GCCPATH)/aarch64-elf-gcc
CFLAGS      = -Wall -O2 -ffreestanding -nostdinc -nostdlib -nostartfiles

UTILSPATH	= /home/linuxbrew/.linuxbrew/Cellar/aarch64-elf-binutils/2.38/bin
LINK		= $(UTILSPATH)/aarch64-elf-ld
LINKFILE	= linker_aarch64.ld
OBJCPY		= $(UTILSPATH)/aarch64-elf-objcopy

# CFILES = $(wildcard *.c)
CFILES	   := $(shell find $(PROJDIR) -name '*.c')
OFILES 		= $(CFILES:.c=.o)
SFILES	   := $(shell find $(PROJDIR) -name '*.S')
CREATEDOF  := $(shell find $(PROJDIR) -name '*.o')

BOOT		= ../kernel
# kernel8 = aarch64 mode (ARMv8)
EXE-LNK		= kernel8.elf
IMG			= kernel8.img
TARGET2		= main

all: clean $(IMG)

boot.o: $(BOOT)/boot_aarch64.S
	$(CC) $(CFLAGS) -c $(BOOT)/boot_aarch64.S $(BOOT)/-o boot_aarch64.o

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

kernel8.img: $(BOOT)/boot_aarch64.o $(OFILES)
	$(LINK) -nostdlib $(BOOT)/boot_aarch64.o $(OFILES) -T $(LINKFILE) -o $(EXE-LNK)
	$(OBJCPY) -O binary $(EXE-LNK) $(IMG)

clean:
	/bin/rm $(EXE-LNK) *.img > /dev/null 2> /dev/null || true 
	rm -rf $(CREATEDOF)

