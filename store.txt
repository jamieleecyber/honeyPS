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

 create-user
 Remove-Item 'C:\stepfile\5.txt'