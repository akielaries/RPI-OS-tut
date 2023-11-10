/*
* AArch64 mode; developed for the RPI 3 & 4 
* boot assembly file that is first thing the hardware
* will execute in the kernel. This assembly code will
* load the kernal telling it about C runtime environment
* allowing us to begin programming the OS in C lang. The 
* quicker we can jump to programming with some abstraction
* the better
*
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* _start : control is handed off from the bootloader to kernel
* - set up stack ptr
* - set up C globals in BSS section
*       * __bss_start __bss_end : defined in linker_aarch64.ld
*       * label 1 : 16 bytes of consecutive zeros loaded ino BSS section
*       * label 2 : loops til BSS is 0'd
* - jump into the kernel main()
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*/

/* 
* notes to our linker we will be creating 
* .section: 
*   - declaring initialized data or constants; not changed at runtime
*   - instructs the assembler we will be using to assemble a new code/data 
*   section belonging in a compiled binary
*
* .globl:
*   - tells the kernel where the starting point of our program is
*   - declaring a global variable that can be seen from outside of this
*   assembly file
*/
.section ".text.boot"
.globl _start
    .org 0x80000
/* 
* entry point for the kernel
* x0 -> 32 bit pointer to DTB in memory (primary core only) / 0 (secondary cores)
* x1 -> 0
* x2 -> 0
* x3 -> 0
* x4 -> 32 bit kernel entry point; location for _start
*
* preserving these regersiters as arguments for kernel_main
*/
// starting point of program
_start:
    /*
    * mrs :
    * and : BITWISE operator; returns 1 if both bits are 1, 0 otherwise
    * cbz :
    */
    // check processor ID is zero; confirm running on main core, or wfe
    mrs     x1, mpidr_el1
    and     x1, x1, #3
    cbz     x1, 2f


1:      
    /*
    * wfe : wait for event
    * mov : move
    * ldr : loads a register
    * b   : branch to (or jump)
    */
    // infinite loop waiting for event; getting into main core
    wfe
    b       1b
2:
    /*
    * mov : move
    * ldr : loads a register
    * b   : branch to (or jump)
    */

    // main core; set stack 
    ldr     x1, = _start        // load _start into register x5
    mov     sp, x1              // move x5 into our stack ptr
    /*
    * BSS  = block starting symbol : statically allocated variables 
    * declared but not assigned values
    * We will load addresses into the bss registers. This is where C globals 
    * not seen at compile are stored. We will zero out these vals ourselves as
    * C requires!
    * 
    * These are defined in /build/linker.ld
    */
    // clears out bss 
    ldr     x5, = __bss_start   // load address of start into register x5
    ldr     w6, = __bss_size    // size of the section

3:
    /*
    * str :
    * sub :
    * cbnz:
    */
    cbz     w6, 4f
    str     xzr, [x1], #8
    sub     w6, w6, #1
    cbnz    w2, 3b              // loop != 0

// jumps to C code and does not return
4:
    bl      kernel_main
    // failsafe includes halting main core
    b lb


