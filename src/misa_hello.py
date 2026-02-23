from machine68k import Machine, cpu_type_from_str  # from PyPI machine68k [web:40]

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

def io_read8(addr):
    if UART_BASE <= addr < UART_BASE + UART_SIZE:
        return uart.read8(addr)
    # Unimplemented devices: return open bus
    return 0xFF

def io_write8(addr, value):
    if UART_BASE <= addr < UART_BASE + UART_SIZE:
        uart.write8(addr, value & 0xFF)

# ---- Build the machine ----
cpu_type = cpu_type_from_str("68000")
# Back a full 24-bit address space to avoid invalid reads in unassigned regions.
ram_size_kib = 0x1000000 // 1024
m = Machine(cpu_type, ram_size_kib)  # MC68HC000 is a 68000 core [web:12][web:40]

# Map ROM and RAM
m.mem.w_block(ROM_START, bytes(rom))
m.mem.w_block(RAM_START, bytes(ram))

# Map I/O as special (only UART handled yet)
m.mem.set_special_range_read_funcs(IO_START, 1, r8=io_read8)
m.mem.set_special_range_write_funcs(IO_START, 1, w8=io_write8)

# Optionally verify / override SP & PC from vectors:
initial_sp = int.from_bytes(rom[0:4], "big")
initial_pc = int.from_bytes(rom[4:8], "big")
m.cpu.w_sp(initial_sp)
m.cpu.w_pc(initial_pc)

# ---- Run ----
try:
    while True:
        m.execute(10000)
except KeyboardInterrupt:
    print("\nStopped.")
