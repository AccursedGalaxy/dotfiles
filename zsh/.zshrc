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
ZSH_THEME="jbergantine"

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
    zoxide

    # Utilities
    zsh-autopair
)

# Enhanced man page colors
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Optional: Add syntax highlighting to man pages
export MANROFFOPT="-c"
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 2)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)

# Add directory stack navigation
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Add better history handling
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

source $ZSH/oh-my-zsh.sh

#------------------
# Environment Variables
#------------------
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export VISUAL=nvim
export EDITOR="$VISUAL"

#-------------
# Desktop Apps
#-------------
export BROWSER="zen"


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
alias ls='exa --git --color=always'
alias l='exa -l --git --color=always'
alias la='exa -la --git --color=always'
alias ll='exa -l --git --color=always'
alias cat='bat --theme=TwoDark'

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
# Custom Aliases
# -----------------
alias notes='cd ~/vaults/new && nvim .'

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

# Reload shell (clear before running)
reload () { clear && exec zsh; }

#------------------
# Additional Tools
#------------------
# thefuck setup
eval $(thefuck --alias)

# FZF Configuration
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh BUG: This line returns "unkown option --zsh"

# Auto Start tmux and attach to last used session, if we don't find one, create a new session
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux attach-session || tmux new-session
fi

# yazi setup
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
