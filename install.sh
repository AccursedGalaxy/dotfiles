#!/bin/bash

# Script to manage dotfiles with GNU Stow

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo -e "${RED}Error: GNU Stow is not installed. Please install it using your package manager.${NC}"
    echo -e "For Arch Linux: ${BLUE}sudo pacman -S stow${NC}"
    exit 1
fi

# Available packages
packages=("hypr" "ags" "tmux" "foot" "git")

# Function to display usage
usage() {
    echo -e "${BLUE}Dotfiles Management Script${NC}"
    echo ""
    echo -e "Usage: $0 [OPTION] [PACKAGE...]"
    echo ""
    echo -e "Options:"
    echo -e "  ${GREEN}-i, --install${NC}    Install dotfiles (default if no option is provided)"
    echo -e "  ${RED}-r, --remove${NC}     Remove dotfiles"
    echo -e "  ${BLUE}-l, --list${NC}       List available packages"
    echo -e "  ${GREEN}-a, --all${NC}        Apply action to all packages"
    echo -e "  ${BLUE}--adopt${NC}         Adopt existing configuration files"
    echo -e "  ${BLUE}-h, --help${NC}       Display this help message"
    echo ""
    echo -e "Available packages: ${GREEN}${packages[*]}${NC}"
    echo ""
    echo -e "Examples:"
    echo -e "  $0 -i hypr tmux       # Install hypr and tmux configs"
    echo -e "  $0 -r git             # Remove git config"
    echo -e "  $0 -i -a              # Install all configs"
    echo -e "  $0 -r -a              # Remove all configs"
    echo -e "  $0 -i --adopt hypr    # Install hypr configs, adopting existing files"
}

# Function to list available packages
list_packages() {
    echo -e "${BLUE}Available packages:${NC}"
    for pkg in "${packages[@]}"; do
        if stow -n -d . -t ~ "$pkg" &> /dev/null; then
            status="${GREEN}Not installed${NC}"
        else
            status="${RED}Installed${NC}"
        fi
        echo -e "  ${GREEN}$pkg${NC} - $status"
    done
}

# Default action
action="install"
adopt=false

# No arguments provided
if [ $# -eq 0 ]; then
    usage
    exit 0
fi

# Parse options
selected_packages=()
all_packages=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--install)
            action="install"
            shift
            ;;
        -r|--remove)
            action="remove"
            shift
            ;;
        -l|--list)
            list_packages
            exit 0
            ;;
        -a|--all)
            all_packages=true
            shift
            ;;
        --adopt)
            adopt=true
            shift
            ;;
        -h|--help)
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
                list_packages
                exit 1
            fi
            
            selected_packages+=("$1")
            shift
            ;;
    esac
done

# Use all packages if -a flag is provided
if [ "$all_packages" = true ]; then
    selected_packages=("${packages[@]}")
fi

# Error if no packages selected
if [ ${#selected_packages[@]} -eq 0 ]; then
    echo -e "${RED}Error: No packages selected.${NC}"
    usage
    exit 1
fi

# Adopt existing configs if requested
if [ "$adopt" = true ] && [ "$action" = "install" ]; then
    echo -e "${BLUE}Adopting existing configurations...${NC}"
    for pkg in "${selected_packages[@]}"; do
        echo -e "${GREEN}Adopting ${pkg} config...${NC}"
        stow --adopt -v -t ~ "$pkg"
    done
    echo -e "${GREEN}Adoption complete!${NC}"
    echo -e "${BLUE}Now installing/reinstalling symbolic links...${NC}"
fi

# Perform the action on each selected package
for pkg in "${selected_packages[@]}"; do
    if [ "$action" = "install" ]; then
        echo -e "${GREEN}Installing ${pkg} config...${NC}"
        if [ "$adopt" = false ]; then
            # Regular stow command
            stow -v -t ~ "$pkg"
        else
            # If we already adopted, we need to restow
            stow -v -R -t ~ "$pkg"
        fi
    elif [ "$action" = "remove" ]; then
        echo -e "${RED}Removing ${pkg} config...${NC}"
        stow -v -D -t ~ "$pkg"
    fi
done

echo -e "${BLUE}Done!${NC}" 