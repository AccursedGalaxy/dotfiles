#!/bin/sh

# Define the repository URL
REPO_URL="https://github.com/<your-username>/<your-repo>.git"

# Define the path to the public zsh configuration
PUBLIC_ZSHRC_PATH="~/zshpub/.accursedrc"

# Clone the repository if it doesn't already exist
if [ ! -d "~/zshpub" ]; then
    git clone $REPO_URL ~/zshpub
else
    echo "Directory ~/zshpub already exists. Skipping clone."
fi

# Add sourcing line to .zshrc if not already present
if ! grep -q "source ~/zshpub/.accursedrc" ~/.zshrc; then
    echo "source ~/zshpub/.accursedrc" >> ~/.zshrc
    echo "Public zsh configuration sourced in ~/.zshrc"
else
    echo "Public zsh configuration already sourced in ~/.zshrc"
fi

echo "Installation complete. Please restart your terminal."
