#!/bin/sh

# Define the path to the public zsh configuration
PUBLIC_ZSHRC_PATH="$HOME/accursedzsh/.accursedrc"

# Add sourcing line to .zshrc if not already present
if ! grep -q "source $PUBLIC_ZSHRC_PATH" "$HOME/.zshrc"; then
    echo "source $PUBLIC_ZSHRC_PATH" >> "$HOME/.zshrc"
    echo "Public zsh configuration sourced in ~/.zshrc"
else
    echo "Public zsh configuration already sourced in ~/.zshrc"
fi

echo "Installation complete. Please restart your terminal."
