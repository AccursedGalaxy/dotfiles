```
 ________     ______ ___________ _______ __   ___      _______  ________
|"      "\   /    " ("     _   ")"     "|" \ |"  |    /"     "|/"       )
(.  ___  :) // ____  )__/  \\__(: ______)|  |||  |   (: ______|:   \___/
|: \   ) ||/  /    ) :) \\_ /   \/    | |:  ||:  |    \/    |  \___  \
(| (___\ |(: (____/ //  |.  |   // ___) |.  | \  |___ // ___)_  __/  \\
|:       :)\        /   \:  |  (:  (    /\  |( \_|:  (:      "|/" \   :)
(________/  \"_____/     \__|   \__/   (__\_|_)_______)_______|_______/
```
  _______  _______  _______  _______  _______  _______  _______  _______

## ⚠️ Important Notice

These dotfiles are specifically tailored for my personal setup and workflow. While you're welcome to use them as inspiration or reference, please note that:

1. They are heavily customized for my specific system and hardware
2. Direct implementation might require significant modifications for your setup
3. Some features might be dependent on specific hardware or software configurations
4. Installation scripts assume certain system configurations and paths
5. Many configuration files contain hardcoded personal directory structures
6. This repository is currently in transition towards being more public-friendly

**Note**: While I'm working on making these configurations more portable and user-friendly, they currently contain many personal path references and system-specific configurations. If you want to use these dotfiles, you'll need to carefully review and modify paths and settings to match your system.

1. **Clone the Repository:**
```bash
git clone https://github.com/AccursedGalaxy/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
```

2. **Install GNU Stow:**
```bash
# On Debian/Ubuntu
sudo apt install stow

# On Arch Linux
sudo pacman -S stow
```

3. **Deploy Configurations:**
```bash
# Deploy all configurations
stow .

# Or deploy specific configurations
stow zsh
stow hypr
stow neovim
```

### Core Components

- **Shell Environment**: ZSH configuration with Starship prompt and extensive plugin system
- **Window Management**: Hyprland setup with custom animations and workflow optimizations
- **Development Setup**: Neovim configuration (maintained in a separate repository)
- **Terminal Multiplexer**: Tmux configuration for enhanced terminal workflow
- **System Utilities**: Curated collection of CLI tools and productivity enhancers

### Featured Configurations

1. **ZSH Configuration**
   - Starship prompt with custom theme
   - Extensive plugin system for enhanced productivity
   - Intelligent history management
   - Development environment integrations (Python, Node.js, Go)
   - Custom aliases and functions

2. **Hyprland Setup**
   - Dynamic tiling window management
   - Custom animations and gestures
   - Multi-monitor support
   - Automated wallpaper management
   - Hardware-specific optimizations

3. **Development Environment**
   - Neovim configuration (separate repository)
   - Language-specific tooling
   - Git workflow optimizations
   - Project management utilities

### Dependencies

Core dependencies:
- GNU Stow (for dotfile management)
- ZSH + Oh-My-ZSH
- Starship
- Hyprland
- Neovim
- Tmux
- Additional CLI tools (fzf, bat, lsd, etc.)

### Structure

```
dotfiles/
├── zsh/         # ZSH configuration and scripts
├── hypr/        # Hyprland window manager setup
├── tmux/        # Tmux configuration
├── neofetch/    # System information display
└── starship/    # Terminal prompt customization
```

### Private Configurations

For security and personalization:

1. Create a `private` directory in your home folder
2. Store sensitive configurations there
3. Use the provided templates as a base
4. Never commit private configurations to the repository

### Contributing

While these dotfiles are primarily for personal use, suggestions and improvements are welcome through issues and pull requests.

### License

This project is open-sourced under the [MIT License](LICENSE.md). Copyright (c) 2024 AccursedGalaxy.

---

🔒 **Security Notice:** Sensitive and personal data has been excluded or anonymized.
