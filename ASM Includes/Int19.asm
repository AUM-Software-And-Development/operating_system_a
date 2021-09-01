%include "ASM Includes\Int16.asm"
AttemptBIOSFlush: db "Attempting to load sector 1 into 0x7c0 just in case...", 255
AttemptRead: db "Attempting to read sector 2 into 0xbb8.", 255
BadRead: db 0xa, 0xd, "The disk read could not connect.", 255

Sector1Load0x7c0:

    pusha

    mov si, AttemptBIOSFlush
    call Int16

    mov dl, 0 ; Drive number to get
    mov dh, 0 ; Head number to use

    mov cl, 1 ; Sector to use
    mov ch, 0 ; Track/cylinder number

    mov bx, BootAddress
    mov es, bx ; Segment to load
    xor bx, bx ; Segment offset to load at

    mov ah, 2 ; Read mnemonic
    mov al, 1 ; Number of sectors to read

    int 19
    jc .haltWithError
    
    popa
    ret

.haltWithError:

    mov si, BadRead
    call Int16
    
    cli
    hlt

Sector2Loadbb8:

    pusha

    mov si, AttemptRead
    call Int16

    mov dl, 0 ; Drive number to get
    mov dh, 0 ; Head number to use

    mov cl, 2 ; Sector to use
    mov ch, 0 ; Track/cylinder number

    mov bx, 0
    mov es, bx ; Segment to load
    mov bx, KernelAddress ; Segment offset to load at

    mov ah, 2 ; Read mnemonic
    mov al, 1 ; Number of sectors to read

    int 19
    jc .haltWithError
    
    popa
    
    ret

.haltWithError:

    mov si, BadRead
    call Int16
    
    cli
    hlt