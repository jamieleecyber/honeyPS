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
     $Secure = ConvertTo-SecureString "SMAdminPassw0rd" -AsPlainText -Force
     "Creating domain"
     Install-ADDSForest -DomainName "testdomain.local" -DomainNetBiosName "testdomain" -SafeModeAdministratorPassword $Secure -InstallDns:$true -NoRebootOnCompletion:$true -Force
     "Domain Creation Complete"
     Remove-Item 'C:\stepfile\3.txt'
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
         Restart-Computer
         Remove-Item 'C:\stepfile\4.txt'
     }
     if (Test-Path C:\stepfile\5.txt){
        New-ADUser -Name "Domain Automate" -GivenName "Domain" -Surname "Automate" -SamAccountName "dautomate" -UserPrincipalName "dautomate@testdomain.local" -AccountPassword(Convert-ToSecureString "Autom@te1" -AsPlainText -force) -Enabled $true
        Remove-Item 'C:\stepfile\5.txt'
    }
 }else{
     New-Item -Path 'C:\stepfile' -ItemType Directory
     New-Item 'C:\stepfile\1.txt'
     New-Item 'C:\stepfile\2.txt'
     New-Item 'C:\stepfile\3.txt'
     New-Item 'C:\stepfile\4.txt'
     New-Item 'C:\stepfile\5.txt'
     change-name
 }