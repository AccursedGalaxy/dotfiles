# Wallpaper Auto-Switcher Daemon

This daemon automatically switches your wallpaper to a random image or video from your specified directory every few minutes.

## Features

- **Automatic switching**: Changes wallpaper every 5 minutes
- **Random selection**: Picks random wallpapers from your collection
- **Multiple formats**: Supports images (jpg, png, gif, webp, etc.) and videos (mp4, webm, mkv, etc.)
- **System integration**: Uses systemd user services for reliable operation
- **Logging**: Comprehensive logging for troubleshooting
- **Notifications**: Optional desktop notifications when wallpapers change
- **Easy control**: Simple control script for management

## Files

- `wallpaper-daemon.sh` - Main daemon script
- `wallpaper-daemon-control.sh` - Control script for managing the daemon
- `~/.config/systemd/user/wallpaper-daemon.service` - Systemd service file
- `~/.config/systemd/user/wallpaper-daemon.timer` - Systemd timer file
- `~/.cache/wallpaper-daemon.log` - Log file

## Configuration

### Wallpaper Directory

The daemon looks for wallpapers in `/home/aki/Bilder/Wallpapers` by default. You can change this by editing the `WALLPAPER_DIR` variable in `wallpaper-daemon.sh`.

### Switch Interval

The default interval is 5 minutes. You can change this by editing the `OnUnitActiveSec=5m` line in `wallpaper-daemon.timer`.

## Usage

### Quick Start

1. **Test the daemon first:**
   ```bash
   ~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh test
   ```

2. **Start the daemon:**
   ```bash
   ~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh start
   ```

3. **Enable auto-start on login:**
   ```bash
   ~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh enable
   ```

### Control Commands

```bash
# Start the daemon
~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh start

# Stop the daemon
~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh stop

# Restart the daemon
~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh restart

# Check status
~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh status

# Enable auto-start on login
~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh enable

# Disable auto-start on login
~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh disable

# Test the daemon (run once)
~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh test

# View logs
~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh logs

# Show help
~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh help
```

## Requirements

- **Hyprland** with your existing wallpaper switching setup
- **systemd** (for the daemon service)
- **notify-send** (optional, for notifications)
- **Your existing switchwall.sh script** from quickshell

## Troubleshooting

### Check if the daemon is running:
```bash
systemctl --user status wallpaper-daemon.timer
```

### View recent logs:
```bash
~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh logs
```

### Manual test:
```bash
~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh test
```

### Common Issues

1. **"Wallpaper directory does not exist"**
   - Make sure `/home/aki/Bilder/Wallpapers` exists and contains media files
   - Or edit the `WALLPAPER_DIR` variable in the script

2. **"Switchwall script does not exist"**
   - Ensure your quickshell setup is working
   - Check that `~/.config/quickshell/ii/scripts/colors/switchwall.sh` exists

3. **"No valid media files found"**
   - Make sure your wallpaper directory contains supported file types
   - Supported formats: jpg, jpeg, png, gif, bmp, tiff, webp, svg, mp4, webm, mkv, avi, mov, m4v, flv, wmv

4. **Daemon not starting automatically**
   - Run `~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh enable`
   - Check if systemd user services are enabled: `systemctl --user is-enabled wallpaper-daemon.timer`

## Customization

### Change Switch Interval

Edit `~/.config/systemd/user/wallpaper-daemon.timer`:
```ini
[Timer]
OnUnitActiveSec=10m  # Change to 10 minutes
```

Then reload and restart:
```bash
systemctl --user daemon-reload
~/.config/hypr/hyprland/scripts/wallpaper-daemon-control.sh restart
```

### Change Wallpaper Directory

Edit the `WALLPAPER_DIR` variable in `wallpaper-daemon.sh`:
```bash
WALLPAPER_DIR="/path/to/your/wallpapers"
```

### Notification Toggle

Notifications are disabled by default to avoid spam. To enable them, set `NOTIFY_ON_CHANGE=true` before launching the daemon (for example, in the systemd service or directly in the script):
```bash
NOTIFY_ON_CHANGE=true ~/.config/hypr/hyprland/scripts/wallpaper-daemon.sh
```

Set it back to `false` (or omit it) to keep notifications muted.

## Integration with Hyprland

The daemon integrates seamlessly with your existing Hyprland setup by using the same `switchwall.sh` script that your keybind uses. This ensures consistent behavior and theming.

Your existing keybind `Ctrl+Super+T` will continue to work for manual wallpaper switching, while the daemon handles automatic switching in the background. 