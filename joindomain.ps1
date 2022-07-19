$dc = "testdomain.local"
$password = "LazyAdminPwd123!" | ConvertTo-SecureString -asPlainText –Force
$user = "$dc\JamieSA"
$creds = New-Object System.Management.Automation.PSCredential($user,$password)
Add-Computer -DomainName $dc -Credential $creds -Restart -Force -Verbose