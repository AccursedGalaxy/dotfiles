#!/bin/bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Wait for wallpaper path file to be available (up to 2 seconds)
WALLPAPER_PATH_FILE="$XDG_STATE_HOME/quickshell/user/generated/wallpaper/path.txt"
CONFIG_FILE="$XDG_CONFIG_HOME/illogical-impulse/config.json"
HYPRLOCK_CONF="$XDG_CONFIG_HOME/hypr/hyprlock.conf"

# If hyprlock now references $background_image, it already tracks the wallpaper path
if [ -f "$HYPRLOCK_CONF" ] && grep -q 'path = \$background_image' "$HYPRLOCK_CONF"; then
    echo "Hyprlock background follows \$background_image; manual rewrite skipped."
    exit 0
fi

for i in {1..20}; do
    if [ -f "$WALLPAPER_PATH_FILE" ] && [ -s "$WALLPAPER_PATH_FILE" ]; then
        break
    fi
    sleep 0.1
done

# Get the current wallpaper path
WALLPAPER_PATH=$(cat "$WALLPAPER_PATH_FILE" 2>/dev/null || jq -r '.background.wallpaperPath' "$CONFIG_FILE" 2>/dev/null || echo "/home/aki/Bilder/Wallpapers/wallhaven-lym7pl.jpg")

# Only update if we have a valid wallpaper path and it's different from current
if [ -n "$WALLPAPER_PATH" ] && [ -f "$WALLPAPER_PATH" ]; then
    # Update the hyprlock configuration
    sed -i "s|path = .*|path = $WALLPAPER_PATH|" "$HYPRLOCK_CONF"
    echo "Updated hyprlock wallpaper to: $WALLPAPER_PATH"
else
    echo "Error: Could not find valid wallpaper path" >&2
    exit 1
fi 