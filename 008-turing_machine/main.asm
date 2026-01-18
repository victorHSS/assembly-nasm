%include "lib.asm"

; Turing Machine
; even/odd

global _start

section .data
	binary: db "1010101", 0
	info: db "Analisando sequencia binaria...", 10, 0
	result: db "O numero de 1s eh ", 0
	par: db "Par", 10, 0
	impar: db "Impar", 10, 0
	error: db "Presenca de caractere invalido...", 10, 0
	
section .text

_start:
	mov rdi, info
	call print_string
	
	mov rdi, binary
	call print_string
	call print_newline
	
	mov rdi, binary
	call even_odd
	
	cmp rax, 0
	je .par
	
	cmp rax, 1
	je .impar
	
	mov rdi, error
	call print_string
	
	jmp .end
	
	.par:
	mov rdi, result
	call print_string
	mov rdi, par
	call print_string
	
	jmp .end
	
	.impar
	mov rdi, result
	call print_string
	mov rdi, impar
	call print_string
	
	jmp .end
	
	.end:
	call exit

; rdi: string binary ptr
; return rax: 0 (even) or 1 (odd) or -1 (error)
even_odd:
	dec rdi
	
	.A:
	
	inc rdi
	
	cmp [rdi], byte '1'
	je .B
	
	cmp [rdi], byte '0'
	je .A
	
	cmp [rdi], byte 0
	jne .E	
	
	mov rax, 0
	ret
	
	.B:
	
	inc rdi
	
	cmp [rdi], byte '1'
	je .A
	
	cmp [rdi], byte '0'
	je .B
	
	cmp [rdi], byte 0
	jne .E
	
	mov rax, 1
	ret
	
	.E:
	mov rax, -1
	ret
