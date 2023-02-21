
section .data
        question_name_text db "What is your name?", 10, 0
        input_prompt_text db "> ", 0
        greeting_text db "Hello, "

section .bss
        name resb 16    ; Reserve 16 bytes for variable 'name'

section .text
        global _start

; Get user's name as input then greet them with their name
_start:
        call _printQuestion
        call _getUserData
        call _printGreeting

        ; Exit Programme
        mov rax, 60                     ; Exit command
        mov rdi, 0                      ; Error code: 0
        syscall                         ; Call kernel to execute this function

_printQuestion:
        mov rax, question_name_text
        call _print
        
        ret

; Print greeting then name
_printGreeting:
        mov rax, greeting_text 
        call _print

        mov rax, name
        call _print

        ret                             ; Return

_getUserData:

        mov rax, input_prompt_text
        call _print

        ; Take user input
        mov rax, 0                      ; Input command
        mov rdi, 0                      ; Standart input mode
        mov rsi, name                   ; Where to store
        mov rdx, 16                     ; Length
        syscall                         ; Call kernel to execute this function

        ret                             ; Return

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


