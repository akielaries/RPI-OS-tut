/*
# AArch32 mode
# 
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
    .org 0x8000

// Entry point for the kernel.
// r15 -> should begin execution at 0x8000.
// r0 -> 0x00000000
// r1 -> 0x00000C42 - machine id
// r2 -> 0x00000100 - start of ATAGS
// preserve these registers as argument for kernel_main
_start:
    // shut off the extra cores
    mrc p15, #0, r1, c0,c0, #5
    and r1, r1, #3
    cmp r1, #0
    bne halt
    
    // setup the stack
    ldr r5 = start
    mov sp, #0x8000

    // clear out bss
    ldr r4, =__bss_start
    ldr r9m =__bss_end
    mov r5, #0
    mov r6, #0
    mov r7, #0
    mov r8, #0
    b       2f

1:
    // store multiple at r4
    stmia r4!, {r5-r8}
    // if we are still bellow __bss_end, loop

2:
    cmp r4, r9
    blo 1b

    // call kernel_main
    ldr r3, =kernel_main
    blx r3
    // halt

halt:
    wfe
    b halt

