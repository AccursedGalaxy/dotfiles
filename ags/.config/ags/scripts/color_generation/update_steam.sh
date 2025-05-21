#!/usr/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
CONFIG_DIR="$XDG_CONFIG_HOME/ags"
CACHE_DIR="$XDG_CACHE_HOME/ags"
STATE_DIR="$XDG_STATE_HOME/ags"

# Define colors mode (light/dark)
if [ ! -f "$STATE_DIR/user/colormode.txt" ]; then
    echo "dark" > "$STATE_DIR/user/colormode.txt"
    lightdark="dark"
else
    lightdark=$(sed -n '1p' "$STATE_DIR/user/colormode.txt")
fi

# Get color backend
if [ ! -f "$STATE_DIR/user/colorbackend.txt" ]; then
    echo "material" > "$STATE_DIR/user/colorbackend.txt"
    backend="material"
else
    backend=$(cat "$STATE_DIR/user/colorbackend.txt")
fi

# Detect Steam installation path - prefer user-writable locations
STEAM_DIR="$HOME/.steam/steam/skins"
STEAM_DIR_FLATPAK="$HOME/.var/app/com.valvesoftware.Steam/data/Steam/skins"
STEAM_DIR_LOCAL="$HOME/.local/share/Steam/skins"

# First try standard user-writable paths
if [ -d "$STEAM_DIR" ]; then
    STEAM_PATH="$STEAM_DIR"
    echo "Using Steam path: $STEAM_PATH"
elif [ -d "$STEAM_DIR_FLATPAK" ]; then
    STEAM_PATH="$STEAM_DIR_FLATPAK"
    echo "Using Flatpak Steam path: $STEAM_PATH"
elif [ -d "$STEAM_DIR_LOCAL" ]; then
    STEAM_PATH="$STEAM_DIR_LOCAL"
    echo "Using local Steam path: $STEAM_PATH"
else
    # Fallback: Create default Steam directory in user's home
    echo "No existing Steam skin directory found, creating default at ~/.steam/steam/skins"
    mkdir -p "$STEAM_DIR"
    STEAM_PATH="$STEAM_DIR"
fi

# Make sure the directory exists and is writable
mkdir -p "$STEAM_PATH"
if [ ! -w "$STEAM_PATH" ]; then
    echo "Warning: Steam skin directory $STEAM_PATH is not writable"
    echo "Falling back to user's home directory"
    STEAM_PATH="$HOME/.steam/steam/skins"
    mkdir -p "$STEAM_PATH"
fi

# Force create pywal files needed by wal_steam
WAL_COLORS="$HOME/.cache/wal/colors"
WAL_COLORS_JSON="$HOME/.cache/wal/colors.json"
WAL_CACHE_DIR="$HOME/.cache/wal"

# Always generate pywal colors from material theme
echo "Creating pywal colors from current theme..."
mkdir -p "$WAL_CACHE_DIR"

# Extract colors from material.scss (fallbacks provided)
primary_color=$(grep -m 1 '\$primary:' "$STATE_DIR/scss/_material.scss" | grep -o '#[a-zA-Z0-9]*' | head -1 || echo "#1a73e8")
surface_color=$(grep -m 1 '\$surface:' "$STATE_DIR/scss/_material.scss" | grep -o '#[a-zA-Z0-9]*' | head -1 || echo "#121212")
on_surface_color=$(grep -m 1 '\$onSurface:' "$STATE_DIR/scss/_material.scss" | grep -o '#[a-zA-Z0-9]*' | head -1 || echo "#e0e0e0")
secondary_color=$(grep -m 1 '\$secondary:' "$STATE_DIR/scss/_material.scss" | grep -o '#[a-zA-Z0-9]*' | head -1 || echo "#03dac6")

echo "Extracted colors:"
echo "Primary: $primary_color"
echo "Surface: $surface_color"
echo "OnSurface: $on_surface_color"

# Create simple pywal colors file in the expected format (with # prefix)
echo "#$surface_color
#$primary_color
#$secondary_color
#$on_surface_color
#$primary_color
#$on_surface_color
#$surface_color
#$on_surface_color
#$surface_color
#$on_surface_color
#$surface_color
#$on_surface_color
#$surface_color
#$on_surface_color
#$surface_color
#$on_surface_color" > "$WAL_COLORS"

