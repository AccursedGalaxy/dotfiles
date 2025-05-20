#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Adopting more complex configuration directories${NC}"

# Hypr configuration
if [ -d ~/.config/hypr ]; then
    echo -e "${GREEN}Adopting Hypr config...${NC}"
    mkdir -p hypr/.config/hypr
    
    # Recursive copy from home directory to dotfiles repository
    cp -r ~/.config/hypr/* hypr/.config/hypr/
    
    # Remove original directory and create symlink
    echo -e "${GREEN}Creating backup of original Hypr config...${NC}"
    mv ~/.config/hypr ~/.config/hypr.bak
    
    # Create the parent directory and symlink
    mkdir -p ~/.config
    ln -sf $(readlink -f hypr/.config/hypr) ~/.config/hypr
    
    echo -e "${GREEN}Hypr config adopted successfully!${NC}"
else
    echo -e "${RED}No Hypr config found in ~/.config/hypr${NC}"
fi

# AGS configuration
if [ -d ~/.config/ags ]; then
    echo -e "${GREEN}Adopting AGS config...${NC}"
    mkdir -p ags/.config/ags
    
    # Recursive copy from home directory to dotfiles repository
    cp -r ~/.config/ags/* ags/.config/ags/
    
    # Remove original directory and create symlink
    echo -e "${GREEN}Creating backup of original AGS config...${NC}"
    mv ~/.config/ags ~/.config/ags.bak
    
    # Create the parent directory and symlink
    mkdir -p ~/.config
    ln -sf $(readlink -f ags/.config/ags) ~/.config/ags
    
    echo -e "${GREEN}AGS config adopted successfully!${NC}"
else
    echo -e "${RED}No AGS config found in ~/.config/ags${NC}"
fi

# Neofetch configuration
if [ -d ~/.config/neofetch ]; then
    echo -e "${GREEN}Adopting Neofetch config...${NC}"
    mkdir -p neofetch/.config/neofetch
    
    # Recursive copy from home directory to dotfiles repository
    cp -r ~/.config/neofetch/* neofetch/.config/neofetch/
    
    # Remove original directory and create symlink
    echo -e "${GREEN}Creating backup of original Neofetch config...${NC}"
    mv ~/.config/neofetch ~/.config/neofetch.bak
    
    # Create the parent directory and symlink
    mkdir -p ~/.config
    ln -sf $(readlink -f neofetch) ~/.config/neofetch
    
    echo -e "${GREEN}Neofetch config adopted successfully!${NC}"
else
    echo -e "${RED}No Neofetch config found in ~/.config/neofetch${NC}"
    
    # Create the parent directory and symlink
    mkdir -p ~/.config
    ln -sf $(readlink -f neofetch) ~/.config/neofetch
    echo -e "${GREEN}Neofetch config created successfully!${NC}"
fi

echo -e "${BLUE}Adoption completed!${NC}" 