@echo off
echo - -- --- ---- ------ ---------
echo      Starting the build!      
echo --------- ------ ---- --- -- -

set PATHTO=C:\Application Development\Operating Systems
set "MIGRATE="
set "BACKUP=FALSE"
set "AUTORUN=TRUE"

set BACKUPDIRECTORY="%PATHTO%"\Backup
set TEMPDIRECTORY="%PATHTO%"\TEMPORARY_DELETABLE

:build
echo. && echo Building directories~
if exist "bootable" echo -A directory named bootable already exists. No need to create another.
if not exist "bootable" goto create_directories
goto clear_binaries_then_build_source_files

:create_directories
mkdir bootable
echo "-bootable directory created"

:clear_binaries_then_build_source_files
echo. && echo Clearing binaries ~
echo|set /p="-"
del *.bin /s

:build_source_files
echo. && echo Building source files ~
nasm -f bin bootloader.asm -o bootloader.bin
echo|set /p="-"
move bootloader.bin .\bootable

:check_migrations
echo. && echo Checking migration paths, and settings ~
echo -The current directory is: %CD%
if "%PATHTO%" == "%CD%" echo -Operations are already occurring from the defined directory path.

if not exist "%PATHTO%" set "MIGRATE=%PATHTO%" > NUL

if defined MIGRATE (
	robocopy .\ "%MIGRATE%"
	echo.
	echo A migration directory was created at %MIGRATE%
) else (
	echo.
	echo No migrations were made.
)

if "%BACKUP%" == "TRUE" (
	echo.
	echo _/@\ _/@\ A backup was requested to: %PATHTO%\Backup
	if exist %BACKUPDIRECTORY% (
		robocopy .\ %TEMPDIRECTORY% /NC /NFL /NDL /NJH /NJS /NP /NS
		echo|set /p="-About to replace this folder: "
		rd /S %BACKUPDIRECTORY%
		if exist %BACKUPDIRECTORY% (
			echo -Per your request, no changes were made to the already existing backup directory.
			rd /S /Q %TEMPDIRECTORY%
		)
		if not exist %BACKUPDIRECTORY% (
			echo -Per your request, the last backup has been replaced with the new one.
			move %TEMPDIRECTORY% %BACKUPDIRECTORY%
		)
	)
	if not exist %BACKUPDIRECTORY% (
		robocopy .\ %BACKUPDIRECTORY% /NC /NFL /NDL /NJH /NJS /NP /NS
		echo -A backup was made successfully.
	)
	echo -You can turn off auto backups by editing the batch file.
) else (
	echo.
	echo No backup, or no replacement was commanded.
)

if "%AUTORUN%" == "TRUE" (
	start bochsrc.bxrc
)

:end
pause
exit
