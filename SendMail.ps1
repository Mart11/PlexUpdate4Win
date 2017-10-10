##############################################################################
# A helper PowerShell script for sending a notification about installed update
##############################################################################

############################## Settings ######################################
# Check and set everything in this settings section according to your needs

# Gmail account password
$yourpassword = "PUT-YOUR-PASSWORD-HERE"
# From field is used also as a login to Gmail
$From = "user@domain.tld"
$To = "user@domain.tld"
$Subject = "New PMS version installed"
$Body = @"
A new PMS version $env:LASTVER was installed!

Your Plex @ $env:COMPUTERNAME
"@
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"

# Optional variables to set for CC and/or attachment:
# $Cc = "user@domain.tld"
# $Attachment = "C:\temp\Some random file.txt"

############################### Main Script ##################################
# Usually you don't need to change anything below here

$secpasswd = ConvertTo-SecureString "$yourpassword" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential($from, $secpasswd)

Send-MailMessage -To $To -From $From -Subject $Subject -Body $Body -Credential $mycreds -SmtpServer $SMTPServer -port $SMTPPort -UseSsl -DeliveryNotificationOption Never -BodyAsHtml

# Optional parameters for Send-MailMessage command for using a CarbonCopy (cc) and/or an Attachment:
# -Cc $Cc
# -Attachments $Attachment

##############################################################################

