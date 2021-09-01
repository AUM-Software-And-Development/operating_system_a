# Right now this is being built natively in Windows, as I no longer use Docker or Linux
# for my OS development projects. I recommend against Linux for this. It seems easier
# at first, but over time you begin to find a lot of flaws in the Ubuntu build process.
# With a little research, Windows can do all of the same things from its shell/prompt.

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
