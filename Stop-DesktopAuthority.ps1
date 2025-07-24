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

$logfile = "$logfolder\Stop-DesktopAuthority.log"

Start-Transcript -Path $logfile

Write-Host "`n`n   Script is being run as the user shown below"
whoami /user

Write-Host "`n`nStarting to STOP Desktop Authority on computer $env:computername `n"

Set-Service -Name "DACBMSvc" -StartupType Disabled
if ($?) { Write-host "Service Disabled successfully.`n"
    } else {
    Write-Host "Failed to Disable service.`n"
    }

Stop-Service -Name "DACBMSvc"
if ($?) { Write-host "Service successfully stopped.`n"
    } else {
    Write-Host "Failed to stop service.`n"
    }


Set-Service -Name "DAClientSvc" -StartupType Disabled
if ($?) { Write-host "Service Disabled successfully.`n"
    } else {
    Write-Host "Failed to Disable service.`n"
    }

Stop-Service -Name "DAClientSvc"
if ($?) { Write-host "Service successfully stopped.`n"
    } else {
    Write-Host "Failed to stop service.`n"
    }

Write-Host "`n`nEnding STOP Desktop Authority on computer $env:computername `n"

$dateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "Ending script at $dateTime `n"

Stop-Transcript