ENTRY(_start)

MEMORY {
    rom (rx)  : ORIGIN = 0x00000000, LENGTH = 0x00100000  /* 1 MiB ROM */
    ram (rwx) : ORIGIN = 0x00100000, LENGTH = 0x00100000  /* 1 MiB RAM */
}

/* Place everything we care about into ROM, starting at 0 */
SECTIONS {
    . = 0x00000000;

    .vectors : {
        KEEP(*(.vectors))
    } > rom

    .text : {
        *(.text*)
        *(.rodata*)
    } > rom

    .data : {
        *(.data*)
    } > ram AT > rom

    .bss (NOLOAD) : {
        *(.bss*)
        *(COMMON)
    } > ram
}

