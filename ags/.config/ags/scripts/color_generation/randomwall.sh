#!/usr/bin/env bash
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
CONFIG_DIR="$XDG_CONFIG_HOME/ags"
random_wall="$(fd . "$(xdg-user-dir PICTURES)/Wallpapers/" -e jpg -e png -e svg | shuf -n1)"
"$CONFIG_DIR/scripts/color_generation/switchwall.sh" "$random_wall"
