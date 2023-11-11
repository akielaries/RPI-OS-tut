#ifndef __UART_H__
#define __UART_H__

#include <stdint.h>

typedef enum {
    // The GPIO registers base address.
    PI01_GPIO_BASE = 0x20200000, // for raspi2 & 3, 0x20200000 for raspi1
    PI23_GPIO_BASE = 0x3F200000,
    PI04_GPIO_BASE = 0xff, // TODO figure this out

    // REGISTER OFFSETS
    GPPUD = (PI23_GPIO_BASE + 0x94),
    GPPUDCLK0 = (PI23_GPIO_BASE + 0x98),

    // The base address for UART.
    PI23_UART_BASE = 0x3F201000, // for raspi2 & 3, 0x20201000 for raspi1

    UART0_DR = (PI23_UART_BASE + 0x00),
    UART0_RSRECR = (PI23_UART_BASE + 0x04),
    UART0_FR = (PI23_UART_BASE + 0x18),
    UART0_ILPR = (PI23_UART_BASE + 0x20),
    UART0_IBRD = (PI23_UART_BASE + 0x24),
    UART0_FBRD = (PI23_UART_BASE + 0x28),
    UART0_LCRH = (PI23_UART_BASE + 0x2C),
    UART0_CR = (PI23_UART_BASE + 0x30),
    UART0_IFLS = (PI23_UART_BASE + 0x34),
    UART0_IMSC = (PI23_UART_BASE + 0x38),
    UART0_RIS = (PI23_UART_BASE + 0x3C),
    UART0_MIS = (PI23_UART_BASE + 0x40),
    UART0_ICR = (PI23_UART_BASE + 0x44),
    UART0_DMACR = (PI23_UART_BASE + 0x48),
    UART0_ITCR = (PI23_UART_BASE + 0x80),
    UART0_ITIP = (PI23_UART_BASE + 0x84),
    UART0_ITOP = (PI23_UART_BASE + 0x88),
    UART0_TDR = (PI23_UART_BASE + 0x8C),
} UART_ADDRS;

void mmio_write(uint32_t reg, uint32_t data);

uint32_t mmio_read(uint32_t reg);

void delay(int32_t count);

void uart_init();

void uart_putc(unsigned char c);

unsigned char uart_getc();

void uart_puts(const char *str);

#endif
