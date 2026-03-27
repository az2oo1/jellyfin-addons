# Jellyfin Addons

A collection of advanced UI features for Jellyfin media server, extracted from the Jellyfin-MonWUI-Plugin project.

## Features Included

### 1. **Who's Watching?** (Netflix-style Profile Chooser)
- Fast user profile switching with avatar display
- Auto-open functionality with customizable inactivity threshold
- Quick login with token persistence
- Location: `Resources/slider/modules/profileChooser.js` & `settings/profileChooserPage.js`

### 2. **HoverTrailers** (Trailer Preview)
- Display trailers/previews on item hover
- Supports both modal and popup preview modes
- YouTube trailer integration with HLS support
- Location: `Resources/slider/modules/hoverTrailerModal.js` & `settings/hoverTrailerPage.js`

### 3. **Choose Avatar** (Avatar Selection & Generation)
- User avatar customization with two modes:
  - Initials-based avatars
  - Dicebear-generated avatars (635+ styles available)
- Dynamic color assignment
- Avatar caching and auto-refresh
- Location: `Resources/slider/modules/avatarPicker.js`, `userAvatar.js`, & `settings/avatarPage.js`

### 4. **Age Badge** (Maturity Rating Display)
- Displays content maturity badges during playback
- Shows visual warnings for violence, sexual content, and adult themes
- Rating normalization from Jellyfin metadata
- Auto-show with configurable duration and lock time
- Location: `Resources/slider/modules/pauseModul.js` & `settings/pausePage.js`

### 5. **Studio Collections** (Studio Hub Hubs)
- Disney+-style studio-based content collections
- Logo and backdrop loading with hover video support
- Draggable studio ordering in settings
- Genre hubs, director collections, and recommendation rows
- Location: `Resources/slider/modules/studioHubs.js` & `settings/studioHubsPage.js`

## Source Repository

These features are extracted from the official Jellyfin-MonWUI-Plugin:
- **Repository**: https://github.com/az2oo1/Jellyfin-MonWUI-Plugin
- **License**: MIT

## Installation

### Option 1: Jellyfin Repository Link (ZIP-based)

Jellyfin installs plugins from ZIP packages listed in a repository JSON catalog.

Add this repository URL in Jellyfin:

https://raw.githubusercontent.com/az2oo1/jellyfin-addons/main/repository.json

Then install the plugin from Jellyfin Plugins and restart Jellyfin.

This catalog points to the ZIP release asset:

https://github.com/az2oo1/jellyfin-addons/releases/download/v1.0.0/jellyfin-addons-1.0.0.zip

### Option 2: Using the Fetch Script

Run the provided `fetch-features.sh` script to automatically download all feature files from the source repository:

```bash
./fetch-features.sh
```

### Option 3: Manual Download

