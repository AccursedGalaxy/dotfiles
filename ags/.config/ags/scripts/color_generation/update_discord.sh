#!/usr/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
CONFIG_DIR="$XDG_CONFIG_HOME/ags"
CACHE_DIR="$XDG_CACHE_HOME/ags"
STATE_DIR="$XDG_STATE_HOME/ags"

# Define Vencord config locations
VENCORD_THEMES_DIR="$XDG_CONFIG_HOME/Vencord/themes"
VESKTOP_THEMES_DIR="$XDG_CONFIG_HOME/vesktop/themes"

# Create necessary directories if they don't exist
mkdir -p "$VENCORD_THEMES_DIR"
mkdir -p "$VESKTOP_THEMES_DIR"
mkdir -p "$CACHE_DIR/user/generated/discord"

# Get color values from material.scss
colornames=$(cat $STATE_DIR/scss/_material.scss | cut -d: -f1)
colorstrings=$(cat $STATE_DIR/scss/_material.scss | cut -d: -f2 | cut -d ' ' -f2 | cut -d ";" -f1)
IFS=$'\n'
colorlist=($colornames)     # Array of color names
colorvalues=($colorstrings) # Array of color values

# Read templates
if [ -f "$CONFIG_DIR/scripts/templates/discord/wal-theme-aggressive.css" ]; then
    # Use aggressive theme with higher CSS specificity
    cp "$CONFIG_DIR/scripts/templates/discord/wal-theme-aggressive.css" "$CACHE_DIR/user/generated/discord/wal-theme.css"
    
    # Apply colors
    for i in "${!colorlist[@]}"; do
        color="${colorvalues[$i]}"
        
        # Extract RGB values from hex color for potential rgba() usage
        if [[ "$color" == \#* ]]; then
            r=$((16#${color:1:2}))
            g=$((16#${color:3:2}))
            b=$((16#${color:5:2}))
            
            # Replace both hex and potential rgba patterns
            sed -i "s/{{ ${colorlist[$i]} }}/${color}/g" "$CACHE_DIR/user/generated/discord/wal-theme.css"
            sed -i "s/rgba({{ ${colorlist[$i]} }},/rgba(${r}, ${g}, ${b},/g" "$CACHE_DIR/user/generated/discord/wal-theme.css"
        else
            sed -i "s/{{ ${colorlist[$i]} }}/${color}/g" "$CACHE_DIR/user/generated/discord/wal-theme.css"
        fi
    done
    
    # Copy to Vencord and Vesktop themes directories
    cp "$CACHE_DIR/user/generated/discord/wal-theme.css" "$VENCORD_THEMES_DIR/wal-theme.css"
    cp "$CACHE_DIR/user/generated/discord/wal-theme.css" "$VESKTOP_THEMES_DIR/wal-theme.css"
    
    # Create a direct CSS injection that can override more aggressively
    surface_color=$(grep -m 1 "surface" "$CACHE_DIR/user/generated/discord/wal-theme.css" | grep -o '#[a-zA-Z0-9]*' | head -1)
    primary_color=$(grep -m 1 "primary" "$CACHE_DIR/user/generated/discord/wal-theme.css" | grep -o '#[a-zA-Z0-9]*' | head -1)
    
    if [ -n "$surface_color" ]; then
        # Create a quick custom CSS injection for app-mount
        mkdir -p "$XDG_CONFIG_HOME/vesktop/custom_css"
        echo "/* Injected background color */
html, body, .appMount-2yBXZl, div#app-mount, .app-2CXKsg, 
.bg-1QIAus, .app-2rEoOp, .container-1eFtFS, .chatContent-3KubbW,
.container-3wLKDe, .peopleColumn-1wMU14, .theme-dark, .contentRegion-3HkfJJ, 
.sidebarRegion-1VBisG {
  background-color: $surface_color !important;
}" > "$XDG_CONFIG_HOME/vesktop/custom_css/force-background.css"
        echo "Custom CSS injection created for maximum compatibility"
    fi
    
    echo "Discord/Vencord/Vesktop theme updated successfully"
else
    echo "Discord template not found. Please create a template at $CONFIG_DIR/scripts/templates/discord/wal-theme.css"
fi 