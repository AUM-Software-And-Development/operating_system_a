bits 16
jmp 0x7c0:Boot

Boot:
	mov ax, 0x0e81
	int 0x10
	cli
	hlt

times 510-($-$$) db 0
dw 0xaa55
