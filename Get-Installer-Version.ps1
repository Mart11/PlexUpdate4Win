##############################################################################
# A helper PowerShell script for checking available PMS version on Plex website
##############################################################################

############################## Settings ######################################
# Check and set everything in this settings section according to your needs

# If token is empty or doesn't work, Public channel version will be fetched
$token = "PUT-YOUR-PLEXPASS-TOKEN-HERE"


############################### Main Script ##################################
# Usually you don't need to change anything below here

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

# Fetching info from JSON file
$url = "https://plex.tv/api/downloads/5.json?channel=plexpass"
$headers = @{}
$headers.Add("X-Plex-Token","$token") | Out-Null 
$res = Invoke-RestMethod -Headers:$headers -Method Get -Uri:$url -ContentType 'application/json'
$version = $res.computer.Windows.version
$package = $res.computer.Windows.releases.url
echo "$version"

##############################################################################
