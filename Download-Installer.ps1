##############################################################################
# A helper PowerShell script for obtaining a new version download link
##############################################################################


############################## Settings ######################################
# Check and set everything in this settings section according to your needs

# If token is empty or doesn't work, Public channel version will be fetched
# Token settings
$token = "PUT-YOUR-PLEXPASS-TOKEN-HERE"

# Download folder settings, set it to the same path as you did for "DOWNROOT" in main PlexUpdate4Win.cmd
$DownloadFolder = "<PATH TO>\PlexUpdate4Win\packages"


############################### Main Script ##################################
# Usually you don't need to change anything below here

# Fetching info from JSON file and download package
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

$url = "https://plex.tv/api/downloads/1.json?channel=plexpass"
$headers = @{}
$headers.Add("X-Plex-Token","$token") | Out-Null 
$res = Invoke-RestMethod -Headers:$headers -Method Get -Uri:$url -ContentType 'application/json'
$version = $res.computer.Windows.version
$package = $res.computer.Windows.releases.url
echo "Downloading Installer..."
if(!(Test-Path -Path $DownloadFolder )){
    New-Item -ErrorAction Ignore -ItemType directory -Path $DownloadFolder
}
Invoke-RestMethod -Headers:$headers -Method Get -Uri:$package -OutFile "$DownloadFolder\Plex-Media-Server-$version.exe"
echo Done.

##############################################################################

