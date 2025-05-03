global _start

section .data
	str: db 'uma string qualquer', 0
	str2: db 'outra string', 0

section .text

_start:
	mov rdi, str

	call print_string
	call print_newline

	mov cl, [str + 1]
	mov rdi, rcx

	call print_char
	call print_newline

	mov rdi, 2131748178
	call print_uint
	call print_newline

	mov rdi, -986518
	call print_int
	call print_newline

	; testando string equals
	mov rdi, str
	mov rsi, str2
	call string_equals
	mov rdi, rax
	call print_uint
	call print_newline

	; testando read_char
	call read_char
	mov rdi, rax
	call print_char
	call print_newline

	call exit


exit:
	mov rax, 60
	xor rdi, rdi
	syscall

string_length:
    xor rax, rax

    .loop:
    cmp byte [rdi + rax], 0
	je .end

	inc rax

	jmp .loop

    .end:
    ret

print_string:
    call string_length

    mov rdx, rax
    mov rax, 1
    mov rsi, rdi
    push rdi
    mov rdi, 1

	push rcx
    syscall
    pop rcx
    pop rdi

    ret

print_char:
	push rdi

	mov rax, 1
	mov rdi, 1
	mov rsi, rsp
	mov rdx, 1

	push rcx
	syscall
	pop rcx

	pop rdi

    ret

print_newline:
    mov rdi, 10
    call print_char

    ret


print_uint:
    mov rcx, rsp			; salvo rsp em rcx
    sub rsp, 21				; aloco 21 bytes na pilha - MAX UINT chars + '0'
	mov byte [rsp + 20], 0 	; o char nulo
	dec rcx					; ajusta rcx para inicio da string
	mov rbx, 10				; divisor

	mov rax, rdi

	.loop:
	xor rdx, rdx	; zero rdx, para não ter valor na parte alta da divisao

	div rbx
	or dl, 0x30		; podia ser add, mas or eh mais rapido
	dec rcx
	mov byte [rcx], dl	; atribuindo o char

	cmp rax, 0
	jnz .loop

	lea rdi, [rcx]			; ok, já podia ter usado o rdi desde o inicio

	call print_string

	add rsp, 21				; devolvo os 21 bytes da pilha
    ret


print_int:
    test rdi, rdi
    jns .num				; vai para .num se nao tiver sinal

    push rdi
    mov rdi, '-'
	call print_char

	pop rdi
	neg rdi

    .num:
    jmp print_uint

    ; nao precisa ret aqui


string_equals:
	xor r8, r8
	xor rax, rax

    .loop:
    mov r9b, byte [rsi + r8]
    cmp byte [rdi + r8], r9b
    jnz .dif

	test byte [rdi + r8], r9b ; ok, sao iguais, mas se forem zero, para
	je .iguais

	inc r8
    jmp .loop

    .iguais:
    mov rax, 1

    .dif:
    ret


read_char:
    push 0			; aloco um byte na pilha

	mov rax, 0		; chamada a read
	mov rdi, 0		; ler stdin
	mov rsi, rsp	; salvar no byffer
	mov rdx, 1		; 1 byte
	syscall

	pop rax

    ret


read_word:
    ret

; rdi points to a string
; returns rax: number, rdx : length
parse_uint:
    xor rax, rax
    ret

; rdi points to a string
; returns rax: number, rdx : length
parse_int:
    xor rax, rax
    ret


string_copy:
    ret
