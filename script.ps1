function change-name {
    Rename-Computer -NewName DC01
    Remove-Item 'C:\stepfile\1.txt'
    Restart-Computer
 }
 
 function install-ad {
     "Installing AD-Domain-Services"
     Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
     "Install complete"
     Remove-Item 'C:\stepfile\2.txt'
 }
 
 function create-domain {
     "Converting secure password"
     #$Secure = ConvertTo-SecureString "SMAdminPassw0rd" -AsPlainText -Force
     "Creating domain"
     #Install-ADDSForest -DomainName "testdomain.local" -DomainNetBiosName "testdomain" -SafeModeAdministratorPassword $Secure -InstallDns:$true -NoRebootOnCompletion:$true -Force
     "Domain Creation Complete"
     Remove-Item 'C:\stepfile\3.txt'
 }

 function create-user {
    Import-Module activedirectory
    New-ADUser -SamAccountName "automate" -Name "Domain Automate" -GivenName "Domain" -Surname "Automate" -UserPrincipalName "automate@testdomain.local" -AccountPassword(ConvertTo-SecureString "Autom@te1" -AsPlainText -Force) -Enabled $true
    Remove-Item 'C:\stepfile\5.txt'
}

 function promote-user {
    Add-ADGroupMember -Identity "Domain Admins" -Members dautomate
    Add-ADGroupMember -Identity "Administrators" -Members dautomate
    Remove-Item 'C:\stepfile\6.txt'
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