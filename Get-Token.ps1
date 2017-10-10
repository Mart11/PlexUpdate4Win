##############################################################################
# A stand-alone helper PowerShell script for obtaining a PlexPass Token.
# Needed for PlexPass versions (PlexPass users only).
# PlexPass users should use/run this before everything, as a first step
# during the initial preparation/settings. Usually one-time only needed/used. 
# Fetched Token will be writen to the log file, from where you can use it.
##############################################################################

############################## Settings ######################################
# Check and set everything in this settings section according to your needs

# PlexPass credencials settings
$myplexaccount = "LOGIN"
$mypassword = "PASSWORD"

# Log file for output - after copying the token to the settings of another PowerShell scripts, you can delete it
$TokenLog = "<PATH TO>\PlexUpdate4Win\Get-Token.log"

############################### Main Script ##################################
# Usually you don't need to change anything below here

# Fetching Token
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

$url = "https://plex.tv/users/sign_in.xml"
$BB = [System.Text.Encoding]::UTF8.GetBytes(""$myplexaccount":"$mypassword"")
$EncodedPassword = [System.Convert]::ToBase64String($BB)
$headers = @{}
$headers.Add("Authorization","Basic $($EncodedPassword)") | out-null
$headers.Add("X-Plex-Client-Identifier","PLEXUPDATE4WIN") | Out-Null
$headers.Add("X-Plex-Product","PlexUpdate4Win script") | Out-Null
$headers.Add("X-Plex-Version","V1") | Out-Null
[xml]$res = Invoke-RestMethod -Headers:$headers -Method Post -Uri:$url
$token = $res.user.authenticationtoken
echo $token >> $TokenLog

##############################################################################

