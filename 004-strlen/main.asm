;
;   joga na saida de retorno para o SO o tamanho da string
;

global _start

section .data
	str: db 'uma string qualquer de tamanho 33', 0

section .text
strlen:
	xor rax, rax			; zero o reg rax, o contador

	.loop:
	cmp byte [rdi + rax], 0

	je .end

	inc rax					; incrementa rax em 1
	jmp .loop

	.end:
	ret						; rax ja vai conter o valor de retorno

_start:
	mov rdi, str

	call strlen

	mov rdi, rax			; ja configuro o argumento do exit
	mov rax, 60				; chamada exit

	syscall
