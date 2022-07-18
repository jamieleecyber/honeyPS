function change-name {
    Rename-Computer -NewName WS02
    Remove-Item 'C:\stepfile\1.txt'
    Restart-Computer
}

function set-dns {
    netsh interface ip set dns name="Ethernet" static 192.168.56.4
    Remove-Item 'C:\stepfile\2.txt'
}

function join-domain {
    $dc = "testdomain.local"
    $password = "LazyAdminPwd123!" | ConvertTo-SecureString -asPlainText –Force
    $user = "$dc\JamieSA"
    $creds = New-Object System.Management.Automation.PSCredential($user,$password)
    Start-Sleep -Seconds 120
    Add-Computer -DomainName $dc -Credential $creds -Restart -Force -Verbose
    Remove-Item 'C:\stepfile\3.txt'
}

 if (Test-Path C:\stepfile){
     if (Test-Path C:\stepfile\1.txt){
        change-name
     }
     if (Test-Path C:\stepfile\2.txt){
        set-dns
     }
     if (Test-Path C:\stepfile\3.txt){
        join-domain
     }
     if (Test-Path C:\stepfile\4.txt){
        
     }
 }else{
     New-Item -Path 'C:\stepfile' -ItemType Directory
     New-Item 'C:\stepfile\1.txt'
     New-Item 'C:\stepfile\2.txt'
     New-Item 'C:\stepfile\3.txt'
     New-Item 'C:\stepfile\4.txt'
     change-name
}