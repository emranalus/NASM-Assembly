
section .data
        hello_world db "Hello World!", 10, 0

section .text
        global _start

; Kinda like defining a function exit is the name 0 is argument count which is none.
%macro exit 0

        mov rax, 60
        mov rdi, 0
        syscall

%endmacro

; Let's have print function!
%macro print 1

    mov rax, %1
    call _print

%endmacro

_start:
        print hello_world
        exit

_print:
    push rax
    mov rbx, 0
_printLoop:
    inc rax
    inc rbx
    mov cl, [rax]
    cmp cl, 0
    jne _printLoop

    mov rax, 1
    mov rdi, 1
    pop rsi
    mov rdx, rbx
    syscall

    ret



