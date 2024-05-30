#!/bin/sh

# Define the path to the dotfiles repository and the zsh configuration
DOTFILES_DIR="$HOME/dotfiles"

# Pull the latest changes from the dotfiles repository
cd $DOTFILES_DIR
git pull origin master

echo "Dotfiles repository updated. Please restart your terminal."
