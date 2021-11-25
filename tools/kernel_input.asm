; Parameter: (si) - Storage string that will overwrite anything it already contains.
inherit_keystrokes:

        Mov dx, 1
Call    int_16_add_blank_rows
        Mov si, string_rewritable

        key_loop:
            
            Mov ax, 0
            Int 22
            Cmp al, 13
            Je .exit
            Mov ah, 14
            Int 16
            Mov [si], al
            Inc si
            Jmp key_loop

            .exit:

                mov byte [si], 255
                Mov dx, 1
Call            int_16_add_blank_rows
                Ret




; Parameter: (si) - String to read instruction routes from.
find_request:

        Mov si, string_rewritable
        Call int_16_output_si
        Mov dx, 1
Call    int_16_add_blank_rows

        Cmp byte [si], '/'
        Je enable_32_bit_protected_mode

        Cmp byte [si], 'b'
        Je put_dx_on_the_display_in_binary
        
        Ret