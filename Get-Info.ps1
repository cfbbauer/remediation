param (
    [string]$logfolder
)

$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "Starting script at $dateTime"

if (!$logfolder) {
    $logfolder = "c:\Temp"
    Write-Host "`n`nParameter is null or empty.  Using c:\Temp directory for logfile.`n"

    if (!(Test-Path -Path $logfolder)) {
        New-Item -ItemType Directory -Path $logfolder
        Write-Host "Folder '$logfolder' created successfully.`n"
        } else {
        Write-Host "Folder '$logfolder' already exists.`n"
    }
}

$logfile = "$logfolder\Get-Info.log"

Start-Transcript -Path $logfile

Write-Host "`n`n   Script is being run as the user shown below"
whoami /user

Write-Host "`n`nStarting to gather information on computer $env:computername `n"

Write-Host "`n`nList all services"
Write-Host "------------------------------------------------------"
Get-Service

Write-Host "`n`n`nQuery Registry for installed applications"
Write-Host "------------------------------------------------------------------------------------------------------------------------------------------------------------"
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, Publisher, InstallDate, DisplayVersion | Format-Table –AutoSize

Write-Host "`n`nQueries the registry key that stores information about installed software, specifically focusing on the 64-bit portion of the registry"
Write-Host "------------------------------------------------------------------------------------------------------------------------------------------------------------"
Get-WmiObject -Class Win32_Product | Select-Object Name, Version, Vendor

Write-Host "`n`nEnding the gathering of information on computer $env:computername `n"

$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "Ending script at $dateTime `n"

Stop-Transcript