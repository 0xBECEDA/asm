	.file	"test.s"
	.text
	.globl	main
	.type	main, @function
my_stack:
    .rept 20
    .byte 2
    .endr
my_stack_bp:
    .byte 1
    .int 0

hello:
    .int bye
    .string "Hello!"
    movl $hello, %edi
    add $4, %edi
    jmp print_success
    .byte 0

bye:
    .int hi
    .string "Bye!"
    movl $bye, %edi
    add $4, %edi
    call print_success
    pop %eax
    ret
    .byte 0
hi:
    .int 0
    .string "Hi!"
    movl $hi, %edi
    add $4, %edi
    jmp print_success
    .byte 0
space:
    .byte 0xA
    .byte 0
print_success:
    push %edi
    call printf
    pop %edi
    movl $space, %edi
    push %edi
    call puts
    pop %edi
    ret

error:
    .string  "error! \n"

main:
    movl $future_param, %edi
    push %edi
    call gets
    pop %edi
    movl $hello, %esi
    mov $0, %ebp
    call  cmp_str1
    cmp $0, %eax
    je  prepare
print_error:
    movl $error, %edi
    push %edi
    call printf
    pop  %edi
    jmp main

prepare:
    add $1, %esi
    call *%esi
    jmp main
adress:
    mov %esi, %ecx
    add $4, %esi
    inc %ebp
    jmp cmp_str2

cmp_str1:
    xor %ebx, %ebx
    mov (%edi), %al
    cmp $0, %al
    jne cmp_str2
    inc %ebx
cmp_str2:
    cmp $0, %ebp
    je adress
    mov (%esi), %dl
    cmp $0, %dl
    inc %ebx
    cmp $2, %ebx
    je out_success
search:
    cmp %dl, %al
    je inc_str
    movl $future_param, %edi
    xor %ebp, %ebp
    mov (%ecx), %ecx
    cmp $0, %ecx
    je out_error
    xor %ebx, %ebx
    mov %ecx, %esi
    jmp cmp_str1
inc_str:
    inc  %esi
    inc  %edi
    jmp cmp_str1
out_success:
    xor %eax, %eax
    ret
out_error:
    xor %eax, %eax
    mov $2, %eax
    ret

    .data
future_param:
    .rept 20
    .byte 0
    .endr
