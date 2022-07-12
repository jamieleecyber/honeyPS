$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument 'C:\script.ps1'
$trigger = New-ScheduledTaskTrigger -AtStartup
$principal = New-ScheduledTaskPrincipal -UserID "$env:USERNAME"  -LogonType S4U -RunLevel Highest
Register-ScheduledTask -TaskName "PowershellBoot" -TaskPath "\" -Action $action -Trigger $trigger -Principal $principal