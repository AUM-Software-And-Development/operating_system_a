bits 16
	jmp BootloaderStart ; Increment the ip to pass the include code
	
%include "Headers\Addresses.asm"
%include "Headers\BIOSDefines.asm"
%include "ASM Includes\Int19.asm"

BootFail: db 0xa, 0xd, "For some reason, the bootloader didn't jump.", 255

BootloaderStart:
	mov ax, BootAddress
	mov ds, ax
	mov [BootDrive], dl
	call Sector1Load0x7c0 ; If for whatever reason this isn't in the boot address...
	jmp BootAddress:Boot

Boot:
	call Sector2Loadbb8
	jmp 0:KernelAddress

.bootFailure:

	mov si, BootFail
	call Int16

	cli
	hlt

times 510-($-$$) db 0
dw 0xaa55