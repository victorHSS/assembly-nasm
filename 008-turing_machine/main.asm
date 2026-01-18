%include "lib.asm"

; Turing Machine
; even/odd

global _start

section .data
	txt: db "Entre com uma sequencia de 0s e 1s (q para finalizar):", 0
	error: db "Caractere invalido...", 13, 0
	
section .bss
	char: resb 1

section .text

_start:
	mov rdi, txt
	call print_string
	
	call even_odd
	
	mov rdi, rax
	call print_int
	call print_newline

	call exit

; return rax: 0 (even) or 1 (odd) or -1 (error)
even_odd:
	mov rdi, char
	
	.A:
	
	call read_char
	
	cmp al, '1'
	je .B
	
	cmp al, '0'
	je .A
	
	cmp al, 'q'
	jne .E
	
	mov rax, 0
	ret
	
	.B:
	
	call read_char
	
	cmp al, '1'
	je .A
	
	cmp al, '0'
	je .B
	
	cmp al, 'q'
	jne .E
	
	mov rax, 1
	ret
	
	.E:
	mov rax, -1
	ret
