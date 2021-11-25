====
Windows (only):
====

Step 1:

    Install the NASM assembly compiler from https://www.nasm.us/

Step 2:

    Install CLang from https://www.msys2.org/

Step 3:

    Install an emulator like Bochs, QEMU, or VirtualBox

Step 4:

    Start the Build.bat file.

Step 5:

    The batch file is set up to allow the programmer to use a file I included called "bochsrc.bxrc". Pressing e after starting the
    batch, and then hitting enter will automatically run a Bochs emulator with the file outputs from the build process. Bochs must first
    be installed on the computer in order for the source file to work.

====
Windows & or Ubuntu:
====

Windows / Docker with Ubuntu build:

Step 1:

    Install Docker using https://docker.com

Step 2:

    Install an emulator like Bochs, QEMU, or VirtualBox

Step 3:

    Send the Windows powershell this command: "docker build ./ -t 'containername'"

    *The -t flag instructs Docker to name the build using the string that gets input, as part of the command.
    The container name doesn't require single quotation marks. They are there to show where the container name goes.

Step 4:

    Send the Windows powershell this command: 'docker run -it -v "${pwd}:/root/env" --rm 'containername''

    *The enclosed double quotation marks are required for this command. ${pwd} will place your current directory in the Linux/container path.

    *The -it flag instructs Docker to mimic a "TTY stream" that connects to the containers IO (In Out) and allows issuing commands.
    (it allows a shell for scripting access using the container super users.)

    *The -v flag mounts a volume allowing filesharing between Windows and container folders.

    *The --rm flag instructs Docker to remove/close the container when the "TTY" communication has ended.

    Go to Step 5 in Ubuntu/Docker images.

====
Ubuntu or Docker image/WSL (only):
====

If not on Windows, install the required compiler tools by issuing the following terminal instructions:

    (These terminal instructions are run by the Dockerfile automatically if you're on Windows and using the Dockerfile provided.)

    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y clang
    sudo apt-get install -y make
    sudo apt-get install -y nasm

Step 5:

    Send the command "make" in the operating Ubuntu container/from the development directory.

    As of 11/24/2021, I don't update the Linux makefile, since I use Windows now. There's no estimated date which I might updated it.

Step 6:

    Execute the output in "operating_system\booting\operating_system.bin" binary as a 1.2 inch floppy in your emulator.

    Software developers tend to remake things without notice. If any of commands fail, it indicates a method has been updated by the company or source code developer, or that a command was entered incorrectly.

Thanks for reading,

Eric
