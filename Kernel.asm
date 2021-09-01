bits 16
    mov ax, KernelAddress
    mov ds, ax
    jmp KernelAddress:Kernel

%include "Headers\Addresses.asm"
%include "ASM Includes\Int16.asm"

Arrived: db "Arrived at kernel.", 255

Kernel:
    call ClearVideo
    call TurnOnTextMode
    mov si, Arrived
    call Int16
    cli
    hlt

times 512-($-$$) db 0