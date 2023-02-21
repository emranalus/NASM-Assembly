;x86_64 Linux Assembly Code
section .data
        ; text is the variable name
        ; db stands for define-byte
        ; string value
        ; 10 means \n which means new line
        text db "Hello World!", 10

section .text
        global _start

_start:
        ; You put rax a kernel operation id and in others the parameters then syscall
        ; sys_write(1, text, 14)
        mov rax, 1      ; rax 1 means print
        mov rdi, 1      ; rdi means output mode
        mov rsi, text   ; rsi means context to print
        mov rdx, 14     ; rdx means length
        syscall         ; We filled a function for kernel to execute now we execute it

        ; Exit Programme
        ; sys_exit(9)
        mov rax, 60     ; rax 60 means exit
        mov rdi, 0      ; rdi 0 means exit code 0
        syscall         ; call kernel to execute the function

