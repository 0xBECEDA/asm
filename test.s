	.file	"test.s"
	.text
	.globl	main
	.type	main, @function
param:
    .string "Bye! \n"

hello:
    .int bye
    .string "Hello! \n"
    movl $hello, %edi
    add $4, %edi
    jmp print_success
    .byte 0

bye:
    .int hi
    .string "Bye! \n"
    movl $bye, %edi
    add $4, %edi
    jmp print_success
    .byte 0
hi:
    .int 0
    .string "Hi! \n"
    movl $hi, %edi
    add $4, %edi
    jmp print_success
    .byte 0

print_success:
    push %edi
    call printf
    pop %edi
    jmp main_return

error:
    .string  "error! \n"

main:
    movl $param, %edi
    movl $hello, %esi
    mov $0, %ebp
    call  cmp_str1
    cmp $0, %eax
    je  prepare
print_error:
    movl $error, %edi
    push %edi
    call printf
    pop %edi
main_return:
    ret

prepare:
    add $1, %esi
    jmp *%esi
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
    movl $param, %edi
    xor %ebp, %ebp
    mov (%ecx), %ecx
    cmp $0, %ecx
    je out_error
    xor %ebp, %ebp
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
