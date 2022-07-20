function change-name {
    Write-Output "$(Get-Date) change-name called" | Out-file C:\log.txt -append
    Rename-Computer -NewName DC01
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
 
 function create-domain {
    Write-Output "$(Get-Date) create-domain called" | Out-file C:\log.txt -append
     "Converting secure password"
     $Secure = ConvertTo-SecureString "SMAdminPassw0rd" -AsPlainText -Force
     "Creating domain"
     Install-ADDSForest -DomainName "testdomain.local" -DomainNetBiosName "testdomain" -SafeModeAdministratorPassword $Secure -InstallDns:$true -NoRebootOnCompletion:$true -Force
     "Domain Creation Complete"
     Remove-Item 'C:\stepfile\3.txt'
     Write-Output "$(Get-Date) create-domain complete" | Out-file C:\log.txt -append
 }

 function create-user {
    Write-Output "$(Get-Date) create-user called" | Out-file C:\log.txt -append
    Import-Module activedirectory
    New-ADUser -SamAccountName "automate" -Name "Domain Automate" -GivenName "Domain" -Surname "Automate" -UserPrincipalName "automate@testdomain.local" -AccountPassword(ConvertTo-SecureString "Autom@te1" -AsPlainText -Force) -Enabled $true
    Remove-Item 'C:\stepfile\5.txt'
    Write-Output "$(Get-Date) create-user complete" | Out-file C:\log.txt -append
}

 function promote-user {
    Write-Output "$(Get-Date) promote-user called" | Out-file C:\log.txt -append
    Add-ADGroupMember -Identity "Domain Admins" -Members dautomate
    Add-ADGroupMember -Identity "Administrators" -Members dautomate
    Remove-Item 'C:\stepfile\6.txt'
    Write-Output "$(Get-Date) promote-user complete" | Out-file C:\log.txt -append
 }
 
 if (Test-Path C:\stepfile){
     if (Test-Path C:\stepfile\1.txt){
         change-name
     }
     if (Test-Path C:\stepfile\2.txt){
         install-ad
     }
     if (Test-Path C:\stepfile\3.txt){
        create-domain
     }
     if (Test-Path C:\stepfile\4.txt){
        Remove-Item 'C:\stepfile\4.txt'
        Restart-Computer
     }
 }else{
     New-Item -Path 'C:\stepfile' -ItemType Directory
     New-Item 'C:\stepfile\1.txt'
     New-Item 'C:\stepfile\2.txt'
     New-Item 'C:\stepfile\3.txt'
     New-Item 'C:\stepfile\4.txt'
     change-name
 }