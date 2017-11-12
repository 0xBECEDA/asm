    .text
    .globl main
    .type   main, @function


a:
    .string "._"
b:
    .string "_..."
c:
    .string "_._."
table:
table_a:
    .ascii "a"
    .int a
table_b:
    .ascii "b"
    .int b
table_c:
    .ascii "c"
    .int c
param:
    .string "abaca"
morze:
    .string "code is %s \n"
error:
    .string "sorry, nothing's found \n"
end:
    .string "end of string"
outcode:
    push %ecx
    push %eax
    push %edi
    call printf
    pop %edi
    pop %eax
    pop %ecx
    ret
main:
    movl $param, %esi
    call loop1
    ret

loop1:
    mov (%esi), %dl
    cmpb $0, %dl
    je outcode2
    movl  $table, %ebx
    mov $3, %ecx
    call loop2
    add $1, %esi
    jmp loop1
outcode2:
    movl $end, %edi
    call outcode
    ret

loop2:
    mov (%ebx), %al
    cmp %al, %dl
    je add1
    add $5, %ebx
    loop loop2
    movl $error, %edi
    call outcode
    jmp loop2_return
add1:
    add $1, %ebx
    mov (%ebx), %eax
    movl $morze, %edi
    call outcode
loop2_return:
    ret
