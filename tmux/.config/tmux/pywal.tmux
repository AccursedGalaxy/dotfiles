#!/usr/bin/env bash

# Source the pywal colors
. "$HOME/.cache/wal/colors.sh"

# Set tmux colors
tmux set-option -g status-style "fg=$color7,bg=$color0"
tmux set-option -g pane-border-style "fg=$color8"
tmux set-option -g pane-active-border-style "fg=$color4"
tmux set-option -g message-style "fg=$color7,bg=$color0"
tmux set-option -g display-panes-active-colour "$color4"
tmux set-option -g display-panes-colour "$color1"
tmux set-option -g clock-mode-colour "$color4"

# Window status
tmux set-window-option -g window-status-style "fg=$color7,bg=$color0"
tmux set-window-option -g window-status-current-style "fg=$color0,bg=$color4"
tmux set-window-option -g window-status-activity-style "fg=$color7,bg=$color0"

# Status bar
tmux set-option -g status-left "#[fg=$color0,bg=$color4,bold] #S "
tmux set-option -g status-right "#[fg=$color7,bg=$color0] %Y-%m-%d #[fg=$color0,bg=$color4,bold] %H:%M " 