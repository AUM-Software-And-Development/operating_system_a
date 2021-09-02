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

MakeNewLines:

    pusha

    xor cx, cx
    mov ah, 0x0e

.spacesLoop:

    cmp cx, dx
    je .exit
    mov al, 0xa
    int 16
    mov al, 0xd
    int 16
    inc cx
    jmp .spacesLoop

.exit:

    popa
    
    ret

TurnOnTextMode:

    pusha

    mov ax, 0x0b00
    mov bx, 0x0003
    int 16

    popa

    ret

ClearVideo:

    pusha
    
    mov ax, 0x0003
    int 16

    popa
    ret