function change-name {
    Write-Output "$(Get-Date) change-name called" | Out-file C:\log.txt -append
    Rename-Computer -NewName WS02
    Remove-Item 'C:\stepfile\1.txt'
    Restart-Computer -Force
 }
 
 function set-dns {
    Write-Output "$(Get-Date) set-dns Start Sleep" | Out-file C:\log.txt -append
    Start-Sleep -Seconds 60 
    Write-Output "$(Get-Date) set-dns stop sleep" | Out-file C:\log.txt -append
    Write-Output "$(Get-Date) set dns called" | Out-file C:\log.txt -append
    netsh interface ip set dns name="Ethernet" static 192.168.56.4
    Remove-Item 'C:\stepfile\2.txt'
}


 if (Test-Path C:\stepfile){
    Set-ExecutionPolicy Bypass
     if (Test-Path C:\stepfile\1.txt){
        change-name
     }
     if (Test-Path C:\stepfile\2.txt){
         set-dns
     }
     if (Test-Path C:\stepfile\3.txt){
        Set-Location C:/honeyPS
        ./joindomain.ps1
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