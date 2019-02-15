@echo off
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: A "run-me-first" CMD script for running the whole PlexUpdate4Win with
:: all necessary settings.
:: 
:: Schedule to run this script regularly after all settings were made:
::     1. in this file bellow
::     2. in Download-Installer.ps1 (path for packages, optional PlexPass token)
::     3. in Get-Installer-Version.ps1 (optional PlexPass token)
::     4. in SendMail.ps1 (email settings)
::     5. in DisablePVR.cmd (path to EXE, if disabling is wanted)
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::: Settings ::::::::::::::::::::::::::::::::::::::
:: Check and set everything in this settings section according to your needs

:: Check and Auto-download a new version installer? yes/no
:: If no, manual clicking on "Download new version" via PMS web interface will be needed.
:: If yes, the PlexPass Token needs to be fetched and set in powershell scripts first. Or public channel/installer will be used without the PlexPass Token.
set Auto-download=yes

:: Logging on? (yes:no)
set LOG=yes

:: Disable Plex DVR after updating? (yes:no)
set DVR=yes

:: Path to PMS installation with the main EXE 
set PMSEXE=C:\\Program Files (x86)\\Plex\\Plex Media Server\\Plex Media Server.exe
:: Update patch root folder 
set UPDATEROOT=C:\Users\%username%\AppData\Local\Plex Media Server\Updates
:: Auto-download installer folder (optional, but needed if Auto-download=yes)
:: Set it to the same path as you will set for $DownloadFolder in Download-Installer.ps1
set DOWNROOT=<PATH TO>\PlexUpdate4Win\packages

set LOGFILE="PlexUpdate4Win.log"
set MAINSCRIPT="PlexUpdate4Win-Main.cmd"
set DISABLEPVR="DisablePVR.cmd"

::::::::::::::::::::::::::::: Main Script ::::::::::::::::::::::::::::::::::::
:: Usually you don't need to change anything here

if %LOG%==yes (goto :log) else goto :nolog

:log
echo %date% %time% >> %LOGFILE%
call %MAINSCRIPT% >> %LOGFILE%
if %DVR%==yes (call %DISABLEPVR% >> %LOGFILE%)
echo Finished >> %LOGFILE%
echo. >> %LOGFILE%
goto :eof

:nolog
call %MAINSCRIPT%
if %DVR%==yes (call %DISABLEPVR%)
echo Finished
REM goto eof

:eof
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::