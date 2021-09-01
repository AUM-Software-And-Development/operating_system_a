@echo off
echo -------------------------
echo    Starting the build!      
echo -------------------------

set PATHTO=C:\Application Development\Operating System
set "MIGRATE="
set "BACKUP=FALSE"

set BACKUPDIRECTORY="%PATHTO%"\Backup
set TEMPDIRECTORY="%PATHTO%"\TEMPORARY_DELETABLE
set BOOTINGDIRECTORY="%PATHTO%"\Booting

:Build

:Check_Migrations

echo. && echo ___ Checking migration paths, and settings
echo The current directory is: %CD%
if "%PATHTO%" == "%CD%" echo Operations are already occurring from the defined directory path.
if not "%PATHTO%" == "%CD%" cd "%PATHTO%" && echo Operations were not occurring from the defined directory path. Navigated there.

if not exist "%PATHTO%" set "MIGRATE=%PATHTO%" > NUL

if defined MIGRATE (

	robocopy /S .\ "%MIGRATE%"
	echo.
	echo A migration directory was created at %MIGRATE%.
	echo This was done to ensure a functional build environment for you to use.
	echo You may delete %CD% if you no longer wish to use it.
	echo All outputs from future builds will be located in the new migration.
	echo If you prefer a custom folder, simply edit the batch file which builds this operating system.
	echo ^^^

) else (

	echo.
	echo No migrations were made.

)

echo. && echo ___ Building directories
if exist %BOOTINGDIRECTORY% echo A directory named bootable already exists. No need to create another.
if not exist %BOOTINGDIRECTORY% goto Create_Directories
goto Clear_Binaries_Then_Build_Source_Files

:Create_Directories

mkdir %BOOTINGDIRECTORY%
echo "Booting directory created"

:Clear_Binaries_Then_Build_Source_Files

echo. && echo ___ Clearing old binaries
del *.bin /s

:Build_Source_Files

echo. && echo ___ Building source files
echo|set /p="->"
nasm -f bin "%PATHTO%"\bootloader.asm -o "%PATHTO%"\bootloader.bin
echo|set /p="Attempted to move the output into the booting directory. Response: "
move "%PATHTO%"\bootloader.bin %BOOTINGDIRECTORY%

if "%BACKUP%" == "TRUE" (

	echo. && echo ___ Backup settings
	echo A backup was requested to: %PATHTO%\Backup

	if not exist %BACKUPDIRECTORY% (

		robocopy .\ %BACKUPDIRECTORY% /NC /NFL /NDL /NJH /NJS /NP /NS
		echo -A backup was made successfully.

	)

	if exist %BACKUPDIRECTORY% (

		robocopy .\ %TEMPDIRECTORY% /NC /NFL /NDL /NJH /NJS /NP /NS
		echo|set /p="About to replace this folder: "
		rd /S %BACKUPDIRECTORY%

		if exist %BACKUPDIRECTORY% (

			echo -Per your request, no changes were made to the pre-existing backup directory.
			rd /S /Q %TEMPDIRECTORY%

		)

		if not exist %BACKUPDIRECTORY% (

			echo -Per your request, the previous backup has been replaced with a new one.
			move %TEMPDIRECTORY% %BACKUPDIRECTORY%

		)
	)

	echo You can turn off auto backups by editing the batch file.

) else (

	echo.
	echo No backup, or no replacement was commanded.

)

:Prompt_And_End

echo.
set /P AUTORUN=Press e to run the emulator now, or any other key to exit: 
if "%AUTORUN%" == "e" (

	cd "%PATHTO%"
	start bochsrc.bxrc

) else (

	exit

)
