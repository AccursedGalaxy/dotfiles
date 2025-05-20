#!/bin/bash

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

echo -e "${BLUE}Setting up dotfiles...${NC}"

# Simple configurations with stow
echo -e "${GREEN}Setting up simple configurations with stow...${NC}"
stow -v -t ~ git
stow -v -t ~ foot

# Setup neofetch with anime images
echo -e "${GREEN}Setting up Neofetch with anime images...${NC}"
./neofetch/setup.sh

# Complex configurations with custom approach
echo -e "${GREEN}Setting up complex configurations with custom approach...${NC}"
./adopt_configs.sh

echo -e "${BLUE}Setup completed!${NC}"
echo -e "${GREEN}Your dotfiles are now managed by this repository.${NC}"
echo ""
echo -e "To update your dotfiles repository after making changes to configs:"
echo -e "  ${BLUE}./update.sh --all${NC}"
echo ""
echo -e "For more information, see ${BLUE}README.md${NC}" 