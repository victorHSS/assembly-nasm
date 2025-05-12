global open, read_file, close

; define algumas constantes para syscall open
%define O_CREAT 0x40
%define O_RDONLY 0x0
%define O_WRONLY 0x1

section .text

open:
	mov rax, 2

	syscall
	ret

close:
	mov rax, 3

	syscall
	ret

; rdi - descritor
; rsi - buffer destino
; rdx - tamanho do buffer
; returns rax - buffer
read_file:
	mov rax, 0
	dec rdx

	syscall

	mov byte [rsi + rax], 0
	mov rax, rsi

	ret
