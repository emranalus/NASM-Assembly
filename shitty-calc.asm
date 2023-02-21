;x86 Assembly Code
SYS_EXIT  equ 1
SYS_WRITE equ 4
SYS_READ  equ 3
STDIN     equ 0
STDOUT    equ 1
EXIT_CODE equ 0

res_Size equ 2
num_Size equ 2

segment .data
   msg db "Sonuç = "
   lenMsg equ $-msg

   blank db " ",0xA ,0xD
   lenBlank equ $-blank

   msg1 db "İlk sayı(tek hane giriniz) = "
   lenMsg1 equ $-msg1

   msg2 db "İkinci sayıyı giriniz(toplamı 10 yapmasın) = "
   lenMsg2 equ $-msg2

segment .bss
   num1 resb num_Size
   num2 resb num_Size
   res resb res_Size

segment .text
   global _start

_start:

   ;num1'i kullanıcıdan al
   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, msg1
   mov edx, lenMsg1
   int 80h                    ;Program durdurularak kernel kodu çalıştırmak için çağırılır

   mov eax, SYS_READ
   mov ebx, STDIN
   mov ecx, num1
   mov edx, num_Size
   int 80h

   ;num2'yi kullanıcıdan al
   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, msg2
   mov edx, lenMsg2
   int 80h

   mov eax, SYS_READ
   mov ebx, STDIN
   mov ecx, num2
   mov edx, num_Size
   int 80h

   ; Ekrana msg'ı bastır
   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, msg
   mov edx, lenMsg
   int 80h

   ;num'dan '0' çıkartılarak sayı Decimale dönüştürülür
   mov eax, [num1]
   sub eax, '0'

   mov ebx, [num2]
   sub ebx, '0'

   add eax, ebx  

   ;sayıyı tekrardan eski haline getir(sys_write a koyulabilir) ve eax'i res'e koy
   add eax, '0'
   mov [res], eax
   
   ;Ekrana res'i bastır
   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, res
   mov edx, res_Size
   int 80h

   ;Boşluk bırak ve alt satıra geç
   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, blank
   mov edx, lenBlank
   int 80h

exit:
   mov eax, SYS_EXIT   
   xor ebx, ebx ; 0    
   int 80h
