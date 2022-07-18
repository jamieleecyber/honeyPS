function change-name {
    Rename-Computer -NewName WS01
    Remove-Item 'C:\stepfile\1.txt'
    Restart-Computer
}

function set-dns {
    netsh interface ip set dns name="Ethernet" static 192.168.56.4
    Remove-Item 'C:\stepfile\2.txt'
}

 if (Test-Path C:\stepfile){
     if (Test-Path C:\stepfile\1.txt){
        change-name
     }
     if (Test-Path C:\stepfile\2.txt){
        set-dns
     }
     if (Test-Path C:\stepfile\3.txt){
        
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