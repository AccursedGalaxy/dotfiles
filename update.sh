#!/bin/bash

# Script to update dotfiles from the home directory

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Available packages
packages=("hypr" "ags" "tmux" "foot" "git")

# Function to display usage
usage() {
    echo -e "${BLUE}Dotfiles Update Script${NC}"
    echo ""
    echo -e "Usage: $0 [PACKAGE...]"
    echo -e "  or   $0 --all"
    echo ""
    echo -e "Options:"
    echo -e "  ${GREEN}--all${NC}        Update all packages"
    echo -e "  ${BLUE}--help${NC}       Display this help message"
    echo ""
    echo -e "Available packages: ${GREEN}${packages[*]}${NC}"
    echo ""
    echo -e "Examples:"
    echo -e "  $0 hypr tmux       # Update hypr and tmux configs"
    echo -e "  $0 --all           # Update all configs"
}

# Function to update a package
update_package() {
    local pkg=$1
    echo -e "${BLUE}Updating ${pkg} config...${NC}"
    
    case $pkg in
        hypr)
            if [ -d ~/.config/hypr ]; then
                rm -rf hypr/.config/hypr
                mkdir -p hypr/.config/hypr
                cp -r ~/.config/hypr/* hypr/.config/hypr/
                echo -e "${GREEN}Updated hypr config${NC}"
            else
                echo -e "${RED}~/.config/hypr does not exist${NC}"
            fi
            ;;
        ags)
            if [ -d ~/.config/ags ]; then
                rm -rf ags/.config/ags
                mkdir -p ags/.config/ags
                cp -r ~/.config/ags/* ags/.config/ags/
                echo -e "${GREEN}Updated ags config${NC}"
            else
                echo -e "${RED}~/.config/ags does not exist${NC}"
            fi
            ;;
        tmux)
            if [ -d ~/.config/tmux ]; then
                rm -rf tmux/.config/tmux
                mkdir -p tmux/.config/tmux
                cp -r ~/.config/tmux/* tmux/.config/tmux/
                echo -e "${GREEN}Updated tmux config${NC}"
            else
                echo -e "${RED}~/.config/tmux does not exist${NC}"
            fi
            ;;
        foot)
            if [ -d ~/.config/foot ]; then
                rm -rf foot/.config/foot
                mkdir -p foot/.config/foot
                cp -r ~/.config/foot/* foot/.config/foot/
                echo -e "${GREEN}Updated foot config${NC}"
            else
                echo -e "${RED}~/.config/foot does not exist${NC}"
            fi
            ;;
        git)
            if [ -f ~/.gitconfig ]; then
                cp ~/.gitconfig git/
                echo -e "${GREEN}Updated git config${NC}"
            else
                echo -e "${RED}~/.gitconfig does not exist${NC}"
            fi
            ;;
        *)
            echo -e "${RED}Unknown package: $pkg${NC}"
            return 1
            ;;
    esac
    
    return 0
}

# No arguments provided
if [ $# -eq 0 ]; then
    usage
    exit 0
fi

# Parse options
selected_packages=()

while [[ $# -gt 0 ]]; do
    case $1 in
        --all)
            selected_packages=("${packages[@]}")
            shift
            ;;
        --help)
            usage
            exit 0
            ;;
        -*)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            exit 1
            ;;
        *)
            # Check if the package exists
            valid=false
            for pkg in "${packages[@]}"; do
                if [ "$1" = "$pkg" ]; then
                    valid=true
                    break
                fi
            done
            
            if [ "$valid" = false ]; then
                echo -e "${RED}Error: Package '$1' not found in available packages.${NC}"
                usage
                exit 1
            fi
            
            selected_packages+=("$1")
            shift
            ;;
    esac
done

# Error if no packages selected
if [ ${#selected_packages[@]} -eq 0 ]; then
    echo -e "${RED}Error: No packages selected.${NC}"
    usage
    exit 1
fi

# Update each selected package
for pkg in "${selected_packages[@]}"; do
    update_package "$pkg"
done

echo -e "${BLUE}Update completed! Don't forget to commit your changes.${NC}" 