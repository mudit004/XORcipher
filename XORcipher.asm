;storing standard keywords
SYS_EXIT equ 1 ; in eax
SYS_READ equ 3 ; in eax
SYS_WRITE equ 4 ; in eax
STDIN equ 0 ; in ebx
STDOUT equ 1 ; in ebx

section .data
    msg1 db 'Enter the string: '
    len1 equ $-msg1

    msg2 db 'Enter the key: '
    len2 equ $-msg2

    msg3 db 'The encrypted string is: '
    len3 equ $-msg3


section .bss
    string resb 100
    key resb 1

section     .text
    global_start

_start: 
    ;print message to take input of input string 
    mov eax, SYS_WRITE 
    mov ebx, STDOUT
    mov ecx, msg1 
    mov edx, len1 
    int 0x80 

    ;take input from user of the string to be encrypted
    mov eax, SYS_READ 
    mov ebx, STDIN
    mov ecx, string 
    mov edx, 100
    int 0x80 

    ;print message to take input of key character to xorred with
    mov eax, SYS_WRITE 
    mov ebx, STDOUT
    mov ecx, msg2
    mov edx, len2
    int 0x80 

    ;take input from user of the character
    mov eax, SYS_READ 
    mov ebx, STDIN
    mov ecx, key 
    mov edx, 1 
    int 0x80 


    ;encryption process

    mov esi, string
    mov edi, key

loop:
    mov dl, byte [esi]  
    xor dl, byte [edi]
    mov byte [esi], dl
    inc esi
    cmp byte [esi+1], 0
    jne loop
    
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, msg3
    mov edx, len3
    int 0x80

    mov eax, SYS_WRITE
    mov ebx, STDOUT
    mov ecx, string
    mov edx, 100
    int 0x80


exit:
    mov eax, 1
    int 0x80