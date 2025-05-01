global _start

section .data
	message: db 'Hello, world!',10

section .text
_start:
	mov rax, 1				; chamada ao sistema - função write
	mov rdi, 1				; arg #1 - 1 -> stdout
	mov rsi, message		; arg #2 - incício da string
	mov rdx, 14				; arg #3 - tamanho da string
	syscall

.exit:
	mov rax, 60				; chamada ao sistema - função exit
	xor rdi, rdi			; arg #1 - 0
	syscall
	
