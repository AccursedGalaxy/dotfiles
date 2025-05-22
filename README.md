# 🚀 Dotfiles

<div align="center">

![GitHub stars](https://img.shields.io/github/stars/aki/dotfiles?style=for-the-badge&color=F4685B)
![GitHub last commit](https://img.shields.io/github/last-commit/aki/dotfiles?style=for-the-badge&color=C1B9FC)
![GitHub repo size](https://img.shields.io/github/repo-size/aki/dotfiles?style=for-the-badge&color=65B7EF)

**My personal dotfiles for a customized Hyprland-based desktop environment**
</div>

<div align="center">
  <img src="assets/arch-rice-main.png" alt="Screenshot of Desktop Environment" width="100%">
</div>

This configuration builds upon the excellent [end-4/dots-hyprland](https://end-4.github.io/dots-hyprland-wiki/en/) foundation with custom modifications to the sidebar, top bar, and color generation setup.

## ✨ Features

- **🎨 Auto-generated colorschemes** - Wallpaper-based theming with extended application support
- **🤖 OpenRouter-powered AI Assistant** - Custom sidebar with OpenRouter integration supporting multiple AI models
- **📊 Redesigned top bar** - Custom appearance with similar functionality to the original
- **📱 Enhanced sidebar** - Streamlined interface with focused functionality
- **🎭 Consistent theming** - Unified appearance across applications

<details>
<summary><b>🖼️ More Screenshots</b></summary>
<div align="center">
  <img src="assets/arch_rice_sidebar.png" alt="Sidebar View" width="100%">
</div>
</details>

## 🧩 Components

This setup includes configurations for:

| Component | Description |
|-----------|-------------|
| **[Hyprland](https://hyprland.org/)** | Tiling Wayland compositor/window manager |
| **[AGS](https://github.com/Aylur/ags)** | Aylur's GTK Shell - JavaScript-based desktop environment with custom widgets |
| **[Pywal](https://github.com/dylanaraps/pywal)** | Color scheme generator based on wallpapers |
| **[Foot](https://codeberg.org/dnkl/foot)** | Fast, lightweight terminal emulator |
| **[Tmux](https://github.com/tmux/tmux)** | Terminal multiplexer |
| **[Neofetch](https://github.com/dylanaraps/neofetch)** | System information tool |
| **[Git](https://git-scm.com/)** | Version control configuration |
| **[Zsh](https://www.zsh.org/)** | Shell configuration |

## 📋 Installation

> **Note**: This repository is my personal configuration and is not designed for direct installation on other systems.

If you're interested in a similar setup:

1. Install the original [end-4/dots-hyprland](https://end-4.github.io/dots-hyprland-wiki/en/) using their installation script
2. Once you have a working setup, you can adapt specific elements from this repository to customize your configuration

## 📦 Dependencies

<details open>
<summary><b>Required packages</b></summary>

```bash
# Core components
hyprland hyprpaper hypridle hyprlock

# Desktop environment
aylurs-gtk-shell

# Appearance and colors
pywal imagemagick

# Utilities
foot tmux git zsh
```
</details>

## 📂 Directory Structure

<details>
<summary><b>Click to expand</b></summary>

- `hypr/` - Hyprland window manager configuration
  - `.config/hypr/hyprland/` - Default configurations
  - `.config/hypr/custom/` - Personalized configurations and overrides
- `ags/` - AGS (Aylur's GTK Shell) configuration
  - `.config/ags/modules/` - UI components (bar, sidebar, widgets)
  - `.config/ags/services/` - Background services
- `wal/` - Pywal configuration and templates
- `tmux/` - Tmux configuration
- `foot/` - Foot terminal configuration
- `git/` - Git configuration
- `zsh/` - Zsh shell configuration
- `neofetch/` - System information display configuration
</details>

## ⚙️ Customization

<details>
<summary><b>Hyprland</b></summary>

Custom settings for Hyprland are maintained in the `hypr/.config/hypr/custom/` directory to make it easier to update the base configuration. Key files:

- `general.conf` - General Hyprland settings
- `keybinds.conf` - Custom keyboard shortcuts
- `rules.conf` - Window rules for specific applications
- `execs.conf` - Startup applications and services
</details>

<details>
<summary><b>AGS</b></summary>

The AGS configuration is organized in a modular fashion:

- `user_options.jsonc` - User-specific preferences
- `modules/` - UI components organized by function
- `services/` - Background services for system monitoring and control
</details>

## 🙏 Credits

This configuration builds upon [end-4/dots-hyprland](https://end-4.github.io/dots-hyprland-wiki/en/), which provided the foundation for this setup. I've made custom modifications to the sidebar, top bar, and expanded the color generation setup to include additional applications.

## 📝 Notes

- The adoption script creates backups of your original configurations with `.bak` extension
- Configuration files are organized to separate base settings from personal customizations
- Custom settings override the default ones, making it easier to update the base configuration
