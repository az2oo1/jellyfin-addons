# Fetch Jellyfin-MonWUI-Plugin Features Script
# This script downloads feature files from the source repository

param(
    [string]$Branch = "main",
    [string]$Owner = "az2oo1",
    [string]$Repo = "Jellyfin-MonWUI-Plugin",
    [string]$TargetDir = "."
)

$BaseUrl = "https://raw.githubusercontent.com/$Owner/$Repo/$Branch"

# Module files to download
$ModuleFiles = @(
    "Resources/slider/modules/profileChooser.js",
    "Resources/slider/modules/hoverTrailerModal.js",
    "Resources/slider/modules/avatarPicker.js",
    "Resources/slider/modules/userAvatar.js",
    "Resources/slider/modules/dicebearSpecificParams.js",
    "Resources/slider/modules/pauseModul.js",
    "Resources/slider/modules/studioHubs.js",
    "Resources/slider/modules/studioHubsUtils.js",
    "Resources/slider/modules/utils.js"
)

# Settings files to download
$SettingsFiles = @(
    "Resources/slider/modules/settings/profileChooserPage.js",
    "Resources/slider/modules/settings/hoverTrailerPage.js",
    "Resources/slider/modules/settings/avatarPage.js",
    "Resources/slider/modules/settings/pausePage.js",
    "Resources/slider/modules/settings/studioHubsPage.js"
)

# Create necessary directories
$ModulesDir = Join-Path $TargetDir "Resources/slider/modules"
$SettingsDir = Join-Path $TargetDir "Resources/slider/modules/settings"

Write-Host "Creating directories..." -ForegroundColor Green
New-Item -ItemType Directory -Force -Path $ModulesDir | Out-Null
New-Item -ItemType Directory -Force -Path $SettingsDir | Out-Null

# Download module files
Write-Host "Downloading module files..." -ForegroundColor Green
foreach ($File in $ModuleFiles) {
    $Url = "$BaseUrl/$File"
    $FileName = Split-Path -Leaf $File
    $OutputPath = Join-Path $ModulesDir $FileName
    
    try {
        Write-Host "  Downloading $FileName..." -ForegroundColor Cyan
        Invoke-WebRequest -Uri $Url -OutFile $OutputPath -ErrorAction Stop
        Write-Host "    ✓ Downloaded successfully" -ForegroundColor Green
    }
    catch {
        Write-Host "    ✗ Failed to download: $_" -ForegroundColor Red
    }
}

# Download settings files
Write-Host "Downloading settings files..." -ForegroundColor Green
foreach ($File in $SettingsFiles) {
    $Url = "$BaseUrl/$File"
    $FileName = Split-Path -Leaf $File
    $OutputPath = Join-Path $SettingsDir $FileName
    
    try {
        Write-Host "  Downloading $FileName..." -ForegroundColor Cyan
        Invoke-WebRequest -Uri $Url -OutFile $OutputPath -ErrorAction Stop
        Write-Host "    ✓ Downloaded successfully" -ForegroundColor Green
    }
    catch {
        Write-Host "    ✗ Failed to download: $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Download complete!" -ForegroundColor Green
Write-Host "Files are now available at: $ModulesDir" -ForegroundColor Cyan
Write-Host "Settings files at: $SettingsDir" -ForegroundColor Cyan
