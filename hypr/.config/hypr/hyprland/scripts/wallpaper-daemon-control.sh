#!/usr/bin/env bash

# Wallpaper Daemon Control Script
# This script provides easy control over the wallpaper auto-switching daemon

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVICE_NAME="wallpaper-daemon"
TIMER_NAME="wallpaper-daemon.timer"

show_help() {
    echo "Wallpaper Daemon Control Script"
    echo ""
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  start     - Start the wallpaper daemon"
    echo "  stop      - Stop the wallpaper daemon"
    echo "  restart   - Restart the wallpaper daemon"
    echo "  status    - Show daemon status"
    echo "  enable    - Enable daemon to start on boot"
    echo "  disable   - Disable daemon from starting on boot"
    echo "  test      - Test the daemon by running it once"
    echo "  logs      - Show recent logs"
    echo "  help      - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 start"
    echo "  $0 status"
    echo "  $0 test"
}

start_daemon() {
    echo "Starting wallpaper daemon..."
    systemctl --user enable "$TIMER_NAME"
    systemctl --user start "$TIMER_NAME"
    echo "Daemon started. It will switch wallpapers every 5 minutes."
}

stop_daemon() {
    echo "Stopping wallpaper daemon..."
    systemctl --user stop "$TIMER_NAME"
    systemctl --user disable "$TIMER_NAME"
    echo "Daemon stopped."
}

restart_daemon() {
    echo "Restarting wallpaper daemon..."
    stop_daemon
    sleep 1
    start_daemon
}

show_status() {
    echo "=== Wallpaper Daemon Status ==="
    echo ""
    
    # Check timer status
    echo "Timer Status:"
    systemctl --user status "$TIMER_NAME" --no-pager -l
    
    echo ""
    echo "Service Status:"
    systemctl --user status "$SERVICE_NAME" --no-pager -l
    
    echo ""
    echo "Next Run:"
    systemctl --user list-timers "$TIMER_NAME" --no-pager
}

enable_daemon() {
    echo "Enabling wallpaper daemon to start on boot..."
    systemctl --user enable "$TIMER_NAME"
    echo "Daemon enabled. It will start automatically on login."
}

disable_daemon() {
    echo "Disabling wallpaper daemon from starting on boot..."
    systemctl --user disable "$TIMER_NAME"
    echo "Daemon disabled. It will not start automatically on login."
}

test_daemon() {
    echo "Testing wallpaper daemon..."
    echo "Running daemon once to test functionality..."
    
    if [ -f "$SCRIPT_DIR/wallpaper-daemon.sh" ]; then
        "$SCRIPT_DIR/wallpaper-daemon.sh"
        if [ $? -eq 0 ]; then
            echo "Test successful! Wallpaper should have changed."
        else
            echo "Test failed! Check the logs for details."
        fi
    else
        echo "Error: Daemon script not found at $SCRIPT_DIR/wallpaper-daemon.sh"
        exit 1
    fi
}

show_logs() {
    echo "=== Recent Wallpaper Daemon Logs ==="
    echo ""
    
    log_file="$HOME/.cache/wallpaper-daemon.log"
    if [ -f "$log_file" ]; then
        tail -20 "$log_file"
    else
        echo "No log file found at $log_file"
    fi
    
    echo ""
    echo "=== Recent Systemd Logs ==="
    echo ""
    journalctl --user -u "$SERVICE_NAME" --no-pager -n 20
}

# Main script logic
case "${1:-help}" in
    start)
        start_daemon
        ;;
    stop)
        stop_daemon
        ;;
    restart)
        restart_daemon
        ;;
    status)
        show_status
        ;;
    enable)
        enable_daemon
        ;;
    disable)
        disable_daemon
        ;;
    test)
        test_daemon
        ;;
    logs)
        show_logs
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        echo ""
        show_help
        exit 1
        ;;
esac 