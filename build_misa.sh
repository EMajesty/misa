#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="${ROOT_DIR}/src"

AS="m68k-none-elf-as"
LD="m68k-none-elf-ld"
OBJCOPY="m68k-none-elf-objcopy"

ASM_SRC="${SRC_DIR}/misa.s"
LD_SCRIPT="${SRC_DIR}/misa.ld"
OBJ="${ROOT_DIR}/misa.o"
ELF="${ROOT_DIR}/misa.elf"
ROM="${ROOT_DIR}/rom.bin"

${AS} -mcpu=68000 -o "${OBJ}" "${ASM_SRC}"
${LD} -T "${LD_SCRIPT}" -nostdlib -o "${ELF}" "${OBJ}"
${OBJCOPY} -O binary "${ELF}" "${ROM}"

echo "Wrote ${ROM}"
