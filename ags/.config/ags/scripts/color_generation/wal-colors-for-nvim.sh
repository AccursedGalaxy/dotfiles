#!/usr/bin/env bash

# Convert pywal colors.json to a Lua module for Neovim
# This should be called after pywal generates new colors

# Get colors from wal
COLORS_JSON="$HOME/.cache/wal/colors.json"
COLORS_LUA="$HOME/.cache/wal/colors.lua"

if [ ! -f "$COLORS_JSON" ]; then
  echo "colors.json not found. Make sure pywal has been run."
  exit 1
fi

# Convert JSON to Lua table format
echo "-- Auto-generated from pywal colors" > "$COLORS_LUA"
echo "return {" >> "$COLORS_LUA"

# Extract background, foreground, cursor
background=$(grep -o '"background": *"[^"]*"' "$COLORS_JSON" | cut -d'"' -f4)
foreground=$(grep -o '"foreground": *"[^"]*"' "$COLORS_JSON" | cut -d'"' -f4)
cursor=$(grep -o '"cursor": *"[^"]*"' "$COLORS_JSON" | cut -d'"' -f4)

echo "  background = \"$background\"," >> "$COLORS_LUA"
echo "  foreground = \"$foreground\"," >> "$COLORS_LUA"
echo "  cursor = \"$cursor\"," >> "$COLORS_LUA"

# Extract color0-color15
for i in {0..15}; do
  color=$(grep -o "\"color$i\": *\"[^\"]*\"" "$COLORS_JSON" | cut -d'"' -f4)
  echo "  color$i = \"$color\"," >> "$COLORS_LUA"
done

echo "}" >> "$COLORS_LUA"

echo "Exported wal colors to Lua format at $COLORS_LUA" 