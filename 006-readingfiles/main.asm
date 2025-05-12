global _start
extern open, read, print_string, read_file
extern print_newline, print_uint, parse_uint, exit

%define O_RDONLY 0

section .data
	num: db "num = ", 0

section .rodata
	msgn: db "vNormal -> fat(num) = ", 0
	msgr: db "vRecurs -> fatrec(num) = ", 0
	msgp1: db "primo(2) = ", 0
	msgp2: db "primo(4) = ", 0
	filename: db "num.txt", 0
	fibonaccistr: db "n-esimo fibonacci = ", 0

section .bss
	buffer: resb 30

section .text

_start:
	; abrindo arquivo
	mov rdi, filename
	mov rsi, O_RDONLY
	mov rdx, 0
	call open

	; lendo arquivo
	mov rdi, rax
	mov rsi, buffer
	mov rdx, 30
	call read_file

	; printando conteudo lido
	push rax
	mov rdi, num
	call print_string
	pop rdi
	push rdi
	call print_string
	call print_newline

	; fazendo parse para uint
	pop rdi
	call parse_uint
	mov r12, rax

	mov rdi, msgn
	call print_string
	mov rdi, r12
	call fat
	mov rdi, rax
	call print_uint
	call print_newline

	mov rdi, msgr
	call print_string
	mov rdi, r12
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

	mov rdi, fibonaccistr
	call print_string
	mov rdi, r12
	call fibonacci
	mov rdi, rax
	call print_uint
	call exit

; fibonacci
; rdi - indice do numero fibonacci desejado
; return rax - n-enesimo fibonacci
fibonacci:
	cmp rdi, 1
	mov rax, 0
	je .end

	cmp rdi, 2
	mov rax, 1
	je .end

	cmp rdi, 3
	mov rax, 1
	je .end

	mov r8, 1
	mov rcx, 3
	.loop:
	mov r9, rax
	add rax, r8
	mov r8, r9

	inc rcx
	cmp rdi, rcx
	jne .loop

	.end:
	ret

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
	ja .loop

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



