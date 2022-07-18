function change-name {
    Rename-Computer -NewName DC01
    Remove-Item 'C:\stepfile\1.txt'
    Restart-Computer
 }

 powershell.exe -NoProfile -NoLogo -NonInteractive -ExecutionPolicy Bypass -File \\path\to\script.ps1
 if (Test-Path C:\stepfile){
     if (Test-Path C:\stepfile\1.txt){
         change-name
     }
     if (Test-Path C:\stepfile\2.txt){
         
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