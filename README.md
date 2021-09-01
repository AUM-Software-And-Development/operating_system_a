=============
Windows only:
=============

Step 1:
	Install the NASM assembly compiler from https://www.nasm.us/

Step 2:
	Install CLang from https://www.msys2.org/

Step 3:
	Install an emulator aka Bochs, QEMU, VirtualBox

Step 4:
	Run the build.bat file.

Step 5:
	Run the output binary as a 1.2 inch floppy in your chosen emulator.

====================
Windows & or Ubuntu:
====================
Windows / Docker with Ubuntu build:

Step 1:
	Install Docker using https://docker.com
	Install an emulator aka Bochs, QEMU, VirtualBox

Step 2:
	Write a dockerfile, or copy the "dockerfile" file within this folder

Step 3:
	Send the Windows powershell this command->: "docker build ./ -t 'PUTYOUROWNCONTAINERNAMEHERE'"

	*The -t flag will instruct Docker to name the build whichever string you give it.
	The container name does not require the quotation marks.

Step 4:
	Send the Windows powershell this command->: 'docker run -it -v "${pwd}:/root/env" --rm 'PUTYOUROWNCONTAINERNAMEHERE''

	*The enclosed quotation marks are required on this one. Your password will be supplanted into the brackets on its own.

	*The -it flag will instruct Docker to mimic a "TTY stream" to connect the containers IO.
	This allows a shell for scripting access at the container root privilege.

	*The -v flag mounts a volume allowing filesharing between Windows and the container folders.

	*The --rm flag will instruct Docker to remove/close the container when the "TTY" communication ends.

==================================
Ubuntu or Docker image/WSL only:
==================================
		If you aren't on Windows, you'll have to install the required compiler tools using the following commands:
		(These terminal instructions are run by the Dockerfile automatically if you're on Windows and using the Dockerfile I've provided.)
		sudo apt-get update
		sudo apt-get upgrade -y
		sudo apt-get install -y make
		sudo apt-get install -y nasm
		sudo apt-get install -y clang

Step 5:
	Send the command "make" in the running Ubuntu container/from the development directory.
	Please be aware that I do not update the makefile as often as the batchfile, because I prefer to use Windows as a native build environment.

Step 6:
	Run the output binary as a floppy in your desired emulator.
	The rest is up to you.



Remember that software developers are pretty notorious for changing things without notice. If any of these
commands happen to fail, it indicates that the method was updated by the company/source developer, or that a command was entered wrong.

Good luck,

Cheers!
Eric
