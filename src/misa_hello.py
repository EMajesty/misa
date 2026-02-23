from machine68k import Machine  # from PyPI machine68k [web:40]

# ---- Address map (from MISA docs) ----
ROM_START = 0x00000000
ROM_SIZE  = 0x00100000  # 1 MiB

RAM_START = 0x00100000
RAM_SIZE  = 0x00100000  # 1 MiB

IO_START  = 0x00E00000
IO_SIZE   = 0x00010000  # 64 KiB total I/O

UART_BASE = 0x00E00000
UART_SIZE = 0x00001000  # 4 KiB UART window (A0–A2 used) [web:40]

# ---- Load ROM image ----
rom = bytearray(ROM_SIZE)
with open("rom.bin", "rb") as f:
    data = f.read()
rom[:len(data)] = data

# ---- Create RAM ----
ram = bytearray(RAM_SIZE)

# ---- Simple TL16C550-style UART model ----
class Uart16550:
    def __init__(self):
        self.tx = 0

    def read8(self, addr):
        # For now, just claim transmitter empty, no real RX.
        # You can expand to model LSR, THR, RBR, etc.
        return 0x20

    def write8(self, addr, value):
        offset = addr - UART_BASE
        # In a real 16550, THR is at offset 0, LSR at 5, etc. [web:40]
        if offset == 0x00:
            self.tx = value
            print(chr(value), end="", flush=True)

uart = Uart16550()

def io_read(addr, size):
    if UART_BASE <= addr < UART_BASE + UART_SIZE:
        if size == 1:
            return uart.read8(addr)
        # If your code does word/long I/O, extend this to combine bytes.
        return uart.read8(addr) & 0xFF
    # Unimplemented devices: return open bus
    return 0xFF

def io_write(addr, value, size):
    if UART_BASE <= addr < UART_BASE + UART_SIZE:
        if size == 1:
            uart.write8(addr, value & 0xFF)
        else:
            # For word/long, just take low byte for now
            uart.write8(addr, value & 0xFF)

# ---- Build the machine ----
m = Machine(cpu_type="68000")  # MC68HC000 is a 68000 core [web:12][web:40]

# Map ROM and RAM
m.map_ram(ROM_START, ROM_START + ROM_SIZE - 1, rom)   # treat as ROM by convention
m.map_ram(RAM_START, RAM_START + RAM_SIZE - 1, ram)

# Map I/O as special (only UART handled yet)
m.map_special(IO_START, IO_START + IO_SIZE - 1,
              read_cb=io_read, write_cb=io_write)

# Optionally verify / override SP & PC from vectors:
# import struct
# initial_sp = int.from_bytes(rom[0:4], "big")
# initial_pc = int.from_bytes(rom[4:8], "big")
# m.set_reg("SP", initial_sp)
# m.set_reg("PC", initial_pc)

# ---- Run ----
try:
    while True:
        m.run(cycles=10000)
except KeyboardInterrupt:
    print("\nStopped.")

