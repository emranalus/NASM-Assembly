; Opcodes
SYS_WRITE   equ     1
STDOUT      equ     1
SYS_EXIT    equ     60
EXIT_CODE   equ     0

; ınitialised variables
section .data
hello       db      "Hello Cruel World!", 10, 0
hello_len   equ     $-hello

; Macros
%macro print 1
    
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    mov rsi, hello
    mov rdx, hello_len
    syscall

%endmacro

%macro exit 0

    mov rax, SYS_EXIT
    mov rdi, EXIT_CODE
    syscall

%endmacro

%macro repeatPrint 2
    
    push %2             ; Push number of iterations into stack
    
    _loop:
        print %1
        pop rcx         ; Pop number of iteration from stack
        sub rcx, 1      ; Subtract 1 from number of iteration
        push rcx        ; Push the new value to the stack
        cmp rcx, 0      ; Compare iter_num to 0
        jg _loop        ; If greater than 0 jump to _loop

%endmacro

section .text
    global _start

; Main code
_start:

    repeatPrint hello, 4
    exit
        

