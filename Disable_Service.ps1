## Script to disable any Service ##
## D.Wilson October 2020          ##

$ServiceName = "ServiceName"
$Service = Get-Service -Name $ServiceName

## Checks if the service is running and disables it if it is ##
if ($Service.Status -eq "Running"){
    Set-Service -Name $Service -Status Stopped -StartupType Disabled
}

## Variable for scheduled taks argument, triple quoted to wrap the whole thing in quotes ##
$DisableService = """Set-Service -Name $Servicename  -Status Stopped -StartupType Disabled"""

## Create new scheduled task ##
$A = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $DisableService
$T = New-ScheduledTaskTrigger -AtLogOn
$P = New-ScheduledTaskPrincipal -UserId "nt authority\localservice" -RunLevel Highest
$S = New-ScheduledTaskSettingsSet 
$task = New-ScheduledTask -Action $A -Principal $P -Trigger $T -Settings $S

## Register the new task ##
Register-ScheduledTask DisableKillerNetwork -InputObject $task
