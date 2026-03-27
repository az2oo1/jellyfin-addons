# Feature Documentation

Detailed documentation for each feature included in Jellyfin Addons.

## Table of Contents

1. [Who's Watching? (Profile Chooser)](#whos-watching)
2. [HoverTrailers (Trailer Preview)](#hovertrailers)
3. [Choose Avatar (Avatar Generation)](#choose-avatar)
4. [Age Badge (Maturity Display)](#age-badge)
5. [Studio Collections (Studio Hubs)](#studio-collections)

---

## Who's Watching?

**Netflix-Style Profile Switching**

### Overview

Provides a fast user profile/account switching interface similar to Netflix. Display an overlay with available user accounts, their avatars, and current playback information. Users can click to switch profiles or enable quick login with saved authentication tokens.

### Features

✅ Overlay UI with user profile grid  
✅ Avatar display for each user  
✅ Current playback/presence detection  
✅ Quick login with token storage  
✅ Auto-open after inactivity (6 hours default)  
✅ Header button for manual access  
✅ Multi-user presence awareness  

### Configuration

**Settings Panel:** Profile Chooser

- **Enable Profile Chooser** (default: ✓)
  - Master enable/disable toggle

- **Auto-open after inactivity** (default: ✓)
  - Opens profile overlay after 6 hours of no activity
  - Useful for shared profiles

- **Require quick login** (default: ✓)
  - Only auto-open if a saved token is available
  - Prevents unnecessary overlay if you don't have quick login set up

- **Remember user tokens** (default: ✓)
  - Store authentication tokens locally
  - Enable faster profile switching
  - Tokens stored in browser only (no server transmission)

### How It Works

1. User presses button in header or after inactivity
2. Overlay appears showing all available users with avatars
3. Hover shows current playback information
4. Click to switch user or press quick-login badge
5. Quick login uses stored token for instant access
6. Avatar selection available from profile card

### Performance Notes

- Caches user list with 5-minute expiry
- Stores tokens in browser localStorage only
- Minimal performance impact
- Presence updates every 30 seconds during active watching

### Related Features

- Integrates with **Choose Avatar** for profile pictures
- Works with **Profile Chooser Page** for configuration

---

## HoverTrailers

**Interactive Trailer Preview System**

### Overview

Display trailers or preview videos when hovering over media items. Supports multiple preview modes (modal overlay or popover), YouTube trailers, and HLS streaming. Auto-plays videos on hover with smooth animations.

### Features

✅ Modal preview with video playback  
✅ Popover preview mode (minimal footprint)  
✅ YouTube trailer integration  
✅ HLS streaming support (optional)  
✅ Animated show/hide transitions  
✅ Volume/mute controls  
✅ Touch-friendly long-press detection  
✅ Auto-hide after inactivity  
✅ Trailer badge indicators  
✅ Video preloading and caching  

### Supported Video Sources

- **YouTube Trailers**: Remote trailers from YouTube
- **Local Trailers**: Server-hosted video files
- **HLS Streams**: Adaptive bitrate video (requires Hls.js)
- **Series Trailers**: Trailer for show instead of episode

### Configuration

**Settings Panel:** Hover Trailers

- **Show previews on hover** (default: ✓)
  - Enable/disable the feature globally

- **Preview mode** (default: Modal)
  - **Modal**: Large overlay with video and controls
  - **Studio Mini**: Small popover in studio hub context

- **Prefer trailers over videos** (default: ✓)
  - When both available, show trailer first
  - Only visible in modal mode

- **Only show trailers** (default: ✗)
  - Hide video files, show trailers only
  - Only visible when preferring trailers

- **Enable HLS streaming** (default: ✗)
  - Use adaptive bitrate streaming
  - Requires server HLS transcoding support
  - Requires Hls.js library

### Preview Content Display

Modal shows:
- Video player with controls
- Item title and rating
- Genres and description
- Duration and release year
- Available buttons (watch, info, etc.)

### Performance Tuning

- **Video Preloading**: Improves responsiveness but uses more bandwidth
- **Cache**: Stores 1000 recent previews (7-day expiry)
- **Animations**: Smooth 250ms modal transition

### Known Limitations

- Requires trailer metadata in Jellyfin
- YouTube trailers require public internet access
- HLS support depends on server capabilities

### Related Features

- Works with **Studio Collections** for hub videos
- Uses **Trailer Utils** for YouTube processing

---

## Choose Avatar

**User Avatar Selection & Generation System**

### Overview

Powerful avatar customization system supporting two generation modes: initials-based (text) and DiceBear-generated (synthetic images with 635+ artistic styles). Features dynamic color assignment, avatar caching, protection from overwrites, and auto-rotation.

### Features

✅ Initials-based avatars (text with background)  
✅ DiceBear generated (635+ artistic styles)  
✅ Dynamic color assignment (hash-based from user ID)  
✅ Static/gradient color options  
✅ Avatar size and font customization  
✅ MutationObserver protection from Jellyfin overwrites  
✅ Session-based caching (5-minute TTL)  
✅ Auto-rotation at configurable intervals  
✅ Header button avatar updating  
✅ Profile page integration  

### DiceBear Styles (30+ Available)

Visual avatar generators supporting various artistic styles:
- **adventurer** - Colorful adventure avatars
- **avataaars** - Cartoon-style customizable avatars
- **bottts** - Robot/bot avatars
- **croodles** - Cute character avatars
- **dylan** - Abstract geometric avatars
- **fun-emoji** - Emoji-based avatars
- **glass** - Glass-morphism style
- **icons** - Icon-based avatars
- **identicon** - Abstract geometric (deterministic)
- **lorelei** - Character avatars
- **micah** - Distinctive geometric style
- **miniavs** - Minimal avatars
- **notionists** - Notion-style avatars
- **open-peeps** - Illustrated character parts
- **personas** - Persona-style avatars
- **pixel-art** - 8-bit pixel art style
- **rings** - Concentric rings
- **shapes** - Geometric shapes
- **thumbs** - Colorful thumbs up
- Plus 12+ more styles...

### Configuration

**Settings Panel:** Avatar

#### Avatar Style Selection

- **Create custom avatars** (default: ✓)
  - Master enable/disable

- **Avatar style** (default: Initials)
  - **Initials**: Text-based avatars from user initials
  - **DiceBear**: Artistic generated avatars

#### For Initials Mode

- **Font family**: System font selection
- **Font size**: Pixel size of text (auto-calculated default)
- **Text shadow**: Enable/disable text shadow effect
- **Avatar dimensions**: Width and height in pixels (default 48x48)

#### For DiceBear Mode

- **DiceBear style**: 30+ style options
- **Background enabled**: Show/hide background
- **Background color**: Custom color picker
- **Border radius**: Corner radius (0-50, default 50 for circle)

#### Color Methods

- **Dynamic** (default): 30 predefined colors selected by user ID hash
  - Same user always gets same color
  - Consistent across sessions

- **Solid Color**: Single custom color for all users
  - Color picker to choose

- **Gradient**: Preset color gradient combinations
  - Static gradient applied to all avatars

#### Advanced Options

- **Random DiceBear avatar** (default: ✗)
  - Generate different avatar each session
  - Each refresh gets new random variant

- **Auto-refresh avatars** (default: ✗)
  - Periodically regenerate avatars
  - Interval: 1-60 minutes (default 10)
  - Useful with random mode for variety

### How It Works

1. **Creation**: System generates avatar based on style preference
2. **Rendering**: Avatar created as SVG or styled text element
3. **Display**: Avatar shown in:
   - User profile page
   - Profile chooser overlay
   - Header button
   - Any item user metadata
4. **Protection**: MutationObserver watches for overwrites
5. **Caching**: Result stored in sessionStorage (5-minute expiry)
6. **Auto-rotation** (if enabled): Periodically regenerates avatar

### Performance Notes

- Initials avatars: Instant generation, minimal processing
- DiceBear avatars: Single API call per generation (cached)
- CSS-based rendering: No image files needed
- Cache reduces API calls by 95%+ for common users

### Customization Example

```javascript
// Initials with bold red color
avatarStyle: 'initials'
avatarColorMethod: 'solid'
avatarSolidColor: '#ff4444'

// Adventurer DiceBear style
avatarStyle: 'dicebear'
dicebearStyle: 'adventurer'
dicebearBackgroundColor: '#4a90e2'
```

### Related Features

- Integrates with **Profile Chooser** for user display
- Avatar picker modal available in profile settings

---

## Age Badge

**Content Maturity Rating & Auto-Pause System**

### Overview

Sophisticated system that displays age ratings and maturity warnings during video playback. Analyzes Jellyfin metadata to detect violence, sexual content, and adult themes. Optionally auto-pauses on sensitive content or when attention is lost.

### Features

✅ Age rating display (G through 18+)  
✅ Content descriptor detection (3 categories)  
✅ Visual maturity icon badges  
✅ Smart auto-pause on hidden/blur/idle  
✅ Configurable display duration & lock time  
✅ LRU caching (200 items, 10-min TTL)  
✅ Recommendation panel (optional)  
✅ Multiple rating systems (US, EU, Germany)  

### Rating Systems Supported

**US Ratings:**
- G (General Audiences)
- PG (Parental Guidance)
- PG-13 (Parental Guidance 13+)
- R (Restricted 17+)
- NC-17 (No one under 18)
- TV-Y, TV-Y7, TV-G, TV-PG, TV-14, TV-MA

**German Ratings (FSK):**
- FSK0, FSK6, FSK12, FSK16, FSK18

**Numeric European:**
- 7+, 12+, 13+, 15+, 16+, 18+

### Maturity Descriptors

The system detects three categories:

1. **Cinsellik** (Sexual Content)
   - Nudity, sexual scenes, adult situations
   
2. **Siddet** (Violence/Gore)
   - Violence, gore, intense action
   
3. **Yetiskin** (Adult Themes)
   - Drug use, strong language, dark themes

### Configuration

**Settings Panel:** Pause Screen

#### Badge Timing Settings

- **Badge display duration** (default: 12,000 ms = 12 sec)
  - How long badge shows during normal playback

- **Resume display duration** (default: 5,000 ms = 5 sec)
  - Shorter display when resuming paused video

- **Badge lock duration** (default: 6,000 ms = 6 sec)
  - Prevent badge from showing again for this duration
  - Prevents nuisance re-displays

- **Initial badge delay** (varies by rating)
  - Wait before showing badge after playback starts

- **Resume badge delay** (default: 800 ms)
  - Shorter delay when resuming playback

#### Badge Display

- **Show content age badge** (default: ✓)
  - Display rating and maturity icons

#### Smart Auto-Pause Settings

- **Enable smart auto-pause** (default: ✗)
  - Automatically pause playback in specific conditions

- **Pause when page hidden** (default: ✓)
  - Pause when switching browser tabs

- **Pause on window blur** (default: ✓)
  - Pause when window loses focus (app in background)
  - Timeout: 2 seconds (configurable)

- **Pause on inactivity** (default: ✗)
  - Pause when no mouse/keyboard movement
  - Timeout: 5 seconds (configurable)

- **Auto-resume on focus** (default: ✓)
  - Resume playback when returning to window

### Badge Lifecycle

1. **Playback Starts**: Badge delay countdown begins
2. **Badge Appears**: Shows rating + descriptors (e.g., "PG-13 | Violence, Sexual Content")
3. **Display Window**: Badge visible for configured duration
4. **Auto-Hide**: Badge disappears after duration expires
5. **Lock Period**: Badge locked from re-appearing for lock duration
6. **Unlock Window**: 45-second minimum window allows re-display attempts

### Smart Auto-Pause Behavior

| Condition | Default | Result |
|-----------|---------|--------|
| Tab switch (hidden) | ✓ Enabled | Pauses immediately |
| Window blur | ✓ Enabled | Pauses after 2s |
| No interaction | ✗ Disabled | No auto-pause |
| Focus return | ✓ Auto-resume | Resumes automatically |

### Performance Notes

- LRU cache: Stores 200 items with 10-minute TTL
- Significantly improves performance for frequently watched content
- Details cache: 90 seconds, 120 items max
- Descriptor detection: Runs once per item (cached after)

### Use Cases

- **Parents**: Monitor child viewing with automatic pausing on mature content
- **Schools**: Automated warnings for institutional content filters
- **Content Libraries**: Easy identification of mature material
- **User Preferences**: Personal warning notifications

### Integration with Jellyfin

- Reads from: Ratings, Tags, Keywords, Overview fields
- Updates in real-time as metadata changes
- Respects user content restrictions
- Works with all video types (movies, TV shows, etc.)

---

## Studio Collections

**Disney+-Style Studio Hub Collections**

### Overview

Render studio-based content collections similar to Disney+. Display major studios (Marvel, Pixar, Disney, DC, etc.) as browsable hubs with logos, backdrops, and preview buttons. Support custom studio ordering, genre hubs, and personalized recommendations.

### Features

✅ Studio collection rendering on home page  
✅ 10+ predefined studios with aliases  
✅ Draggable studio order in settings  
✅ Logo and backdrop loading (CDN + local)  
✅ Preview buttons with item discovery  
✅ Hover video support (studio backdrop)  
✅ Multiple content hubs:
  - TV library rows (recent series, episodes, continue)
  - Genre-based collections
  - Director collections
  - Personal recommendations  
✅ Mini popover previews on hover  
✅ Comprehensive caching (6hr to 30-day TTL)  

### Predefined Studios

The system includes aliases for:

| Studio | Aliases |
|--------|---------|
| Marvel Studios | Marvel, MCU |
| Pixar Animation | Pixar |
| Walt Disney | Disney |
| Disney+ | Disney Plus |
| DC Comics | DC |
| Warner Bros | WB, Warner Bros Pictures |
| Lucasfilm | Lucasfilm Ltd, Star Wars |
| Columbia Pictures | Columbia |
| Paramount Pictures | Paramount |
| Netflix | Netflix |
| DreamWorks | DreamWorks Animation |

### Configuration

**Settings Panel:** Studio Hubs

#### Studio Collections

- **Enable studio hubs** (default: ✓)
  - Show/hide studio collections on home page

- **Cards per row** (default: 6, range 1-12)
  - How many studio cards display horizontally

- **Minimum rating filter** (default: 6.5, range 1-10)
  - Only show items with this rating or higher
  - Filters out low-quality content

- **Studio order** (default: Marvel, Pixar, Disney, DC, WB, ...)
  - Draggable list to customize studio display order
  - Add button to fetch additional studios
  - Remove button to hide specific studios

#### TV Library Rows

- **Show TV library rows** (default: ✗)
  - Display rows for TV shows and series

- **Row types** (all configurable):
  - Recent Series: Latest watched/added shows
  - Recent Episodes: Latest aired episodes
  - Continue Series: Resume watching

- **Library selection** (per row)
  - Choose which TV libraries contribute to each row
  - Multi-select from available TV libraries

#### Other Libraries

- **Show other library rows** (default: ✗)
  - Display rows for non-movie content

- **Library filtering**:
  - Auto-excludes: Movies (covered by studios), TV Shows (covered above), Music
  - Shows: Collections, Playlists, or custom collection types

#### Recommendations

- **Show recommendations** (default: ✗)
  - Display "Because You Watched" rows

- **Placement** (default: Under studio hubs)
  - Under studio hubs or at bottom of page

- **Row count** (default: 5, range 1-50)
  - How many recommendation rows to show

- **Cards per row** (default: 8, range 1-20)
  - Cards in each recommendation row

#### Genre Hubs

- **Enable genre collections** (default: ✗)
  - Show genre-based browsing rows

- **Genre row count** (default: 8, range 1-50)
  - How many genre rows to display

- **Cards per genre** (default: 8, range 1-20)
  - Items shown per genre

- **Genre order** (draggable list)
  - Custom ordering of genre rows
  - Fetches genres from server

#### Director Collections

- **Enable director rows** (default: ✗)
  - Show collections by director/creator

- **Director row count** (default: 3, range 1-50)

- **Cards per director** (default: 8, range 1-20)

#### Advanced

- **Enable hover video** (default: ✓)
  - Play video/backdrop on studio card hover
  - Auto-muted by default

### How It Works

1. **Studio Hubs**:
   - Fetches studios from Jellyfin metadata
   - Searches by predefined aliases (e.g., "Marvel" → "Marvel Studios")
   - Selects highest-rated item's backdrop as hub image
   - Arranges in draggable order

2. **Preview Buttons**:
   - Eye icon on studio card
   - Fetches related items on hover
   - Mini popover shows preview (title, rating, runtime, genres)

3. **Hover Video**:
   - Auto-plays backdrop/trailer video on hover
   - Smooth fade transition
   - Muted by default (respects global sound setting)

4. **Content Rows**:
   - TV rows show recent/continued from selected libraries
   - Genre rows group content by metadata genre
   - Recommendations use watch history algorithm
   - Director rows group by creator

### Mini Popover Preview Content

Hover preview popup displays:
- **Title & Year**
- **Runtime** (h:mm format)
- **Ratings**:
  - Star rating (1-10)
  - Rotten Tomatoes score (if available)
  - Age rating badge
- **Genres**
- **Audio tracks** (language + codec)
- **Description** (truncated, with expand)
- **Action buttons** (Play, Info, Add to Playlist)

### Performance Optimization

**Caching Strategy:**
- Studio list: 6 hours
- Logo URLs: 7 days
- Backdrop selection: 7 days
- Item previews: 1 hour
- Genre list: 7 days

**API Efficiency:**
- Parallel studio fetching (Promise.allSettled)
- Lazy video element creation
- Deferred popover loading until hover
- Single genre API call (cached)

### Customization Examples

**Marvel & Disney Only:**
```
enableStudioHubs: true
studioHubsOrder: ["Marvel Studios", "Walt Disney Pictures"]
```

**Genre Focus:**
```
enableStudioHubs: false
enableGenreHubs: true
studioHubsGenreRowsCount: 10
studioHubsGenreCardCount: 12
```

**TV-Heavy Configuration:**
```
enableTvLibRows: true
enableStudioHubs: false
becauseYouWatchedRowCount: 3
```

### Related Features

- Uses **Hover Trailers** for video preview
- Uses **Studio Hubs Utils** for image/metadata handling
- Title/description localization support

---

## Integration Summary

| Feature | Dependencies | Initialization |
|---------|--------------|-----------------|
| Profile Chooser | avatarPicker, userAvatar | `initProfileChooser()` |
| HoverTrailers | studioHubsUtils, utils | `setupHoverForAllItems()` |
| Avatar Picker | userAvatar | `initUserProfileAvatarPicker()` |
| Avatar System | dicebearSpecificParams | `initAvatarSystem()` |
| Age Badge | api, config | `setupPauseScreen()` |
| Studio Hubs | studioHubsUtils, hoverTrailers | `ensureStudioHubsMounted()` |

---

## Troubleshooting Features

### Profile Chooser Issues
- **Auto-open not working**: Verify inactivity threshold, check browser time, clear cache
- **Token not saving**: Verify localStorage enabled, check browser security settings
- **Avatar not showing**: Ensure Choose Avatar feature enabled and configured

### HoverTrailers Issues
- **Trailers not loading**: Verify YouTube URLs in metadata, check CORS settings
- **Video stuttering**: Reduce preload concurrency, disable HLS if not needed
- **Badge not showing**: Verify hover detection working, check card selectors

### Avatar Issues
- **Avatar not updating**: Clear sessionStorage, verify DiceBear API accessible
- **Jellyfin overwriting avatar**: Ensure MutationObserver protection enabled
- **DiceBear API errors**: Verify internet access, check API rate limits

### Age Badge Issues
- **Badge not appearing**: Verify metadata has ratings, check display duration > 0
- **Auto-pause too aggressive**: Adjust timeout thresholds, disable specific triggers
- **Descriptor not detecting**: Check metadata tags/keywords, verify normalization rules

### Studio Hubs Issues
- **Studios not appearing**: Verify studio names match aliases, check metadata
- **Logos not loading**: Verify local image paths, check CDN accessibility
- **Slow loading**: Adjust card counts, disable hover video, check API response times

See [INSTALLATION.md](INSTALLATION.md) for more troubleshooting guides.
