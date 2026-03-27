param(
    [string]$RepoRoot = ".",
    [string]$JellyfinDataPath = "$env:ProgramData\Jellyfin\Server",
    [string]$JellyfinWebPath = "C:\Program Files\Jellyfin\Server\jellyfin-web",
    [switch]$RestartJellyfin
)

$ErrorActionPreference = "Stop"

$projectPath = Join-Path $RepoRoot "Jellyfin.Plugin.JellyfinAddonsBridge"
$publishPath = Join-Path $projectPath "bin\Release\net9.0\publish"

if (-not (Test-Path $publishPath)) {
    Write-Host "Building bridge plugin..." -ForegroundColor Cyan
    $env:PATH = "C:\Program Files\dotnet;" + $env:PATH
    Push-Location $projectPath
    dotnet publish -c Release
    Pop-Location
}

$pluginTargetPath = Join-Path $JellyfinDataPath "plugins\Jellyfin.Plugin.JellyfinAddonsBridge"
$webModulesTargetPath = Join-Path $JellyfinWebPath "Resources\slider\modules"
$webModulesSourcePath = Join-Path $RepoRoot "Resources\slider\modules"

Write-Host "Installing bridge plugin files to: $pluginTargetPath" -ForegroundColor Green
New-Item -ItemType Directory -Path $pluginTargetPath -Force | Out-Null
Copy-Item -Path (Join-Path $publishPath "*") -Destination $pluginTargetPath -Recurse -Force

Write-Host "Installing addon web modules to: $webModulesTargetPath" -ForegroundColor Green
New-Item -ItemType Directory -Path $webModulesTargetPath -Force | Out-Null
Copy-Item -Path (Join-Path $webModulesSourcePath "*") -Destination $webModulesTargetPath -Recurse -Force

if ($RestartJellyfin) {
    Write-Host "Restarting Jellyfin service..." -ForegroundColor Yellow
    Restart-Service jellyfin -ErrorAction Stop
}

Write-Host "Installation complete." -ForegroundColor Green
Write-Host "Next: ensure the File Transformation plugin is installed and enabled in Jellyfin." -ForegroundColor Cyan
