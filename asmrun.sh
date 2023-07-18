#!/bin/bash
inp="$1"
out="${inp::-4}"
nasm -f elf $out.asm
ld -m elf_i386 -s -o $out $out.o
./$out



