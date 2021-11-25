Bits 16

        Jmp bootloader_setup ; Increments the instruction pointer to pass the included code.

string_boot_error: db 0xa, 0xd, "An undisclosed error occurred.", 255

%Include "headers\addresses.asm"
%Include "headers\hardware_values.asm"
%Include "bios_interrupts\int_16.asm"
%Include "bios_interrupts\int_19.asm"




bootloader_setup:

        Mov ax, bootable_address                       ; Places the header in ax.
        Mov ds, ax                                     ; Moves the header reference to the data segment.
        Mov [boot_drive], dl                           ; Saves the default drive number.
Call    int_19_attach_sector1_to_bootable_address      ; Extra insurance that the bootloader code will be located at the default boot address.
        Jmp bootable_address:boot                      ; Jumps to the boot address.

boot:

Call    int_19_attach_sector_2_to_kernel_address       ; Aligns the kernel code from the drive to the kernel header.
        Jmp 0:kernel_address                           ; Jumps to the kernel address.
	
        .bootFailure:
	
        Mov si, string_boot_error
Call int_16_output_si
        Cli
        Hlt

Times 510-($-$$) db 0
Dw 0xaa55