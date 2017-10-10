@echo off
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: A helper CMD script for running mail PlexUpdate4Win.cmd script with loging
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::: Settings ::::::::::::::::::::::::::::::::::::::
:: Check and set everything in this settings section according to your needs

set LOG="<PATH TO>\PlexUpdate4Win.log"
set MAINSCRIPT="<PATH TO>\PlexUpdate4Win.cmd"

::::::::::::::::::::::::::::: Main Script ::::::::::::::::::::::::::::::::::::
:: Usually you don't need to change anything here

echo %date% %time% >> %LOG%
call %MAINSCRIPT% >> %LOG%
echo. >> %LOG%

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::