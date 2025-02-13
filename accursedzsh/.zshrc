#  $$$$$$\                                                                   $$\
# $$  __$$\                                                                  $$ |
# $$ /  $$ | $$$$$$$\  $$$$$$$\ $$\   $$\  $$$$$$\  $$$$$$$\  $$$$$$\   $$$$$$$ |
# $$$$$$$$ |$$  _____|$$  _____|$$ |  $$ |$$  __$$\$$  _____|$$  __$$\ $$  __$$ |
# $$  __$$ |$$ /      $$ /      $$ |  $$ |$$ |  \__\$$$$$$\  $$$$$$$$ |$$ /  $$ |
# $$ |  $$ |$$ |      $$ |      $$ |  $$ |$$ |      \____$$\ $$   ____|$$ |  $$ |
# $$ |  $$ |\$$$$$$$\ \$$$$$$$\ \$$$$$$  |$$ |     $$$$$$$  |\$$$$$$$\ \$$$$$$$ |
# \__|  \__| \_______| \_______| \______/ \__|     \_______/  \_______| \_______|
#             $$$$$$\            $$\
#            $$  __$$\           $$ |
#            $$ /  \__| $$$$$$\  $$ | $$$$$$\  $$\   $$\ $$\   $$\
#            $$ |$$$$\  \____$$\ $$ | \____$$\ \$$\ $$  |$$ |  $$ |
#            $$ |\_$$ | $$$$$$$ |$$ | $$$$$$$ | \$$$$  / $$ |  $$ |
#            $$ |  $$ |$$  __$$ |$$ |$$  __$$ | $$  $$<  $$ |  $$ |
#            \$$$$$$  |\$$$$$$$ |$$ |\$$$$$$$ |$$  /\$$\ \$$$$$$$ |
#             \______/  \_______|\__| \_______|\__/  \__| \____$$ |
#                                                        $$\   $$ |
#                                                        \$$$$$$  |
#                                                         \______/
# .zshrc - Accursed Galaxy's Dotfiles
# GitHub: https://github.com/AccursedGalaxy

#------------------
# Core ZSH Settings
#------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="awesomepanda"

# Update settings
zstyle ':omz:update' mode auto
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13

ENABLE_CORRECTION="true"

#------------------
# Plugin Management
#------------------
plugins=(
    # Git & Development
    git
    zsh-nvm
    zsh-pyenv
    zsh-better-npm-completion

    # Shell Enhancement
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    zsh-interactive-cd
    zsh-you-should-use

    # Navigation & History
    zsh-history-substring-search
    zsh-vi-mode
    zsh-navigation-tools

    # Utilities
    zsh-autopair
)

source $ZSH/oh-my-zsh.sh

#------------------
# Environment Variables
#------------------
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export VISUAL=nvim
export EDITOR="$VISUAL"

#  (
#  )\ )    )               )               )
# (()/( ( /(       (    ( /(        (   ( /(
#  /(_)))\())  (   )(   )\()) (    ))\  )\())(
# (_)) ((_)\   )\ (()\ (_))/  )\  /((_)(_))/ )\
# / __|| |(_) ((_) ((_)| |_  ((_)(_))( | |_ ((_)
# \__ \| ' \ / _ \| '_||  _|/ _| | || ||  _|(_-<
# |___/|_||_|\___/|_|   \__|\__|  \_,_| \__|/__/

# Pokemon Colorscripts Display
# More info: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos
pokemon-colorscripts --no-title -s -r

# SSH Agent Configuration
# Start SSH-Agent if not already running and add your default SSH key
if ! pgrep -u "$USER" ssh-agent > /dev/null 2>&1; then
  eval "$(ssh-agent -s)" > /dev/null 2>&1
  ssh-add ~/.ssh/id_ed25519 > /dev/null 2>&1
else
  SSH_AUTH_SOCK_CANDIDATES=$(find /tmp/ssh-* -name 'agent.*' -user $USER 2>/dev/null || true)
  export SSH_AUTH_SOCK=$(echo "$SSH_AUTH_SOCK_CANDIDATES" | head -n 1)
  if [[ ! "$SSH_AUTH_SOCK" ]]; then
    eval "$(ssh-agent -s)" > /dev/null 2>&1
    ssh-add ~/.ssh/id_ed25519 > /dev/null 2>&1
  fi
fi

# Lunar Vim Because sometimes nvim breaks on different machines.. kekw
alias lvim='/home/robin/.local/bin/lvim'

#------------------
# Application Aliases
#------------------
# Editor Configuration
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nvimconfig="cd ~/.config/nvim && nvim ."
alias hyper="cd ~/.config/hypr && nvim ."

#------------------
# System Aliases
#------------------
# Package Management
alias update='sudo apt update && sudo apt upgrade'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias search='apt search'

# System Monitoring
alias df='df -h'
alias du='dust'
alias ps='procs'
alias htop='sudo btop'
alias meminfo='free -m -l -t'
alias cpuinfo='lscpu'

# Networking
alias ports='netstat -tulanp'
alias myip='curl http://ipecho.net/plain; echo'
alias flushdns='sudo systemctl restart nscd'

# System Control
alias reboot='sudo systemctl reboot'
alias poweroff='sudo systemctl poweroff'

#------------------
# File Management Aliases
#------------------
alias ls='lsd --group-dirs first -F --icon=always'
alias tree='lsd --tree'
alias ll='ls -alF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'
alias cat='batcat --theme=TwoDark'

#------------------
# Git Aliases
#------------------
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpull='git pull'
alias glog='git log --oneline --decorate --graph'
alias gco='git checkout'
alias gb='git branch'
alias gcm='git checkout main'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'

#------------------
# Search & Find Utilities
#------------------
alias grep='grep --color=auto'
alias ffind='fzf --preview "batcat --color=always --style=header,grid --line-range :500 {}" --bind "enter:execute(nvim {})"'
alias histsearch='history | fzf | awk "{print \$2}" | xargs -I {} bash -c "{}"'
alias killproc='ps aux | fzf | awk "{print \$2}" | xargs kill -9'
alias psgrep='ps aux | grep'
alias countpy='find . -name "*.py" -not -path "*/migrations/*" -not -path "*/__pycache__/*" -not -path "*/.venv/*" -not -path "*/.git/*" -print0 | xargs -0 cat | wc -l'

#------------------
# Custom Functions
#------------------
# Create directory and cd into it
mkcd () { mkdir -p "$1" && cd "$1"; }

# Reload shell
reload() { source ~/.zshrc; }

#------------------
# Additional Tools
#------------------
# thefuck setup
eval $(thefuck --alias)

# FZF Configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
