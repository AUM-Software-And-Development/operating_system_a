put_dx_on_the_display_in_binary:

        Mov si, string_rewritable

        Mov ax, 256
        Mov cx, 2
        Mov bx, 122                           ; Bx has to be used to count otherwise it is overwritten during division
        XOR dx, dx                            ; If dx isn't zero, the division function looses data

        .binaryLoop:

            Cmp ax, 1                         ; ax always starts at 256. If it reaches 1, then there are 8 total (bits) divisions.
            je .exit                          ; If it has 8 bits, then it can exit.

            Mov byte [si], '0'                ; Add a value into the bit slot to ensure it always has a character.

            Div cx                            ; Run the division (always divides by 2)

            Cmp bx, ax                        ; Check if bx is equal to the result, or greater, and if it is, then move on to place a 1 in the bit slot.
            Jge .bitFound
            
            Inc si                            ; If the result was less, then move to the next bit slot, and move on to the next division.
            Jmp .binaryLoop

            .bitFound:

                Mov byte [si], '1'
                Inc si

                sub bx, ax                    ; Since the current value of the number it is checking is higher than the bit limit for the slot, subtract the limit from the number.

                jmp .binaryLoop               ; Move on to check how many bit slots have been counted.

                .exit:

                    Mov byte [si], 255        ; Adds a terminating value to the string, so that the output doesn't go into a forever loop.
                    Mov si, string_rewritable
                    call int_16_output_si
                    ret
            

; 128 64 32 16 8 4 2 1
; 0   1  1  1  1 0 1 0
; 122 58 26 10 2 2 0 0