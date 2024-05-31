#!/bin/sh

# Define the path to the dotfiles repository
DOTFILES_DIR="$HOME/dotfiles"

# Function to print messages
print_message() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Function to get the latest release tag from GitHub
get_latest_release() {
    curl --silent "https://api.github.com/repos/AccursedGalaxy/dotfiles/releases/latest" | # Get latest release from GitHub API
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Extract tag
}

# Check if the dotfiles directory exists
if [ ! -d "$DOTFILES_DIR" ]; then
    print_message "Error: Dotfiles directory not found at $DOTFILES_DIR."
    exit 1
fi

# Navigate to the dotfiles directory
cd "$DOTFILES_DIR" || { print_message "Error: Failed to navigate to $DOTFILES_DIR."; exit 1; }

# Get the latest release tag
LATEST_RELEASE=$(get_latest_release)

if [ -z "$LATEST_RELEASE" ]; then
    print_message "Error: Failed to fetch the latest release tag."
    exit 1
fi

# Checkout the latest release
if git fetch --tags > /dev/null 2>&1 && git checkout "tags/$LATEST_RELEASE" -f > /dev/null 2>&1; then
    print_message "Dotfiles repository successfully updated to release $LATEST_RELEASE."
else
    print_message "Error: Failed to update the dotfiles repository to release $LATEST_RELEASE."
    exit 1
fi

# Check if the sourcing line is present and uncommented in .zshrc
ZSHRC_PATH="$HOME/.zshrc"
EXPECTED_SOURCE="source $HOME/dotfiles/accursedzsh/.zshrc"

if grep -q "^$EXPECTED_SOURCE" "$ZSHRC_PATH"; then
    :
else
    if grep -q "^#$EXPECTED_SOURCE" "$ZSHRC_PATH"; then
        print_message "Warning: Sourcing line is present but commented in .zshrc."
    else
        print_message "Warning: Sourcing line is missing in .zshrc."
    fi
fi

# Inform the user to restart their terminal
print_message "Please restart your terminal to apply the updates."

exit 0
