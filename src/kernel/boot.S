/*
# boot assembly file that is first thing the hardware
# will execute in the kernel. This assembly code will
# load the kernal telling it about C runtime environment
# allowing us to begin programming the OS in C lang. The 
# quicker we can jump to programming with some abstraction
# the better

# ================================
# _start: control is handed off from the bootloaded to kernel
#       set up stack ptr

/* ================================ 
*/

.section ".text.boot"
    mov

.global _start

_start:
    mrc p15, #0, r1, c0,c0, #5
    and r1, r1, #3
    cmp r1, #0
    bne halt
    
    mov sp, #0x8000

    ldr r4, =__bss_start
    ldr r9m =__bss_end
    mv r5


