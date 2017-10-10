@echo off
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Tis is a main script, if you want to run it with loging to the file,
:: run a helper script PlexUpdate4Win-withLOG.cmd instead this one
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::::::::::::::::::::: Settings ::::::::::::::::::::::::::::::::::::::
:: Check and set everything in this settings section according to your needs

:: Check and Auto-download a new version installer? yes/no
:: If no, manual clicking on "Download new version" via PMS web interface will be needed.
:: If yes, the PlexPass Token needs to be fetched and set in powershell scripts first. Or public channel/installer will be used without the PlexPass Token.
set Auto-download=yes

:: Update patch root folder 
set PMSEXE=c:\\Program Files (x86)\\Plex\\Plex Media Server\\Plex Media Server.exe
:: Update patch root folder 
set UPDATEROOT=c:\Users\%username%\AppData\Local\Plex Media Server\Updates
:: Auto-download installer folder (optional, but needed if Auto-download=yes)
:: Set it to the same path as you will set for $DownloadFolder in Download-Installer.ps1
set DOWNROOT=<PATH TO>\PlexUpdate4Win\packages


::::::::::::::::::::::::::::: Main Script ::::::::::::::::::::::::::::::::::::
:: Usually you don't need to change anything here

goto :OnlineCheck-%Auto-download%

:OnlineCheck-no
set LASTVER=
for /f "tokens=1 delims=-" %%a in ('dir "%UPDATEROOT%\" /B /D') do set LASTVER=%%a
set LASTVERDIR=
set LASTVERSETUP=
for /f %%a in ('dir "%UPDATEROOT%\" /B /D') do set LASTVERDIR=%%a
set DOWNROOT=%UPDATEROOT%\%LASTVERDIR%\packages
for /f %%a in ('dir "%DOWNROOT%\" /B') do set LASTVERSETUP=%%a
goto :continue

:OnlineCheck-yes
set LASTVER=
set LASTLONGVER=
for /f %%I in ('powershell -command .\Get-Installer-Version.ps1') do set LASTLONGVER=%%I
for /f "tokens=1 delims=-" %%a in ("%LASTLONGVER%") do set LASTVER=%%a
set LASTVERSETUP=Plex-Media-Server-%LASTLONGVER%.exe

:continue
set EXEVER=
FOR /F "tokens=2 delims==" %%a in ('wmic datafile where "name='%PMSEXE%'" get Version /value') do set EXEVER=%%a

echo Latest available installer: %LASTVER%
echo Installed version: %EXEVER%

:: If the last version is same as installed then end the script
if %LASTVER%==%EXEVER% goto :skip

set LASTVER1=
set EXEVER1=
set LASTVER2=
set EXEVER2=
set LASTVER3=
set EXEVER3=
set LASTVER4=
set EXEVER4=
:: Install new version if already installed version is not higher as latest available installer
for /f "tokens=1,2,3,4 delims=." %%a in ("%LASTVER%") do set LASTVER1=%%a & set LASTVER2=%%b & set LASTVER3=%%c & set LASTVER4=%%d
for /f "tokens=1,2,3,4 delims=." %%a in ("%EXEVER%") do set EXEVER1=%%a & set EXEVER2=%%b & set EXEVER3=%%c & set EXEVER4=%%d

if %LASTVER1% GTR %EXEVER1% (
	goto :install
) ELSE (
	if %LASTVER2% GTR %EXEVER2% (
		goto :install
	) ELSE (
		if %LASTVER3% GTR %EXEVER3% (
			goto :install
		) ELSE (
			if %LASTVER4% GTR %EXEVER4% (
				goto :install
			)
		)
	)
)
echo Installed version is newer that available installer.
echo Finished
goto :eof

:skip
echo Latest version is already installed. Skipping update.
echo Finished
goto :eof

:install
goto :down-%Auto-download%
:down-no
:: Installer is downloaded by PMS (or manualy), if Auto-download is turned Off (on top)
goto :continue-install
:down-yes
:: Download Installer, if Auto-download is turned On (on top)
powershell -command .\Download-Installer.ps1
:continue-install
echo Installing newer version: %LASTVER% ...
:: First stop PMS, then run update
taskkill /F /IM "Plex Media Server.exe" /T
"%DOWNROOT%\%LASTVERSETUP%" /install /quiet
echo Finished
:: Send email about new installed version (optional, in default enabled)
powershell -command .\SendMail.ps1
:: Delete installer package (optional, in default enabled)
del /F /Q "%DOWNROOT%\%LASTVERSETUP%" 

:eof

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

