# Installation Guide

This guide will walk you through installing the Jellyfin Addons features into your Jellyfin installation.

## Important: Jellyfin Uses ZIP Packages

Jellyfin plugin repositories install from ZIP download URLs, not directly from source folders.

Use this repository URL in Jellyfin:

https://raw.githubusercontent.com/az2oo1/jellyfin-addons/main/repository.json

That catalog entry installs this ZIP release package:

https://github.com/az2oo1/jellyfin-addons/releases/download/v1.0.0/jellyfin-addons-1.0.0.zip

## Prerequisites

- Jellyfin server running (any recent version)
- Access to Jellyfin web interface
- Administrator or developer access to your Jellyfin setup
- Basic familiarity with file management and terminals
- PowerShell (Windows) or Bash (Linux/Mac)

## Quick Start (Recommended)

### Windows PowerShell

1. Navigate to the repository directory:
```powershell
cd "c:\Users\INTER\OneDrive\المستندات\GitHub\jellyfin-addons"
```

2. Run the fetch script:
```powershell
.\fetch-features.ps1
```

3. Wait for all files to download (you should see "✓ Downloaded successfully" for each file)

### Linux/Mac Bash

1. Navigate to the repository directory:
```bash
cd ~/path/to/jellyfin-addons
```

2. Make the script executable:
```bash
chmod +x fetch-features.sh
```

3. Run the fetch script:
```bash
./fetch-features.sh
```

4. Wait for all files to download

## Manual Installation (Alternative)

If the fetch scripts don't work for you, follow these steps:

### Step 1: Download Files from Source

Visit the source repository: https://github.com/az2oo1/Jellyfin-MonWUI-Plugin

Navigate to: `Resources/slider/modules/`

Download all of these files:

**Core Modules:**
- `profileChooser.js`
- `hoverTrailerModal.js`
- `avatarPicker.js`
- `userAvatar.js`
- `dicebearSpecificParams.js`
- `pauseModul.js`
- `studioHubs.js`
- `studioHubsUtils.js`
- `utils.js`

**Settings Panels:**
- `settings/profileChooserPage.js`
- `settings/hoverTrailerPage.js`
- `settings/avatarPage.js`
- `settings/pausePage.js`
- `settings/studioHubsPage.js`

### Step 2: Place Files in Directory

Create the directory structure if it doesn't exist:
```
Resources/
└── slider/
    └── modules/
        ├── [9 core JavaScript files]
        └── settings/
            └── [5 settings panel files]
```

### Step 3: Copy Files

Place the downloaded files in:
- Core modules in: `Resources/slider/modules/`
- Settings panels in: `Resources/slider/modules/settings/`

## Verify Installation

After running the fetch script or manual installation, verify all files exist:

```powershell
# Windows PowerShell
Get-ChildItem -Path "Resources\slider\modules\" -Recurse -Include "*.js" | Select-Object Name
```

```bash
# Linux/Mac Bash
find Resources/slider/modules -name "*.js" | sort
```

Expected output: 14 JavaScript files (9 core + 5 settings)

## Integration with Jellyfin Web UI

The features in this repository are designed to be integrated into Jellyfin's web UI. Integration depends on your specific setup:

### If Using Jellyfin-MonWUI-Plugin:

1. Copy the `Resources/` directory into your Jellyfin-MonWUI-Plugin installation
2. Restart Jellyfin server
3. Features should appear in settings

### If Using Community Plugins:

Consult your plugin documentation for how to add additional modules

### If Custom Integration:

The modules are ES6 modules that export initialization functions:
- `initProfileChooser()` - Initialize profile chooser
- `setupHoverForAllItems()` - Setup hover trailers
- `initUserProfileAvatarPicker()` - Initialize avatar picker
- `initAvatarSystem()` - Initialize avatar rendering
- `setupPauseScreen()` - Setup age badge display
- `ensureStudioHubsMounted()` - Render studio hubs

Call these functions in your initialization code or startup sequence.

## Configuration

Each feature has a settings panel in Jellyfin:

1. Navigate to Jellyfin Settings
2. Look for plugin settings or feature configuration
3. Each feature has its own section:
   - **Profile Chooser** - Auto-open, token settings
   - **Hover Trailers** - Preview mode, trailer preferences
   - **Avatar** - Style, colors, size options
   - **Age Badge** - Display timing, auto-pause settings
   - **Studio Hubs** - Studio order, library selection, genre hubs

## Troubleshooting

### Script Won't Run (Windows)
If PowerShell gives an execution policy error:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\fetch-features.ps1
```

### Script Won't Run (Linux/Mac)
Ensure script is executable:
```bash
chmod +x fetch-features.sh
./fetch-features.sh
```

### Files Not Downloading
- Check internet connection
- Verify GitHub is accessible
- Try manual download from GitHub
- Check that directory has write permissions

### Features Not Appearing
- Verify all 14 files downloaded successfully
- Clear browser cache
- Restart Jellyfin server
- Check browser console for JavaScript errors
- Verify file permissions (should be readable)

### API Errors
- Verify Jellyfin server is running
- Check that you're logged in with appropriate permissions
- Verify API endpoints are accessible
- Check server logs for errors

## Uninstalling

To remove the features:

1. Delete the `Resources/slider/modules/` directory
2. Clear browser cache
3. Refresh Jellyfin web interface
4. Features will no longer appear

To re-enable: Re-run fetch script or restore files from backup.

## Advanced Configuration

### Server URL Configuration

Features use the configured Jellyfin server URL. Ensure your server's public URL is configured correctly in Jellyfin settings.

### CORS Issues

If cross-origin errors occur:
1. Verify server origin is correct
2. Check CORS settings in Jellyfin
3. For YouTube trailers, ensure youtube-nocookie.com is accessible

### Performance Tuning

Each feature has performance settings:
- Reduce card counts in collections
- Disable hover videos if performance is poor
- Adjust cache TTL values for slower connections
- Limit concurrent API requests

## Support & Documentation

For more information:
- Visit [Jellyfin Documentation](https://docs.jellyfin.org/)
- Check [Jellyfin-MonWUI-Plugin GitHub](https://github.com/az2oo1/Jellyfin-MonWUI-Plugin)
- See [README.md](README.md) for feature overview

## License

All features are licensed under the MIT License. See [LICENSE](LICENSE) file for details.
