@echo off

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

if %LASTVER1% NEQ %EXEVER1% (
	goto :test1
) ELSE (
	if %LASTVER2% NEQ %EXEVER2% (
		goto :test2
	) ELSE (
		if %LASTVER3% NEQ %EXEVER3% (
			goto :test3
		) ELSE (
			if %LASTVER4% NEQ %EXEVER4% (
				goto :test4
			)
		)
	)
)
goto :skip2

:test1
if %LASTVER1% GTR %EXEVER1% (goto :install) ELSE goto :skip2
                                                          
:test2                                                    
if %LASTVER2% GTR %EXEVER2% (goto :install) ELSE goto :skip2
                                                          
:test3                                                    
if %LASTVER3% GTR %EXEVER3% (goto :install) ELSE goto :skip2
                                                          
:test4                                                    
if %LASTVER4% GTR %EXEVER4% (goto :install) ELSE goto :skip2

:skip2
echo Installed version is newer than available installer.
goto :eof

:skip
echo Latest version is already installed. Skipping update.
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
:: Send email about new installed version (optional, in default enabled)
powershell -command .\SendMail.ps1
:: Delete installer package (optional, in default enabled)
del /F /Q "%DOWNROOT%\%LASTVERSETUP%" 

:eof
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