Download the following files from [Jellyfin-MonWUI-Plugin](https://github.com/az2oo1/Jellyfin-MonWUI-Plugin/tree/main/Resources/slider/modules):

**Core Feature Modules:**
- `profileChooser.js`
- `hoverTrailerModal.js`
- `avatarPicker.js`
- `userAvatar.js`
- `dicebearSpecificParams.js`
- `pauseModul.js`
- `studioHubs.js`
- `studioHubsUtils.js`

**Settings Panels:**
- `settings/profileChooserPage.js`
- `settings/hoverTrailerPage.js`
- `settings/avatarPage.js`
- `settings/pausePage.js`
- `settings/studioHubsPage.js`

**Utilities:**
- `utils.js` (shared utilities for trailers)

Place them in: `Resources/slider/modules/` and `Resources/slider/modules/settings/`

## Directory Structure

```
Resources/
└── slider/
    └── modules/
        ├── profileChooser.js
        ├── hoverTrailerModal.js
        ├── avatarPicker.js
        ├── userAvatar.js
        ├── dicebearSpecificParams.js
        ├── pauseModul.js
        ├── studioHubs.js
        ├── studioHubsUtils.js
        ├── utils.js
        └── settings/
            ├── profileChooserPage.js
            ├── hoverTrailerPage.js
            ├── avatarPage.js
            ├── pausePage.js
            └── studioHubsPage.js
```

## Feature Dependencies

### Cross-Feature Dependencies:
- **profileChooser.js** depends on:
  - `avatarPicker.js` (for avatar selection)
  - `userAvatar.js` (for avatar rendering)

- **hoverTrailerModal.js** depends on:
  - `utils.js` (trailer iframe helpers)
  - `studioHubsUtils.js` (popover functionality)
  - `navigation.js` (positioning)

- **studioHubs.js** depends on:
  - `studioHubsUtils.js` (mini popover preview)
  - `hoverTrailerModal.js` (hover video support)

### Required API Modules (from Jellyfin):
- `config.js` - Configuration management
- `api.js` - Jellyfin API authentication & requests
- `jfUrl.js` - Server URL utilities
- `settings.js` - Settings UI components
- `language/index.js` - Localization support

## Configuration

Each feature is configurable via the settings panel in Jellyfin:
- Enable/disable individual features
- Customize appearance and behavior
- Adjust timing and display options
- Manage studio order and filters

Configuration is stored in browser localStorage and synced to user settings.

## Integration Notes

1. **Module Pattern**: All features follow a modular structure with:
   - Core module with main functionality
   - Settings page for configuration
   - Utility helpers as needed

2. **Initialization**: Features are initialized in the main plugin bootstrap:
   - `setupPauseScreen()` - Age Badge initialization
   - `initProfileChooser()` - Profile Chooser initialization
   - `setupHoverForAllItems()` - Hover Trailers setup
   - `initUserProfileAvatarPicker()` - Avatar Picker initialization
   - `initAvatarSystem()` - Avatar System setup
   - `ensureStudioHubsMounted()` - Studio Collections rendering

3. **Event Handling**: Features communicate via:
   - DOM events (custom events for feature coordination)
   - localStorage updates (for cross-tab sync)
   - Window message passing (for IFrame communication)

4. **Language Support**: All text is localized with fallback values:
   - Turkish (TR) as primary language
   - English (EN) as fallback
   - Add additional languages in `language/` directory

## Customization Guide

### Modifying Feature Appearance

Each feature includes customizable CSS. Look for:
- `.jf-profile-*` - Profile Chooser styles
- `.video-preview-modal` - Hover Trailer modal styles
- `.custom-user-avatar` - Avatar styles
- `.rating-genre-card` - Age Badge styles
- `.studio-hubs` - Studio Collections styles

### Adding New Languages

Create language files in `language/` directory following the Turkish (`tur.js`) pattern.

## Testing

To verify installation:
1. Navigate to Jellyfin settings
2. Check for new feature panels
3. Try enabling/disabling each feature
4. Test feature interactions

## Troubleshooting

### Features Not Appearing:
- Check browser console for errors
- Verify all module files are in correct locations
- Clear browser cache and reload Jellyfin

### Settings Not Saving:
- Check browser localStorage is enabled
- Verify API permissions for the logged-in user
- Check network requests to Jellyfin server

### Performance Issues:
- Reduce preview modal animations
- Disable hover video for Studio Collections
- Limit shown cards count in settings

## License

All features are licensed under the MIT License as per the source repository.

## Acknowledgments

- **Original Project**: [Jellyfin-MonWUI-Plugin](https://github.com/az2oo1/Jellyfin-MonWUI-Plugin) by az2oo1
- **Jellyfin Project**: https://jellyfin.org/
- Community contributions and testing

## Development

To contribute improvements or report issues:
1. Test features thoroughly
2. Check for performance impact
3. Document any API changes
4. Submit detailed bug reports with reproduction steps

## Version History

- **v1.0.0** - Initial feature extraction
  - Who's Watching? profile chooser
  - HoverTrailers preview system
  - Avatar picker and generation
  - Age badge display
  - Studio collections hubs

---

For detailed feature documentation, see individual feature files and settings pages.
