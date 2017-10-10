# PlexUpdate4Win
by Mart11 (m11)
v1 created in october 2017

This is a set of CMD and helper PowerShell scripts for maintaining updates
for Plex Media Server (PMS) on Windows, running as a service via
PmsService (https://github.com/cjmurph/PmsService/releases)

# Features:
 - New PMS versions:
	- check for new version online (if the auto-download is ON), or on local disk (main feature)
	- auto-download new package if needed (optional, default ON)
	- install new version (main feature)
	- delete installed version package (optional, default ON) 
 - PlexPass version support:
	- Helper script "Get-Token.ps1" for obtaining a PlexPass Token (needed for authentication to the PlexPass update channel). One-time only needed/used usually
	- PlexPass update channel with auto fall-back to the Public update channel
 - Email notification about installed new PMS version

# Installation:
 - Set Execution Policy for PowerShell scripts to "Unrestricted", see https://technet.microsoft.com/en-us/library/ee176961.aspx
 - Copy all PlexUpdate4Win scripts/files to one folder on local disk
 - Edit settings for all scripts according to your needs/local environment (see Settings sections in every script file)
 - Schedule execution of PlexUpdate4Win.cmd, or PlexUpdate4Win-withLOG.cmd according to your needs (usually dayly in the early morning) - with the "Run in (optional)" set to the folder with PlexUpdate4Win in the scheduled job Action

 Enjoy!

# Disclaimer:
Using of this scripts is without any warranty, at your own risk. You should not using it if you don't know what it is/what it does.
These scripts was writen with support of many examples/iformation from the Internet, mainly Microsoft sites and StackOverflow site.
