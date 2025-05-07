global _start

section .data
	str: db 'uma string qualquer', 0
	str2: db 'outra string', 0
	strmsg: db 'Entre com algum caractere: ', 0
	strnum: db '987654321', 0
	strneg: db '-650001', 0
	buffer: times 30 db 0

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
	mov rdi, strmsg
	call print_string
	call read_char
	mov rdi, rax
	call print_char
	call print_newline

	; testando parse_uint
	mov rdi, strnum
	call parse_uint
	mov rdi, rax
	call print_uint
	call print_newline

	; testando parse_int
	mov rdi, strneg
	call parse_int
	mov rdi, rax
	call print_int
	call print_newline

	; testando string_copy
	mov rdi, str2
	mov rsi, buffer
	mov rdx, 30
	call string_copy
	mov rdi, rax
	call print_string

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
    xor rax, rax	; o numero resultante
    xor r11, r11	; comprimento do numero em string
	mov r12, 10

	.parsing:
	movzx rcx, byte [rdi + r11]
	cmp rcx, 0x0
	jz .end

	sub rcx, '0'				; aqui, rcx ja contem o valor do digito

	xor rdx, rdx
	mul r12					; multiplicando valor base em rax por 10

	and rcx, 0xff
	add rax, rcx

	inc r11
	jmp .parsing

    .end:
    mov rdx, r11

    ret

; rdi points to a string
; returns rax: number, rdx : length
parse_int:
    cmp byte [rdi], '-'
    jnz parse_uint

    ; se ele for negativo
    inc rdi
    call parse_uint
    neg rax
    inc rdx

    ret


; rdi points to a string
; rsi points to a buffer
; rdx buffer length
string_copy:
	push rdi
	push rsi
	push rdx
	call string_length
	pop rdx

	mov r8, rax
	mov rax, 0
	cmp rdx, r8
	jbe .fim

	pop rsi
	pop rdi

	mov rax, rsi
	xor r9, r9

	.loop:
	mov r10b, byte [rdi + r9]
	mov byte [rsi + r9], r10b
	inc r9

	cmp r8, r9
	jnz .loop

	.fim:
    ret
