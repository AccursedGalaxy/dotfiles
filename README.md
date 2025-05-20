# Dotfiles

Personal dotfiles managed with GNU Stow and custom scripts.

## Structure

Each directory corresponds to a specific configuration:

- `hypr/` - Hyprland configuration (window manager)
- `ags/` - AGS (Aylur's GTK Shell) configuration
- `tmux/` - Tmux configuration 
- `foot/` - Foot terminal configuration
- `git/` - Git configuration

## Setup

There are two ways to set up the configurations:

### 1. Using Stow

For simple configurations like foot and git:

```bash
# For all configurations (simple ones will work, complex ones may need the script)
stow -t ~ hypr ags tmux foot git

# For individual configurations
stow -t ~ foot
stow -t ~ git
```

### 2. Using the Adoption Script

For more complex configurations like Hypr and AGS, use the provided script:

```bash
# Makes backups of your existing configs and sets up symlinks
./adopt_configs.sh
```

## Update and Management

After making changes to your configuration files, you don't need to do anything special - the changes are automatically reflected since they're symlinked.

If you want to update the repository after making changes to your config files directly, you may run:

```bash
./update.sh --all   # Update all configurations
./update.sh hypr    # Update just the Hypr configuration
```

## Removing

To remove symlinks created by stow:

```bash
stow -D -t ~ foot git  # For stow-managed configs
```

For configurations managed by the adopt script, simply remove the symlinks and restore from backup:

```bash
rm ~/.config/hypr
mv ~/.config/hypr.bak ~/.config/hypr
```

## Notes

- The adoption script creates backups of your original configurations with `.bak` extension
- This setup handles both simple and complex dotfile configurations 