# Create minimal colors.json file needed by wal_steam
echo '{
  "special": {
    "background": "'"$surface_color"'",
    "foreground": "'"$on_surface_color"'",
    "cursor": "'"$primary_color"'"
  },
  "colors": {
    "color0": "'"$surface_color"'",
    "color1": "'"$primary_color"'",
    "color2": "'"$secondary_color"'",
    "color3": "'"$on_surface_color"'",
    "color4": "'"$primary_color"'",
    "color5": "'"$on_surface_color"'",
    "color6": "'"$surface_color"'",
    "color7": "'"$on_surface_color"'",
    "color8": "'"$surface_color"'",
    "color9": "'"$primary_color"'",
    "color10": "'"$secondary_color"'",
    "color11": "'"$on_surface_color"'",
    "color12": "'"$primary_color"'",
    "color13": "'"$on_surface_color"'",
    "color14": "'"$surface_color"'",
    "color15": "'"$on_surface_color"'"
  },
  "wallpaper": "None"
}' > "$WAL_COLORS_JSON"

# Also create a sequences file that might be needed
WAL_SEQUENCES="$HOME/.cache/wal/sequences"
touch "$WAL_SEQUENCES"

echo "Created pywal files at:"
echo "- $WAL_COLORS"
echo "- $WAL_COLORS_JSON"

# Run pywal with our colors to generate proper theme files
if command -v wal &> /dev/null; then
    echo "Running pywal to generate proper theme files..."
    # Use the surface color as the base for wal
    wal -n -q --theme "$WAL_COLORS_JSON"
fi

# Generate Steam theme - create a simple approach using direct colors
echo "Generating Steam theme using direct color approach..."

# Check if Metro 4.4 directory exists
METRO_DIR="$STEAM_PATH/Metro 4.4 Wal_Mod"
if [ ! -d "$METRO_DIR" ]; then
    echo "First-time setup: Installing Metro for Steam..."
    wal_steam -s "$STEAM_PATH" -g
    
    # Force downloading config file
    if [ -f "/tmp/wal_steam.conf" ]; then
        rm "/tmp/wal_steam.conf"
    fi
    
    # If installation fails, try again with -w flag
    if [ ! -d "$METRO_DIR" ]; then
        echo "Trying alternative installation..."
        wal_steam -w -s "$STEAM_PATH"
    fi
else
    # If the theme is already installed, just update colors
    echo "Metro theme already installed, updating colors..."
    wal_steam -w -s "$STEAM_PATH"
fi

# Final fallback: try with both installations
if [ ! -d "$METRO_DIR" ]; then
    echo "Warning: Steam theme installation may have issues. Trying one more approach..."
    
    # Try finding an existing wallpaper to use
    wallpaper=""
    if [ -f "$HOME/.config/wallpaper.jpg" ]; then
        wallpaper="$HOME/.config/wallpaper.jpg"
    elif [ -f "$HOME/.config/wallpaper.png" ]; then
        wallpaper="$HOME/.config/wallpaper.png"
    elif [ -f "$XDG_CONFIG_HOME/hypr/current_wallpaper.txt" ]; then
        wallpaper=$(cat "$XDG_CONFIG_HOME/hypr/current_wallpaper.txt")
    elif [ -d "$HOME/Pictures/Wallpapers" ]; then
        wallpaper=$(find "$HOME/Pictures/Wallpapers" -type f -name "*.jpg" -o -name "*.png" | head -1)
    elif [ -d "$HOME/Pictures" ]; then
        wallpaper=$(find "$HOME/Pictures" -type f -name "*.jpg" -o -name "*.png" | head -1)
    fi
    
    if [ -n "$wallpaper" ] && [ -f "$wallpaper" ]; then
        echo "Using wallpaper: $wallpaper"
        # Run pywal with the wallpaper
        (cd "$HOME" && wal -i "$wallpaper" -n -q)
    else
        # If no wallpaper is found, use color
        echo "No wallpaper found, using color: $surface_color"
        (cd "$HOME" && wal --theme "$WAL_COLORS_JSON" -n -q)
    fi
    
    # Try running wal_steam again
    wal_steam -w -s "$STEAM_PATH"
fi

# Apply HiDPI patch if needed (uncomment if you use HiDPI)
# wal_steam -w -d

echo "Steam theme updated successfully" 