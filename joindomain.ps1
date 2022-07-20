Set-ExecutionPolicy -NoProfile -NoLogo -NonInteractive -ExecutionPolicy Bypass -Force
Write-Output "$(Get-Date) joindomain called" | Out-file C:\log.txt -append
Write-Output "$(Get-Date) joindomain Start Sleep" | Out-file C:\log.txt -append
Start-Sleep -Seconds 300 
Write-Output "$(Get-Date) joindomain stop sleep" | Out-file C:\log.txt -append
Write-Output "$(Get-Date) joindomain resumed" | Out-file C:\log.txt -append
$dc = "testdomain.local"
$password = "LazyAdminPwd123!" | ConvertTo-SecureString -asPlainText -Force
$user = "$dc\JamieSA"
$creds = New-Object System.Management.Automation.PSCredential($user,$password)
Remove-Item 'C:\stepfile\3.txt'
Write-Output "$(Get-Date) joindomain restarting now" | Out-file C:\log.txt -append
Add-Computer -DomainName $dc -Credential $creds -Restart -Force -Verbose