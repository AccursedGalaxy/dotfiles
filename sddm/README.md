# SDDM Configuration

This directory contains SDDM (Simple Desktop Display Manager) configuration to keep the login screen on forever without any power management timeouts.

## What it does

- **Prevents screen timeout**: Disables DPMS (Display Power Management Signaling) and screen blanking
- **Keeps animated login screen running**: Your `sddm-astronaut-theme` will never turn off
- **Configures display settings**: Sets up proper cursor theme and size matching your Hyprland config

## Key settings

The magic happens in the `[X11]` section with these X server arguments:
```
ServerArguments=-nolisten tcp -dpms -s 0 -s noblank -s noexpose
```

- `-dpms`: Disables Display Power Management Signaling
- `-s 0`: Sets screen saver timeout to 0 (disabled)  
- `-s noblank`: Prevents screen blanking
- `-s noexpose`: Prevents screen expose events

## Installation

Since this is a system-wide configuration file, you have a few options:

### Option 1: Manual copy (Recommended)
```bash
sudo cp sddm/etc/sddm.conf /etc/sddm.conf
sudo systemctl restart sddm
```

### Option 2: Stow with sudo (if you want to use stow)
```bash
sudo stow -t / sddm
sudo systemctl restart sddm
```

### Option 3: Add to your install script
Add this to your `install.sh` script:
```bash
# Install SDDM configuration
sudo cp sddm/etc/sddm.conf /etc/sddm.conf
sudo systemctl restart sddm
```

## Testing

After installation:
1. Log out
2. Wait more than 5 minutes at the login screen
3. Your animated login screen should still be running!

## Reverting

To revert to default settings, delete the custom config:
```bash
sudo rm /etc/sddm.conf
sudo systemctl restart sddm
```

## Power usage note

⚠️ **Warning**: This configuration will keep your display on 24/7 when at the login screen. This increases power consumption, especially on laptops. But as you said - fuck power usage! 😄 