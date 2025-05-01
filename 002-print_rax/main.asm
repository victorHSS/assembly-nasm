;
;	Apresenta na tela o conteúdo de rax
;

global _start

section .data
	codes: db '0123456789ABCDEF'
	prefix: db '0x'
	endl: db 10

section .text

_exit:
	mov rax, 60
	xor rdi, rdi
	syscall

_printprefix:
	mov rax, 1
	mov rdi, 1					; stdout
	mov rsi, prefix
	mov rdx, 2

	push rcx
	syscall
	pop rcx

	ret

_printhex:
	lea rsi, [codes + rax]		; pego o endereço exato do caracter a ser impresso
	mov rax, 1
	mov rdi, 1
	mov rdx, 1

	push rcx
	syscall
	pop rcx

	ret

_printendl:
	mov rax, 1
	mov rdi, 1
	mov rsi, endl
	mov rsi, 1

	push rcx
	syscall
	pop rcx

	ret

_start:
	mov rax, 45068				; esse eh o numero que vamos converter
	mov rcx, 64					; esse vai dizer quantos bits vamos deslocar

	push rax
	call _printprefix			; ja printo o '0x'
	pop rax

	.loop:
	push rax

	sub rcx, 4					; como cada hexa equivale a 4 bits, vamos subtraindo 4
	sar rax, cl					; desloco para direita dl (parte baixa de rdx) bits
	and rax, 0xf				; aplicando mascara para filtrar mesmo so os 4 bits ultimos

	push rcx					; salvo na pilha - called-saved

	call _printhex

	pop rcx
	pop rax

	test rcx, rcx
	jnz .loop

	call _printendl

	call _exit
