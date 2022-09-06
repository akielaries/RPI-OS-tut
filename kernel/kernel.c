/*
 * kernel.c containts the very root of the kernel. This file is where
 * we transfer over control from assembly in our boot_aarch*.S file
 *
 */

// define different macros we may need
#include<stddef.h>
// more macros; overall easier for portability 
#include<stdint.h>
// import what is necessary for UART functionality
#include<../include/core/uart.h>
// more imports as we implement more "features"

void kernel_main(uint32_t r0, uint32_t r1, uint32_t atags) {
    // declare these registers as unused for now
    (void) r0;
    (void) r1;
    (void) atags;

    // initialize 
    uart_init();
    // print statement to console on successful execution
    uart_puts("");



}


