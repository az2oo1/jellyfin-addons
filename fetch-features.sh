#!/bin/bash
# Fetch Jellyfin-MonWUI-Plugin Features Script
# This script downloads feature files from the source repository

# Configuration
BRANCH="${1:-main}"
OWNER="${2:-az2oo1}"
REPO="${3:-Jellyfin-MonWUI-Plugin}"
TARGET_DIR="${4:-.}"

BASE_URL="https://raw.githubusercontent.com/$OWNER/$REPO/$BRANCH"

# Module files to download
MODULE_FILES=(
    "Resources/slider/modules/profileChooser.js"
    "Resources/slider/modules/hoverTrailerModal.js"
    "Resources/slider/modules/avatarPicker.js"
    "Resources/slider/modules/userAvatar.js"
    "Resources/slider/modules/dicebearSpecificParams.js"
    "Resources/slider/modules/pauseModul.js"
    "Resources/slider/modules/studioHubs.js"
    "Resources/slider/modules/studioHubsUtils.js"
    "Resources/slider/modules/utils.js"
)

# Settings files to download
SETTINGS_FILES=(
    "Resources/slider/modules/settings/profileChooserPage.js"
    "Resources/slider/modules/settings/hoverTrailerPage.js"
    "Resources/slider/modules/settings/avatarPage.js"
    "Resources/slider/modules/settings/pausePage.js"
    "Resources/slider/modules/settings/studioHubsPage.js"
)

# Create necessary directories
MODULES_DIR="$TARGET_DIR/Resources/slider/modules"
SETTINGS_DIR="$TARGET_DIR/Resources/slider/modules/settings"

echo -e "\033[32mCreating directories...\033[0m"
mkdir -p "$MODULES_DIR"
mkdir -p "$SETTINGS_DIR"

# Function to download file
download_file() {
    local url=$1
    local output_path=$2
    local file_name=$(basename "$output_path")
    
    echo -e "  \033[36mDownloading $file_name...\033[0m"
    if curl -s -f "$url" -o "$output_path"; then
        echo -e "    \033[32m✓ Downloaded successfully\033[0m"
    else
        echo -e "    \033[31m✗ Failed to download\033[0m"
    fi
}

# Download module files
echo -e "\033[32mDownloading module files...\033[0m"
for file in "${MODULE_FILES[@]}"; do
    url="$BASE_URL/$file"
    file_name=$(basename "$file")
    output_path="$MODULES_DIR/$file_name"
    
    download_file "$url" "$output_path"
done

# Download settings files
echo -e "\033[32mDownloading settings files...\033[0m"
for file in "${SETTINGS_FILES[@]}"; do
    url="$BASE_URL/$file"
    file_name=$(basename "$file")
    output_path="$SETTINGS_DIR/$file_name"
    
    download_file "$url" "$output_path"
done

echo ""
echo -e "\033[32mDownload complete!\033[0m"
echo -e "Files are now available at: \033[36m$MODULES_DIR\033[0m"
echo -e "Settings files at: \033[36m$SETTINGS_DIR\033[0m"
