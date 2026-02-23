    .section .vectors
    .org    0x00000000
    .long   0x001FFFFC      | initial SP (top of RAM)
    .long   _start          | initial PC

    .section .text
    .globl _start

UART_BASE   = 0x00E00000

_start:
    lea     message,a0
print:
    move.b  (a0)+,d0
    beq     done
    move.b  d0,UART_BASE    | write to TL16C550 THR
    bra     print
done:
    bra     done

    .section .rodata
message:
    .asciz  "Hello from MISA!\r\n"

