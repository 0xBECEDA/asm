.text
.globl main
.type   main, @function

a:
    .int 0
    .ascii "a"
    .int b
    .ascii "_."
    .byte 0
b:
    .int a
    .ascii "b"
    .int c
    .ascii "_..."
    .byte 0
c:
    .int b
    .ascii "c"
    .int d
    .ascii "_._."
    .byte 0
d:
    .int c
    .ascii "d"
    .int e
    .ascii "_.."
    .byte 0
e:
    .int d
    .ascii "e"
    .int 0
    .ascii "."
    .byte 0

middle:
    .int c
param:
    .string "abc"
    .byte 0
morze:
    .string "code is %s \n"
    .byte 0
error:
    .string "sorry, nothing's found \n"
    .byte 0
end:
    .string "end of string"
    .byte 0

main:
    movl    $param, %esi
    call    str_src
    ret

outcode:
    push %ecx
    push %eax
    push %edi
    call printf
    pop %edi
    pop %eax
    pop %ecx
    ret
str_src: #              <-----+
    movl    $middle, %ebx   # |     # А здесь можно комментить текстом
    mov     (%esi), %dl     # |
    cmpb    $0, %dl         # |
    je  end_of_str          #-|--+
    cmp     $0, %ebx        # |  |
    je  end_of_str          #-|--+
    mov     $5, %ecx        # |  |
    call search             #-+  |
end_of_str: #            <-------+
    movl $end, %edi
    call outcode
    ret
search:
    mov     (%ebx), %ebp
    mov     %ebp, %ebx
    add     $4,%ebp
    mov     (%ebp), %al
    cmp     %al, %dl
    je  add1
    jnbe bigger
    jnge search
    loop search
    movl    $error, %edi
    call outcode
    jmp search_return
add1:
    add     $5, %ebp
    mov     %ebp, %eax
    movl    $morze, %edi
    call    outcode
    add $1, %esi
    jmp str_src
bigger:
    add     $5, %ebx
    jmp     search
search_return:
    ret
