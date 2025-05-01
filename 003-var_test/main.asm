;
; prog simples só pra analisar o comportamento de uma variavel no gdb
;

global _start

section .data
	var: dq -1

section .text
_start:
	mov byte[var], 1
	mov rax, [var]
	mov word[var], 1
	mov rax, [var]
	mov dword[var],1
	mov rax, [var]
	mov qword[var],1
	mov rax, [var]
