global open

; define algumas constantes para syscall open
%define O_CREAT 0x40
%define O_RDONLY 0x0
%define O_WRONLY 0x1

section .text

open:
	mov rax, 2

	syscall
