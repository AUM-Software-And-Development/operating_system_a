bits 16
    jmp KernelSetup ; increment the ip to pass the include code

%include "Headers\Addresses.asm"
%include "GlobalDescriptorTable.asm"
%include "ASM Includes\Int16.asm"

Arrived: db "Arrived, 16b.", 255

KernelSetup:

    org KernelAddress
    mov ax, cs
    mov ds, ax

    call ClearVideo
    call TurnOnTextMode
    mov si, Arrived
    call Int16

.enableA20:

    in al, 0x92
    or al, 2
    out 0x92, al

.instantiateAGlobalDescriptorTable:
 
    cli
    lgdt[GDTPointer]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp CodeSegmentGDT:ProtectedMode

bits 32

ProtectedMode:

    mov ax, DataSegmentGDT
    mov ds, ax
    mov ebp, 0x90000
    mov esp, ebp

.kernel:

    mov byte [0x000b8000], 'A'
    mov byte [0x000b8002], 'r'
    mov byte [0x000b8004], 'r'
    mov byte [0x000b8006], 'i'
    mov byte [0x000b8008], 'v'
    mov byte [0x000b800a], 'e'
    mov byte [0x000b800c], 'd'
    mov byte [0x000b800e], ','
    mov byte [0x000b8010], ' '
    mov byte [0x000b8012], '3'
    mov byte [0x000b8014], '2'
    mov byte [0x000b8016], 'b'
    mov byte [0x000b8018], '.'

    cli
    hlt

times 512-($-$$) db 0