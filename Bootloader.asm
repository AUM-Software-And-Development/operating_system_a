bits 16
	mov ax, BootAddress
	mov ds, ax
	jmp BootAddress:Boot ; Increment the ip past the include code

%include "Headers\Addresses.asm"
%include "ASM Includes\Int19.asm"

BootFail: db 0xa, 0xd, "For some reason, the bootloader didn't jump.", 255

Boot:
	call Sector2Loadbb8
	jmp KernelAddress:0
	mov si, BootFail
	call Int16
	cli
	hlt

times 510-($-$$) db 0
dw 0xaa55