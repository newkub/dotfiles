#!/usr/bin/env pwsh
# Chezmoi Daily Update - รันทุกวันเวลา 21:00 (ไม่มี delay)

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "[$timestamp] Starting chezmoi re-add..."

try {
    & chezmoi re-add
    Write-Host "[$timestamp] Chezmoi re-add completed successfully"
    
    # Show Windows notification on success using Wscript.Shell
    $wshell = New-Object -ComObject Wscript.Shell
    $wshell.Popup("Chezmoi re-add completed successfully at $(Get-Date -Format 'HH:mm:ss')", 0, "Chezmoi Daily Update", 0x40)
} catch {
    Write-Error "Failed to run chezmoi re-add: $_"
    
    # Show Windows notification on error using Wscript.Shell
    $wshell = New-Object -ComObject Wscript.Shell
    $wshell.Popup("Failed: $_", 0, "Chezmoi Daily Update", 0x10)
    
    exit 1
}
