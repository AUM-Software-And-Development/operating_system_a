string_default_override: db "Trying to attach sector 1 to bootable address 0x7c0.", 255
string_attach_sector_2: db "Trying to attached sector 2 to 0xbb8.", 255
string_disk_error: db 0xa, 0xd, "The disk read returned an undisclosed error.", 255

int_19_attach_sector1_to_bootable_address:

        Pusha
        Mov si, string_default_override
Call    int_16_output_si

        Mov dl, 0 ; Drive #
        Mov dh, 0 ; Head #

        Mov cl, 1 ; Sector #
        Mov ch, 0 ; Track/cylinder #

        Mov bx, bootable_address
        Mov es, bx ; Segment
        XOR bx, bx ; Segment offset

        Mov ah, 2 ; Read mnemonic
        Mov al, 1 ; Number of sectors to read

        Int 19
        Jc .haltWithError
        Popa
        Ret
    
        .haltWithError:
    
            Mov si, string_disk_error
Call        int_16_output_si  
            Cli
            Hlt

int_19_attach_sector_2_to_kernel_address:

        Pusha
        Mov si, string_attach_sector_2
Call    int_16_output_si

        Mov dl, 0 ; Drive #
        Mov dh, 0 ; Head #

        Mov cl, 2 ; Sector #
        Mov ch, 0 ; Track/cylinder #

        XOR bx, bx
        Mov es, bx ; Segment
        Mov bx, kernel_address ; Segment offset

        Mov ah, 2 ; Read mnemonic
        Mov al, 2 ; Number of sectors to read

        Int 19
        Jc .haltWithError
        Popa
        Ret

        .haltWithError:

            Mov si, string_disk_error
Call        int_16_output_si
            Cli
            Hlt