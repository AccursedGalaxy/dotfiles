#!/bin/bash
# Custom cursor highlighting script for Hyprland
# Usage: cursor_highlight.sh [mode]
# Modes: pulse, follow, ripple, stop

CURSOR_COLOR="#0DB7D4"  # Match your theme color
FOLLOW_PID_FILE="/tmp/find-cursor-follow.pid"

case "$1" in
    "pulse")
        # Single pulse animation on current cursor position
        find-cursor \
            --size 400 \
            --distance 25 \
            --wait 150 \
            --line-width 5 \
            --color "$CURSOR_COLOR" \
            --grow \
            --outline 3 \
            --outline-color "#FFFFFF" \
            --repeat 3
        ;;
    "follow")
        # Toggle follow mode - follows cursor movement
        if [ -f "$FOLLOW_PID_FILE" ]; then
            # Stop existing follow mode
            PID=$(cat "$FOLLOW_PID_FILE")
            if ps -p "$PID" > /dev/null 2>&1; then
                kill "$PID"
            fi
            rm -f "$FOLLOW_PID_FILE"
            notify-send "Cursor Follow" "Stopped following cursor" -t 2000
        else
            # Start follow mode
            find-cursor \
                --repeat 0 \
                --follow \
                --distance 15 \
                --wait 50 \
                --line-width 2 \
                --size 40 \
                --color "$CURSOR_COLOR" \
                --grow \
                --outline 1 \
                --transparent &
            echo $! > "$FOLLOW_PID_FILE"
            notify-send "Cursor Follow" "Now following cursor movement" -t 2000
        fi
        ;;
    "ripple")
        # Large ripple effect
        find-cursor \
            --size 600 \
            --distance 50 \
            --wait 100 \
            --line-width 3 \
            --color "$CURSOR_COLOR" \
            --grow \
            --outline 2 \
            --repeat 2
        ;;
    "stop")
        # Stop all find-cursor instances
        pkill find-cursor
        rm -f "$FOLLOW_PID_FILE"
        notify-send "Cursor Highlight" "All cursor effects stopped" -t 2000
        ;;
    *)
        # Default: quick pulse
        find-cursor \
            --size 300 \
            --distance 30 \
            --wait 200 \
            --line-width 4 \
            --color "$CURSOR_COLOR" \
            --grow \
            --outline 2
        ;;
esac 