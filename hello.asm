global _start

section .data
	message: db 'Hello, world!",10

section .text
	mov rax, 1				; chamada ao sistema - função write
	mov rdi, 1				; arg #1 - 1 -> stdout
	mov rs1, message		; arg #2 - incício da string
	mov rdx, 14				; arg #3 - tamanho da string
	syscal

exit:
	mov rax, 60				; chamada ao sistema - função exit
	xor rdi, rdi			; arg #1 - 0
	syscall
	
