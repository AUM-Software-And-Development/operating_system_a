all:
	@-make clear
	@mkdir -p bootable
	@make binaries
	@mv operatingsystem.bin bootable
binaries:
	nasm -f bin bootloader.asm -o bootloader.bin
	@cat bootloader.bin > operatingsystem.bin

clear:
	@-rm *.bin
	@-cd bootable && rm *.bin
