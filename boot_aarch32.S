/*
* AArch32 mode
* RPI 2 has 4 cores
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

/* 
* entry point for the kernel
* r15 -> should begin execution at 0x8000
* r0 -> 0x00000000
* r1 -> 0x00000C42 (machine id)
* r2 -> 0x00000100 (start of ATAGS) | ATAGS=ARM tags; carry information like mem size
* preserving these regersiters as arguments for kernel_main
*/
// starting point of program
_start:
    /*
    * send 3 of our 4 cores to a hault, utilizing 1 core for this project
    * mrc : coprocessor-access function; move to ARM register from coprocessor
    *   * this reads code register
    *   * cp15 - control processor
    *   * c0 - CPU ID register
    *   * r1 - contains the machine ID
    *   - mrc <coproc>, opcode, Rt, Crn, Crm, {opcode2}
    *       * coproc : name of coprocessor instruction is for; format p{0-15}
    *       * opcode1 : 3-bit coprocessor-specific code
    *       * Rt : ARM destination register
    *       * Crn : coprocessor register number within CP15
    *       * Crm : (optional) operational register
    *       * opcode2 : optional 3-bit coprocessor-specific code
    * and : BITWISE operator; returns 1 if both bits are 1, 0 otherwise
    * cmp : compares whatever is passed in
    * bne : Branch if Not Equal
    * mov : move
    * ldr : loads a register
    * b   : branch to (or jump)
    */
#ifndef PI_1

    // mrc <coproc>, opcode, Rt, Crn, Crm, {opcode2}
    mrc p15, #0, r1, c0, c0, #5     // read CPU ID register in c0, stores value in r1
    and r1, r1, #3                  // stores in r1 the AND op of r1 and #3
    cmp r1, #0                      // compares #0 to value in r1 (#0 - r1)
    bne halt                        // send the 3 cores to halt:
    // 3/4 cores are now not in use
#endif

    // declares the address of where our C stack ptr will start, moves downwards
    mov sp, #0x8000                 // 0x8000 = boot code of AArch32 processor

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
    ldr r4, = __bss_start           // load address of start in register r4
    ldr r9, = __bss_end             // load address of end in register r9
    mov r5, #0                      // move 0 into registers r5-r8
    mov r6, #0                      
    mov r7, #0
    mov r8, #0
    b       2f                      /* loop to address start end; 
                                       check if addr in r4 < r9 */
// check if addr in r4 < r9
1:
    /*
    * stm : stores second operand into addr of the first
    * ia  : increment after
    * !   : store address back in r4 instead of last addr written to
    */
    stmia r4!, {r5-r8}              /* store values of r5-r8 into addr of r4;
                                    * 4 bytes each = 16 bytes total of 0's
                                    */
// loop until r4 >= r9 & bss is 0'd ot
2:
    /*
    * blo : returns lower result of 
    * blx : copies address of next instruction into link register r14
    */
    cmp r4, r9                      // compare values at the start & end
    blo 1b                          // returns lower result 
    ldr r3, =kernel_main            // load addr of C func kernel_main into r3
    blx r3                          // jump to previously loaded addr r3

// procedure that loops forever; constantly waiting for next event
halt:
    // wfe : wait for event 
    wfe
    // jump to halt 
    b halt


