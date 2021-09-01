Int16:

    pusha
    
    mov ah, 0x0e

.videoLoop:
    
    mov al, [si]
    cmp al, 255
    je .exit
    int 16
    inc si
    jmp .videoLoop

.exit:

    popa

    ret