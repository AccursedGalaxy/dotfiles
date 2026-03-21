#!/usr/bin/env bash

# Wallpaper Auto-Switcher Daemon
# This script randomly selects wallpapers from a specified directory and switches them

# Configuration
WALLPAPER_DIR="/home/aki/Bilder/Wallpapers"
SWITCHWALL_SCRIPT="$HOME/.config/quickshell/ii/scripts/colors/switchwall.sh"
LOG_FILE="$HOME/.cache/wallpaper-daemon.log"
NOTIFY_ON_CHANGE="${NOTIFY_ON_CHANGE:-false}" # keep false to silence frequent notifications

# Create log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Log function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Check if wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    log "ERROR: Wallpaper directory $WALLPAPER_DIR does not exist"
    exit 1
fi

# Check if switchwall script exists
if [ ! -f "$SWITCHWALL_SCRIPT" ]; then
    log "ERROR: Switchwall script $SWITCHWALL_SCRIPT does not exist"
    exit 1
fi

# Function to check if file is a valid image or video
is_valid_media() {
    local file="$1"
    local extension="${file##*.}"
    
    # Check for image extensions
    case "${extension,,}" in
        jpg|jpeg|png|gif|bmp|tiff|webp|svg)
            return 0
            ;;
        # Check for video extensions
        mp4|webm|mkv|avi|mov|m4v|flv|wmv)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Find all valid media files in the wallpaper directory
find_media_files() {
    local media_files=()
    
    while IFS= read -r -d '' file; do
        if is_valid_media "$file"; then
            media_files+=("$file")
        fi
    done < <(find "$WALLPAPER_DIR" -path '*/.*' -prune -o -type f -print0 2>/dev/null)
    
    printf '%s\n' "${media_files[@]}"
}

# Function to get current workspace
get_current_workspace() {
    hyprctl activeworkspace -j | jq -r '.id' 2>/dev/null || echo "1"
}

# Function to switch to a specific workspace
switch_to_workspace() {
    local workspace_id="$1"
    hyprctl dispatch workspace "$workspace_id" >/dev/null 2>&1
}

# Get all media files
mapfile -t media_files < <(find_media_files)

if [ ${#media_files[@]} -eq 0 ]; then
    log "ERROR: No valid media files found in $WALLPAPER_DIR"
    exit 1
fi

# Remember current workspace before switching wallpaper
current_workspace=$(get_current_workspace)
log "Current workspace before wallpaper change: $current_workspace"

# Select a random wallpaper
random_index=$((RANDOM % ${#media_files[@]}))
selected_wallpaper="${media_files[$random_index]}"

log "Selected wallpaper: $selected_wallpaper"

# Switch to the selected wallpaper
if [ -f "$selected_wallpaper" ]; then
    log "Switching to: $selected_wallpaper"
    
    # Call the switchwall script with the selected wallpaper
    if "$SWITCHWALL_SCRIPT" "$selected_wallpaper" 2>/dev/null; then
        log "Successfully switched to: $selected_wallpaper"
        
        # Wait a moment for any workspace changes to settle
        sleep 1
        
        # Restore the original workspace
        log "Restoring workspace to: $current_workspace"
        switch_to_workspace "$current_workspace"
        
        # Send a notification (optional)
        if [ "$NOTIFY_ON_CHANGE" = "true" ] && command -v notify-send >/dev/null 2>&1; then
            notify-send "Wallpaper Changed" "Switched to: $(basename "$selected_wallpaper")" \
                -a "Wallpaper Daemon" \
                -i "preferences-desktop-wallpaper" \
                -t 3000
        fi
    else
        log "ERROR: Failed to switch to: $selected_wallpaper"
        exit 1
    fi
else
    log "ERROR: Selected wallpaper file does not exist: $selected_wallpaper"
    exit 1
fi

log "Wallpaper daemon completed successfully" 