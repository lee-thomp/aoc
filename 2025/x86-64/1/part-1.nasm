; -*- mode: nasm; -*-

section .rodata:
input: incbin `input`
inputlen: equ $-input


section .text
global _start

_start:
        mov rax, 1
        mov rdi, 1
        mov rsi, input
        mov rdx, inputlen
        syscall

        mov rax, 60
        mov rdi, 0
        syscall
