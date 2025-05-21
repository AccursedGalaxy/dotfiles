#!/usr/bin/env bash

# This script updates tmux and terminal applications with pywal colors
# It should be called after pywal generates new colors

# Export colors to Lua format for Neovim
if [ -f "$HOME/Projects/dotfiles/ags/.config/ags/scripts/color_generation/wal-colors-for-nvim.sh" ]; then
    "$HOME/Projects/dotfiles/ags/.config/ags/scripts/color_generation/wal-colors-for-nvim.sh"
    chmod +x "$HOME/Projects/dotfiles/ags/.config/ags/scripts/color_generation/wal-colors-for-nvim.sh"
fi

# Apply tmux colors
if [ -f "$HOME/.config/tmux/pywal.tmux" ]; then
    # Make sure the script is executable
    chmod +x "$HOME/.config/tmux/pywal.tmux"
    
    # If tmux is running, reload colors
    if command -v tmux &> /dev/null && tmux list-sessions &> /dev/null; then
        "$HOME/.config/tmux/pywal.tmux"
        echo "Updated tmux colors"
    fi
fi

# If neovim is running, refresh the colorscheme in all instances
if command -v nvim &> /dev/null; then
    # Try to refresh all running neovim instances via remote commands
    for nvim_server in $(nvim --server-list); do
        # First reload the lualine theme that uses pywal colors
        nvim --server "$nvim_server" --remote-send "<C-\\><C-n>:lua require('robin.lualine_wal_theme').setup()<CR>"
        # Then reload the colorscheme
        nvim --server "$nvim_server" --remote-send "<C-\\><C-n>:colorscheme wal<CR>"
        # Force redraw
        nvim --server "$nvim_server" --remote-send "<C-\\><C-n>:redraw!<CR>"
    done
    echo "Updated Neovim colors"
fi

# Apply terminal colors (already handled by your existing scripts)
# This is just a reminder in case you want to add custom terminal color logic

echo "Terminal colors updated successfully" 