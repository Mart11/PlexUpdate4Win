@echo off

:::::::::::::::::::::::::::::: Settings ::::::::::::::::::::::::::::::::::::::
:: Check and set the path according to your environment
set PVR="C:\Program Files (x86)\Plex\Plex Media Server\Plex Tuner Service.exe"

::::::::::::::::::::::::::::: Main Script ::::::::::::::::::::::::::::::::::::
:: Usually you don't need to change anything here

:CHECK
if exist %PVR% (
    goto RENAME
) else (
    goto EXISTS
)

:RENAME
for /F "delims=." %%a in (%PVR%) do move /y %PVR% "%%a.disable" >nul
echo Plex PVR Disabled
goto:eof

:EXISTS
echo Plex PVR Already Disabled.  Skipping
goto:eof

