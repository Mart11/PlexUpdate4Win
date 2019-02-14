@echo off
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: A helper CMD script for running mail PlexUpdate4Win.cmd script with loging
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

:: Update patch root folder 
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