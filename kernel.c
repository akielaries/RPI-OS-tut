/**
 * kernel.c containts the very root of the kernelf for this OS. I hope for this
 * code to be easily portable to other architechtures as well. This file is
 * where we transfer over control from assembly in our boot_aarch*.S file to C.
 *
 */

#include "lib/uart.h"
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
// so C functions don't get mangle by g++ compiler
extern "C" void kernel_main(uint32_t, uint32_t, uint32_t);
extern "C" {
void kernel_main(uint32_t, uint32_t, uint32_t);
}
#endif

void kernel_main(uint32_t r0, uint32_t r1, uint32_t atags) {
    (void)r0;
    (void)r1;
    (void)atags;
    char buffer[256];

    uart_init();
    uart_puts("piOS v0.0.1\n");

    while (1) {
        uart_gets(buffer, sizeof(buffer));
        // uart_putc(uart_getc());
        uart_puts(buffer);
        uart_putc('\n');
    }
}
