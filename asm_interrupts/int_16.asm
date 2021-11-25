int_16_output_si:

    Pusha
    Mov ah, 0x0e

    .videoLoop:
    
        Mov al, [si]
        Cmp al, 255
        Je .exit
        Int 16
        Inc si
        Jmp .videoLoop

        .exit:

            Popa
            Ret

; Parameter (dx) - Amount of blank rows to add to the screen
int_16_add_blank_rows:
    
    Pusha
    XOR cx, cx
    Mov ah, 0x0e

    .linesLoop:

        Cmp cx, dx
        Je .exit
        Mov al, 0xa
        Int 16
        Mov al, 0xd
        Int 16
        Inc cx
        Jmp .linesLoop

        .exit:

            Popa
            Ret

int_16_clear_screen:
    
    Pusha
    Mov ax, 0x0003
    Int 16

    Popa
    Ret

int_16_set_text_mode:
    
    Pusha
    Mov ax, 0x0b00
    Mov bx, 0x0004
    Int 16

    Popa
    Ret




; VGA video memory addressing:




; 320 x 200 x 256
; 1 Byte per pixel (00h - ffh)

vga_video_memory_address: dw 0a000h

int_16_connect_vga:

    Pusha
    Mov ax, 0x0013
    Int 16

    Mov ax, [vga_video_memory_address] ; VGA video memory address.
    Mov es, ax

    XOR bx, bx

    Mov ax, 81  ; y.
    Mov cx, 320 ; 1/1 x.
    Mul cx      ; Gets total pixels per y.
    Mov bx, ax  ; Stores the start point (x * y) in the offset register.
       
    Mov cx, 320 ; Sets the distance to travel.
    Add cx, bx  ; Adds the current pixel location to it.

    Mov al, 4   ; Sets the pixel color.

    .pixelLoop:

        cmp bx, cx
        je .exit
        Mov es:[bx], al
        inc bx
        jmp .pixelLoop

        .exit:

            Popa
            Ret