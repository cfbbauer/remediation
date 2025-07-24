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

Write-Host "`n`n   Starting to gather information on computer $env:computername `n"

Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, Publisher, InstallDate, DisplayVersion | Format-Table –AutoSize

Get-WmiObject -Class Win32_Product | Select-Object Name, Version, Vendor

Get-Service

Write-Host "`n`n   Ending the gathering of information on computer $env:computername `n"

$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "Ending script at $dateTime `n"

Stop-Transcript