# Using Repository Link in Jellyfin

## Method 1: Add Repository to Jellyfin (Easiest)

If Jellyfin supports custom plugin repositories:

1. **Go to Jellyfin Admin Dashboard**
   - Settings → Plugins → Repository

2. **Add Custom Repository**
   - Click "Add Repository"
   - Paste: `https://raw.githubusercontent.com/az2oo1/jellyfin-addons/main/repository.json`

3. **Install Plugin**
   - Search for "Jellyfin Addons"
   - Click Install
   - Restart Jellyfin

---

## Method 2: Direct Installation via Catalog (If Listed)

If the plugin is added to the official Jellyfin plugin catalog:

1. Go to Jellyfin Settings → Plugins
2. Search "Jellyfin Addons"
3. Install directly

---

## Method 3: Manual Download & Install

If repository method doesn't work:

1. **Download the plugin package:**
   ```
   https://github.com/az2oo1/jellyfin-addons/releases
   ```

2. **Extract to Jellyfin plugin directory:**
   - Windows: `%AppData%\jellyfin\plugins\`
   - Linux: `/var/lib/jellyfin/plugins/`
   - Docker: `/config/plugins/`

3. **Restart Jellyfin**

---

## Method 4: Git Clone (Development)

For developers or testing:

```bash
git clone https://github.com/az2oo1/jellyfin-addons.git
cd jellyfin-addons
# Copy Resources/slider/modules to your Jellyfin web directory
```

---

## Verification

After installation:
- Open Jellyfin Settings
- Check "Plugins" section
- You should see "Jellyfin Addons" with 5 features:
  1. ✓ Who's Watching? (Profile Chooser)
  2. ✓ HoverTrailers (Video Preview)
  3. ✓ Avatar Generator (Choose Avatar)
  4. ✓ Age Badge (Auto-Pause)
  5. ✓ Studio Collections (Hub Organization)

Each feature will have its own settings panel.

---

## Repository Information

- **GitHub:** https://github.com/az2oo1/jellyfin-addons
- **Repository Index:** https://raw.githubusercontent.com/az2oo1/jellyfin-addons/main/repository.json
- **License:** MIT
- **Compatible with:** Jellyfin 10.0+

---

## Troubleshooting

**Plugin not showing after installation?**
- Clear browser cache (Ctrl+Shift+Delete)
- Refresh page (Ctrl+R)
- Check browser console for errors (F12)
- Restart Jellyfin server

**Repository URL not working?**
- Verify GitHub is accessible
- Check that repository.json is valid JSON
- Try manual installation instead

**Need to uninstall?**
- Go to Settings → Plugins → Jellyfin Addons → Remove
- Or manually delete the plugin folder
- Restart Jellyfin
