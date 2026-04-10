#!/usr/bin/env pwsh
# Chezmoi Daily Update - รันทุกวันเวลา 21:00 (ไม่มี delay)

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "[$timestamp] Starting chezmoi re-add..."

try {
    & chezmoi re-add
    Write-Host "[$timestamp] Chezmoi re-add completed successfully"
} catch {
    Write-Error "Failed to run chezmoi re-add: $_"
    exit 1
}
