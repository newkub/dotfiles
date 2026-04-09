#!/usr/bin/env pwsh
# Chezmoi Daily Update - รันทุกวันเวลา 21:00 (ไม่มี delay)

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Write-Host "[$timestamp] Starting chezmoi re-add..."

try {
    & chezmoi re-add
    Write-Host "[$timestamp] Chezmoi re-add completed successfully"
    
    # Show Windows notification on success
    Add-Type -AssemblyName Windows.UI.Notifications
    $toastXml = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)
    $toastXml.GetElementsByTagName("text")[0].InnerText = "Chezmoi Daily Update"
    $toastXml.GetElementsByTagName("text")[1].InnerText = "Completed successfully at $(Get-Date -Format 'HH:mm:ss')"
    $toast = [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime]::new($toastXml)
    $notifier = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]::CreateToastNotifier("Chezmoi")
    $notifier.Show($toast)
} catch {
    Write-Error "Failed to run chezmoi re-add: $_"
    
    # Show Windows notification on error
    Add-Type -AssemblyName Windows.UI.Notifications
    $toastXml = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)
    $toastXml.GetElementsByTagName("text")[0].InnerText = "Chezmoi Daily Update"
    $toastXml.GetElementsByTagName("text")[1].InnerText = "Failed: $_"
    $toast = [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime]::new($toastXml)
    $notifier = [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]::CreateToastNotifier("Chezmoi")
    $notifier.Show($toast)
    
    exit 1
}
