Bits 16

        jmp kernel_setup ; Increment the ip to exceed the include code.

string_booted: db "The 16 bit real mode kernel address has been located.", 0xa, 0xa, 0xd, 255
string_options_header:
    db "Use the keys slash, enter ( / ) ( enter ), to enter 32 bit protected mode.", 0xa, 0xd, \
       "Use the keys b, enter ( b ) ( enter ) to print characters in binary.", 255

%Include "headers\addresses.asm"
%Include "bios_interrupts\int_16.asm"
%Include "tools\kernel_input.asm"
%include "tools\displaying_register_values.asm"
%Include "global_descriptor_table.asm"




kernel_setup:

        Org kernel_address

        Mov ax, cs
        Mov ds, ax

Call    int_16_clear_screen
Call    int_16_set_text_mode

        Mov si, string_booted
Call    int_16_output_si
        Mov si, string_options_header
Call    int_16_output_si
        jmp start_interaction

start_interaction:

Call    inherit_keystrokes
Call    find_request

        Cli
        Hlt

; The computer will enter 32 bit mode only if the user requests it.

enable_32_bit_protected_mode:

.enable_a20:

        In al, 0x92
        OR al, 2
        Out 0x92, al

.instantiateAGlobalDescriptorTable:
 
Call    int_16_clear_screen
        Cli
        Lgdt[gdt_pointer]
        Mov eax, cr0
        OR eax, 1
        Mov cr0, eax
            
        Jmp gdt_code_segment:protected_mode

Bits 32

protected_mode:

        Mov ax, gdt_data_segment
        Mov ds, ax
        Mov ebp, 0x90000
        Mov esp, ebp

.kernel:

        Mov byte [0x000b8000], '3'
        Mov byte [0x000b8002], '2'
        Mov byte [0x000b8004], ' '
        Mov byte [0x000b8006], 'b'
        Mov byte [0x000b8008], 'i'
        Mov byte [0x000b800a], 't'
        Mov byte [0x000b800c], ' '
        Mov byte [0x000b800e], 'p'
        Mov byte [0x000b8010], 'r'
        Mov byte [0x000b8012], 'o'
        Mov byte [0x000b8014], 't'
        Mov byte [0x000b8016], 'e'
        Mov byte [0x000b8018], 'c'
        Mov byte [0x000b801a], 't'
        Mov byte [0x000b801c], 'e'
        Mov byte [0x000b801e], 'd'
        Mov byte [0x000b8020], ' '
        Mov byte [0x000b8022], 'm'
        Mov byte [0x000b8024], 'o'
        Mov byte [0x000b8026], 'd'
        Mov byte [0x000b8028], 'e'
        Mov byte [0x000b802a], '.'

        Cli
        Hlt

; Data:

Bits 16




string_rewritable: db 0

Times 1024-($-$$) db 0