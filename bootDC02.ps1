function change-name {
    Write-Output "$(Get-Date) change-name called" | Out-file C:\log.txt -append
    Rename-Computer -NewName DC02
    Remove-Item 'C:\stepfile\1.txt'
    Restart-Computer
 }
 
 function install-ad {
    Write-Output "$(Get-Date) install-ad called" | Out-file C:\log.txt -append
     "Installing AD-Domain-Services"
     Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
     "Install complete"
     Remove-Item 'C:\stepfile\2.txt'
     Write-Output "$(Get-Date) install-ad complete" | Out-file C:\log.txt -append
 }
 
 function join-domaincontroller {
    Install-ADDSDomainController -DomainName testdomain.local -InstallDns:$true -NoRebootOnCompletion:$true -Force:$true -SafeModeAdministratorPassword (ConvertTo-SecureString 'LazyAdminPwd123!' -AsPlainText -Force) -Credential (get-credential testdomain\JamieSA) –verbose
 } 

 
 if (Test-Path C:\stepfile){
     if (Test-Path C:\stepfile\1.txt){
         change-name
     }
     if (Test-Path C:\stepfile\2.txt){
         install-ad
     }
     if (Test-Path C:\stepfile\3.txt){
        join-domaincontroller
     }
     if (Test-Path C:\stepfile\4.txt){
        Remove-Item 'C:\stepfile\4.txt'
        Restart-Computer
     }
 }else{
     New-Item -Path 'C:\stepfile' -ItemType Directory
     New-Item 'C:\stepfile\1.txt'
     change-name
 }