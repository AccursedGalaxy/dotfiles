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
# 
# TODO:
# - Update README.md to fit the new structure with puglic facing zshrc and private zshrc.
# -> now users can just keep everything in the private zshrc, and this dotfiles repo will be just adding a sourcing line to the private zshrc.
# -> This makes it possible for users to keep the personalized stuff while being able to update the public facing zshrc.

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="avit"


zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 13   # check every 13 days

source $ZSH/oh-my-zsh.sh

ENABLE_CORRECTION="true"

plugins=(
  git
  zsh-nvm
  zsh-interactive-cd
  zsh-you-should-use
  zsh-history-substring-search
  zsh-vi-mode
  zsh-navigation-tools
  zsh-autopair
  zsh-pyenv
  zsh-better-npm-completion
)


export PATH="$HOME/bin:/usr/local/bin:$PATH"
export VISUAL=nvim
export EDITOR="$VISUAL"

# Initialize Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Load Zinit plugins
# zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

autoload -U compinit && compinit

# Switch keybindings to vi mode
bindkey -v
bindkey '^R' history-search-backward
bindkey '^S' history-search-forward

HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# eval"$(zoxide init --cmd cd zsh)"
# eval "$(zoxide init zsh)"

#  (                                             
#  )\ )    )               )               )     
# (()/( ( /(       (    ( /(        (   ( /(     
#  /(_)))\())  (   )(   )\()) (    ))\  )\())(   
# (_)) ((_)\   )\ (()\ (_))/  )\  /((_)(_))/ )\  
# / __|| |(_) ((_) ((_)| |_  ((_)(_))( | |_ ((_) 
# \__ \| ' \ / _ \| '_||  _|/ _| | || ||  _|(_-< 
# |___/|_||_|\___/|_|   \__|\__|  \_,_| \__|/__/ 

DOTFILES_DIR="$HOME/dotfiles"
alias udotfiles='cd $DOTFILES_DIR && sh update.sh'

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

# SSH Key Configuration
export SSH_KEY_PATH="~/.ssh/id_rsa"
if [ -f "$SSH_KEY_PATH" ]; then
  eval "$(ssh-agent -s)"
  ssh-add $SSH_KEY_PATH
fi
alias sshconfig="nvim ~/.ssh/config"

# Lunar Vim Because sometimes nvim breaks on different machines.. kekw
alias lvim='/home/robin/.local/bin/lvim'

# Navigation
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nvimconfig="cd ~/.config/nvim && nvim ."
alias hyper="cd ~/.config/hypr && nvim ."

# Coding Projects Shortcuts

# Navigate to different Volume Drive "/media/robin/Volume1/github/CryptoDataFetcher"
alias cdv1="cd /media/robin/Volume1"

# Nagivgate to cdv1 and then to github/CryptoDataFetcher
alias codefetcher="cdv1/github/CryptoDataFetcher"


# General System Administration
alias update='sudo apt update && sudo apt upgrade'   # Update and upgrade packages
alias install='sudo apt install'                     # Shortcut for installing packages
alias remove='sudo apt remove'                       # Shortcut for removing packages
alias search='apt search'                            # Search for packages
alias df='df -h'                                     # Display free disk space in human-readable format
alias du='du -h'                                     # Disk usage in human-readable format
alias htop='sudo btop'                               # System monitoring utility

# Networking
alias ports='netstat -tulanp'                        # Show open ports
alias myip='curl http://ipecho.net/plain; echo'      # Display external IP address
alias flushdns='sudo systemctl restart nscd'         # Flush DNS cache

# System Monitoring and Management
alias meminfo='free -m -l -t'                        # Memory usage in MB
alias cpuinfo='lscpu'                                # CPU model and details
alias reboot='sudo systemctl reboot'                 # Reboot system quickly
alias poweroff='sudo systemctl poweroff'             # Power-off system quickly

# File Management
alias ls='exa --icons -F -H --group-directories-first --git -1' # List all files in one column
alias ll='ls -alF'                                   # List all files in long format
alias rm='rm -i'                                     # Interactive removal mode
alias cp='cp -i'                                     # Interactive copy mode
alias mv='mv -i'                                     # Interactive move mode
alias mkdir='mkdir -pv'                              # Create parent directories as needed

# Git Aliases
alias gs='git status'                                # Git status
alias ga='git add'                                   # Git add
alias gc='git commit'                                # Git commit
alias gp='git push'                                  # Git push
alias gpull='git pull'                               # Git pull
alias glog='git log --oneline --decorate --graph'    # Git log graph
alias gco='git checkout'                             # Git checkout
alias gb='git branch'                                # Git branch
alias gcm='git checkout main'                        # Git checkout main
alias gst='git stash'                                # Git stash
alias gsta='git stash apply'                         # Git stash apply
alias gstd='git stash drop'                          # Git stash drop

# Miscellaneous
alias grep='grep --color=auto'                       # Colorized grep output
alias c='clear'                                      # Clear terminal display
alias cat='batcat'
alias countpy='find . -name "*.py" -not -path "*/migrations/*" -not -path "*/__pycache__/*" -not -path "*/.venv/*" -not -path "*/.git/*" -print0 | xargs -0 cat | wc -l'
alias psgrep='ps aux | grep'

#Alias to exit conda environments and go back to root directory.
alias cde='cd $HOME && conda deactivate'

# Advanced Searching Shit
alias ffind='fzf --preview "batcat --color=always --style=header,grid --line-range :500 {}" --bind "enter:execute(nvim {})"'
alias histsearch='history | fzf | awk "{print \$2}" | xargs -I {} bash -c "{}"'
alias killproc='ps aux | fzf | awk "{print \$2}" | xargs kill -9'


#   __         _   _ 
#  (_ _|_    _|_ _|_ 
#  __) |_ |_| |   |  
#                                       

# thefuck setup
eval $(thefuck --alias)

# FZF Configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Create Dir and CD into
mkcd () { mkdir -p "$1" && cd "$1"; }
# Reload Shell
reload() { source ~/.zshrc; }

# Automatically activate poetry environment if pyproject.toml is present in current or parent directories
function check_poetry_env() {
    local dir="$PWD"
    local poetry_bin="$HOME/.local/bin/poetry"  # Replace with your Poetry path if different
    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/pyproject.toml" ]]; then
            # Check if already in a Poetry shell to avoid re-initializing
            if [[ -z "$POETRY_ACTIVE" ]]; then
                echo "Activating Poetry shell in $dir"
                "$poetry_bin" shell
            fi
            return 0
        fi
        dir=$(dirname "$dir")
    done
}

# Add a hook to run the check when changing directories
autoload -Uz add-zsh-hook
add-zsh-hook chpwd check_poetry_env

# Run the check initially when the terminal opens
check_poetry_env
