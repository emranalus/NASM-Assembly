
section .data
        question_name_text db "What is your name?", 10
        input_prompt_text db "> "
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
        mov rax, 1                      ; Print command
        mov rdi, 1                      ; Set mode: Output
        mov rsi, question_name_text     ; What to print
        mov rdx, 19                     ; Length
        syscall                         ; Call kernel to execute this function
        
        ret                             ; Return

; Print greeting then name
_printGreeting:
        ; Print greeting text
        mov rax, 1                      ; Print command
        mov rdi, 1                      ; Set mode: Output
        mov rsi, greeting_text          ; What to print
        mov rdx, 7                      ; Length
        syscall                         ; Call kernel to execute this function
        
        ; Print name
        mov rax, 1                      ; Print command
        mov rdi, 1                      ; Set mode: Output
        mov rsi, name                   ; What to print
        mov rdx, 16                     ; Length
        syscall                         ; Call kernel to execute this function

        ret                             ; Return

_getUserData:
        ; Print input prompt
        mov rax, 1                      ; Print command
        mov rdi, 1                      ; Set mode: Output
        mov rsi, input_prompt_text      ; What to print
        mov rdx, 2                      ; Length
        syscall                         ; Call kernel to execute this function

        ; Take user input
        mov rax, 0                      ; Input command
        mov rdi, 0                      ; Standart input mode
        mov rsi, name                   ; Where to store
        mov rdx, 16                     ; Length
        syscall                         ; Call kernel to execute this function

        ret                             ; Return


