@echo off

set PVR="C:\Program Files (x86)\Plex\Plex Media Server\Plex Tuner Service.exe"

:CHECK
if exist %PVR% (
    goto RENAME
) else (
    goto EXISTS
)

:RENAME
move /y %PVR% "C:\Program Files (x86)\Plex\Plex Media Server\Plex Tuner Service.disabled" >nul
echo Plex PVR Disabled
goto:eof

:EXISTS
echo Plex PVR Already Disabled.  Skipping
goto:eof

