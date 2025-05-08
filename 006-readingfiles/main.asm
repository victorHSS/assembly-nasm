%include "lib.asm"

global _start

section .data
	msgn: db "vNormal -> fat(5) = ", 0
	msgr: db "vRecurs -> fatrec(5) = ", 0
	msgp1: db "primo(2) = ", 0
	msgp2: db "primo(4) = ", 0

section .text

_start:
	mov rdi, msgn
	call print_string
	mov rdi, 5
	call fat
	mov rdi, rax
	call print_uint
	call print_newline

	mov rdi, msgr
	call print_string
	mov rdi, 5
	call fatrec
	mov rdi, rax
	call print_uint
	call print_newline

	mov rdi, msgp1
	call print_string
	mov rdi, 2
	call primo
	mov rdi, rax
	call print_uint
	call print_newline

	mov rdi, msgp2
	call print_string
	mov rdi, 4
	call primo
	mov rdi, rax
	call print_uint
	call print_newline

	call exit


; versao recursiva
; rdi - num
; returns rax - fat(num)
fatrec:
	cmp rdi, 1			; caso base
	jnz .cont
	mov rax, 1
	ret

	.cont:
	push rdi

	dec rdi
	call fat

	pop rdi

	xor rdx, rdx
	mul rdi

	ret

; rdi - num
; returns rax - fat(num)
fat:
	mov rax, 1

	.loop:
	xor rdx, rdx
	mul rdi
	dec rdi

	cmp rdi, 1
	jnz .loop

	.end:
	ret

; rdi - num
; returns rax - 1 para primo, 0 caso contrario
; obs: intencionalmente, farei do jeito bruto 2..n-1
primo:
	mov rax, rdi
	dec rdi
	.loop:
	cmp rdi, 1
	jz .primo

	mov r8, rax
	xor rdx, rdx
	div rdi

	cmp rdx, 0
	jz .naoprimo

	mov rax, r8
	dec rdi

	jmp .loop

	.primo:
	mov rax, 1
	ret

	.naoprimo:
	mov rax, 0
	ret



