=============
Windows only:
=============

Step 1:
	Install the NASM assembly compiler from https://www.nasm.us/

Step 2:
	Install CLang from https://www.msys2.org/

Step 3:
	Install an emulator like Bochs, QEMU, VirtualBox

Step 4:
	Run the build.bat file.

Step 5:
	Run the output binary as a floppy in your desired emulator.

====================
Windows & or Ubuntu:
====================
Windows-Docker build:

Step 1:
	Install Docker using https://docker.com
	Install an emulator like Bochs, QEMU, VirtualBox

Step 2:
	Write your own, or copy the "dockerfile" file within this folder

Step 3:
	Send the powershell this command->: "docker build ./ -t 'CHOSEACONTAINERNAMEANDPUTITHERE'"

	*The -t flag will instruct Docker to name the build whichever string you give it,
	and it does not require the quotation marks.

Step 4:
	Send the powershell this command->: 'docker run -it -v "${pwd}:/root/env" --rm 'YOURCONTAINERNAMEGOESHERE''

	*The -it flag will instruct Docker to allocate a TTY connected to the containers IO.
	This allows a shell for scripting access to the container root.

	*The -v flag mounts a volume that allows filesharing between Windows and the Unix folders.

	*The --rm flag will instruct Docker to remove/close the container when the shell exits.

	*The enclosed quotation marks are required on this one. The only thing needed to change,
	is the container name. Windows will supplant the password on its own.

==================================
Ubuntu (or Docker image/WSL) only:
==================================
		(This part is done by the Dockerfile automatically if you're on Windows.)
		sudo apt-get update
		sudo apt-get upgrade -y
		sudo apt-get install -y make
		sudo apt-get install -y nasm
		sudo apt-get install -y clang

Step 5:
	Send the command "make" in the running Ubuntu container/from the development directory.

Step 6:
	Run the output binary as a floppy in your desired emulator.
	The rest is up to you.


Keep in mind that software developers are known to change things without notice. If any of these
commands fail, it means the method was updated by the company, or a command was entered wrong.



Good luck!

Cheers,
Eric
