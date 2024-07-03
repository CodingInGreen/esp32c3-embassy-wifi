/* Linker script for ESP32-C3 */

/* Define the memory regions */
MEMORY
{
    /* Flash memory (Non-volatile memory) */
    FLASH : ORIGIN = 0x42000000, LENGTH = 16M

    /* Instruction ROM */
    IROM : ORIGIN = 0x40080000, LENGTH = 4M

    /* Data ROM */
    DROM : ORIGIN = 0x3C000000, LENGTH = 16M

    /* Internal RAM */
    IRAM : ORIGIN = 0x40380000, LENGTH = 384K
    DRAM : ORIGIN = 0x3FC80000, LENGTH = 384K

    /* RTC Fast Memory */
    RTC_FAST : ORIGIN = 0x50000000, LENGTH = 8K
}

/* Define the sections and their placement in memory */
SECTIONS
{
    /* Place the .text section in IROM */
    .text :
    {
        KEEP(*(.text.entry))
        *(.text .text.*)
        KEEP(*(.init))
    } > IROM

    /* Place the .rodata section in DROM */
    .rodata :
    {
        *(.rodata .rodata.*)
    } > DROM

    /* Place the .bss section in DRAM */
    .bss (NOLOAD) :
    {
        *(.bss .bss.*)
    } > DRAM

    /* Place the .data section in DRAM */
    .data :
    {
        *(.data .data.*)
    } > DRAM

    /* Place the .iram section in IRAM */
    .iram :
    {
        *(.iram .iram.*)
    } > IRAM

    /* Place the .rtc_fast section in RTC_FAST */
    .rtc_fast (NOLOAD) :
    {
        *(.rtc_fast .rtc_fast.*)
    } > RTC_FAST
}
