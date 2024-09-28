# Post-Installation Script: setup.ps1

# Ensure the script runs with administrator privileges
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Create a log file
$LogFile = "$env:SystemDrive\setup\post_install_log.txt"

Function Write-Log {
    Param ([string]$Message)
    $Timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
    "$Timestamp - $Message" | Out-File -FilePath $LogFile -Append
}

Write-Log "Starting Post-Installation Script."

# Set Execution Policy
Set-ExecutionPolicy Bypass -Scope Process -Force

# Update PowerShellGet and NuGet
Write-Log "Updating PowerShellGet and NuGet provider..."
Install-PackageProvider -Name NuGet -Force
Update-Module PowerShellGet

# Debloat Windows
Write-Log "Debloating Windows..."

# List of apps to keep
$appsToKeep = @(
    "Microsoft.MicrosoftEdge.Stable",
    "Microsoft.WindowsTerminal"
)

# Remove provisioned app packages
Get-AppxProvisionedPackage -Online | Where-Object { $appsToKeep -notcontains $_.DisplayName } | Remove-AppxProvisionedPackage -Online

# Remove installed app packages for all users
Get-AppxPackage -AllUsers | Where-Object { $appsToKeep -notcontains $_.Name } | Remove-AppxPackage -AllUsers

# Disable telemetry and unnecessary services
Write-Log "Disabling telemetry and unnecessary services..."
# Disable DiagTrack Service
Stop-Service diagtrack -ErrorAction SilentlyContinue
Set-Service diagtrack -StartupType Disabled

# Disable Compatibility Telemetry
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0

# Install Chocolatey
Write-Log "Installing Chocolatey..."
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install applications using Chocolatey
Write-Log "Installing applications via Chocolatey..."
choco install -y teracopy copyq vim obs-studio tabby hwinfo uniget

# Install applications using Winget
Write-Log "Installing applications via Winget..."
winget install --id Microsoft.VisualStudioCode -e
winget install --id Notepad++.Notepad++ -e
winget install --id Google.Chrome -e
winget install --id Mozilla.Firefox -e
winget install --id Canonical.Ubuntu -e

# Enable WSL 2 features (already enabled during installation)
Write-Log "Ensuring WSL 2 is enabled..."
wsl --set-default-version 2

# Apply system configurations
Write-Log "Applying system configurations..."

# Enable dark mode
Write-Log "Enabling dark mode..."
New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -PropertyType DWord -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -PropertyType DWord -Force

# Set power plan to Ultimate Performance
Write-Log "Setting power plan to Ultimate Performance..."
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

# Set custom wallpaper from Unsplash
Write-Log "Setting custom wallpaper..."
$WallpaperPath = "$env:USERPROFILE\Pictures\wallpaper.jpg"
Invoke-WebRequest -Uri "https://source.unsplash.com/random/1920x1080" -OutFile $WallpaperPath -UseBasicParsing
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
namespace Wallpaper {
    public static class Setter {
        [DllImport("user32.dll", CharSet=CharSet.Auto)]
        private static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
        public static void SetWallpaper(string path) {
            SystemParametersInfo(20, 0, path, 0x01 | 0x02);
        }
    }
}
"@
[Wallpaper.Setter]::SetWallpaper($WallpaperPath)

# Show desktop icons
Write-Log "Showing desktop icons..."
$DesktopIcons = @{
    "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" = 0  # This PC
    "{59031a47-3f72-44a7-89c5-5595fe6b30ee}" = 0  # User's Files
    "{5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0}" = 0  # Control Panel
}
foreach ($guid in $DesktopIcons.Keys) {
    New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name $guid -Value $DesktopIcons[$guid] -PropertyType DWORD -Force
}

# Adjust taskbar settings
Write-Log "Adjusting taskbar settings..."
# Align taskbar to the left
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -Value 0 -PropertyType DWord -Force
# Use small taskbar buttons
New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSi" -Value 0 -PropertyType DWord -Force
# Show all notification icons
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Value 0 -Force

# Disable unnecessary services and features
Write-Log "Disabling unnecessary services and features..."
# Additional configurations can be added here

# Restart Explorer to apply changes
Write-Log "Restarting Explorer..."
Stop-Process -Name explorer -Force
Start-Process explorer.exe

Write-Log "Post-Installation Script completed successfully."
