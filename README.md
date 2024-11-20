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

## Welcome to My Configuration Universe! 🌌

This repository is my digital garden 🌱, a place where I nurture and grow my system configurations. It's more than just a backup; it's a portal 🌀 to my ideal working environment, carefully crafted and constantly evolving.

### Core Components

- **Shell Environment**: Extensive ZSH configuration with custom prompts, plugins, and productivity enhancements
- **Window Management**: Hyprland configuration with custom keybindings and animations
- **Development Setup**: Neovim configuration (maintained in a separate repository)
- **System Utilities**: Various tools and scripts for system management and workflow optimization

### Featured Configurations

1. **ZSH Configuration**
   - Custom prompt using Starship
   - Extensive plugin system including syntax highlighting, autosuggestions, and completions
   - Intelligent history management
   - Poetry auto-activation for Python projects
   - Custom aliases for git, system management, and development workflows

2. **Hyprland Setup**
   - Custom animations and visual effects
   - Automated wallpaper management
   - Gesture support
   - Multi-monitor handling
   - Custom keybindings for optimal workflow

3. **System Integration**
   - Automatic theme management
   - Hardware-specific optimizations
   - Custom scripts for system management
   - Integration with various development tools

### Installation

1. **Clone the Repository:**
```bash
git clone https://github.com/AccursedGalaxy/dotfiles.git $HOME/dotfiles
cd $HOME/dotfiles
```

2. **Run Installation Scripts:**
```bash
./install.sh
```

3. **Update Configuration:**
```bash
./update.sh
```

### Maintenance

The repository includes update scripts that help maintain the latest configurations while preserving your personal customizations. The update system is designed to:

- Fetch the latest releases
- Preserve user-specific configurations
- Maintain system stability
- Provide backup options for critical changes

### Structure

- `accursedzsh/`: ZSH configurations and custom scripts
- `.config/hypr/`: Hyprland window manager configurations
- `.config/neofetch/`: System information display configuration
- `.config/starship.toml`: Terminal prompt customization

### Dependencies

Core dependencies include:
- ZSH with Oh-My-ZSH
- Hyprland
- Starship
- Neovim
- Various CLI tools (fzf, thefuck, exa, etc.)

### Personal Configurations

These dotfiles separate public and private configurations for security. To set up your personal settings:

1. Copy the template files from `templates/` to their respective locations
2. Modify the copied files with your personal settings
3. Keep private configurations in `~/.config/private/` or similar
4. Never commit personal configuration files to the repository

### Contributing

While these dotfiles are primarily for personal use, suggestions and improvements are welcome through issues and pull requests.

### License

This project is open-sourced under the [MIT License](LICENSE.md). Copyright (c) 2024 AccursedGalaxy.

---

🔒 **Security Notice:** For security reasons, sensitive and personal data has been excluded or anonymized.