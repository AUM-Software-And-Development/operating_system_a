=========
Windows only:
=========

Step 1:

    Install the NASM assembly compiler from https://www.nasm.us/

Step 2:

    Install CLang from https://www.msys2.org/

Step 3:

    Install an emulator aka Bochs, QEMU, VirtualBox

Step 4:

    Run the build.bat file.

Step 5:

    Run the output binary as a 1.2 inch floppy in your emulator.

=========
Windows & or Ubuntu:
=========

Windows / Docker with Ubuntu build:

Step 1:

    Install Docker using https://docker.com

Step 2:

    Install an emulator aka Bochs, QEMU, VirtualBox

Step 3:

    Write a dockerfile, or use the "dockerfile" file within this folder

Step 4:

    Send the Windows powershell this command->: "docker build ./ -t 'YOURCONTAINERNAMEGOESHERE'"

    *The -t flag will instruct Docker to name the build using the string you input as part of the command.
    The container name doesn't require single quotation marks. They are there to denote where the container name goes.

Step 5:

    Send the Windows powershell this command->: 'docker run -it -v "${pwd}:/root/env" --rm 'YOURCONTAINERNAMEGOESHERE''

    *The enclosed double quotation marks are required for this specific command. Your password will be supplanted into the brackets on its own.

    *The -it flag will instruct Docker to mimic a "TTY stream" in order for you to connect to the containers IO and issue commands.
    (it allows a shell for scripting access at the container root privilege.)

    *The -v flag mounts a volume allowing filesharing between Windows and the container folders.

    *The --rm flag will instruct Docker to remove/close the container when the "TTY" communication has halted.

=========
Ubuntu or Docker image/WSL only:
=========

If you aren't on Windows, you'll have to install the required compiler tools using the following commands:

    (These terminal instructions are run by the Dockerfile automatically if you're on Windows and using the Dockerfile that's been provided.)

    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install -y make
    sudo apt-get install -y nasm
    sudo apt-get install -y clang

Step 6:

    Send the command "make" in the operating Ubuntu container/from the development directory.

    I'd like you to know that I don't update the makefile as often as the batchfile, because I prefer to use Windows as a complete build environment.

Step 7:

    Run the output binary as a floppy in your emulator.

    Try to keep in mind that software developers tend to change things without notice. If any of these commands fail, it indicates that a method was updated by the company/source code developer, or that a command was entered in an incompatible format.

Thanks for your focus,

Eric
