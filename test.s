	.file	"test.s"
	.text
	.globl	main
	.type	main, @function

hello:
    .int bye
    .string "Hello!"
    .byte 0

bye:
    .int hi
    .string "Bye!"
    .byte 0
hi:
    .string "Hi!"


param:
    .string "Bye!"
error:
    .string  "end \n"
success:
    .string "success! \n"

main:
    movl $param, %edi
    movl $hello, %esi
    mov $0, %ebp
    call  cmp_str1
    cmp $0, %eax
    je  print_success
print_error:
    movl $error, %edi
    push %edi
    call printf
    pop %edi
    jmp main_return
print_success:
    movl $success, %edi
    push %edi
    call printf
    pop %edi
main_return:
    ret
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
    xor %ebp, %ebp
    mov (%ecx), %esi
    jmp cmp_str1
inc_str:
    inc  %esi
    inc  %edi
    jmp cmp_str1
out_success:
    movl $success, %edi
    xor %eax, %eax
    ret
out_error:
    xor %eax, %eax
    mov $2, %eax
    ret
