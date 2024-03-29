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

# Path Configuration
# If coming from bash, you might need to change your $PATH.
export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Starship Configuration
eval "$(starship init zsh)"

# Plugins
plugins=( 
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Set  Default Editor
export VISUAL=nvim
export EDITOR="$VISUAL"

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

#  (                                             
#  )\ )    )               )               )     
# (()/( ( /(       (    ( /(        (   ( /(     
#  /(_)))\())  (   )(   )\()) (    ))\  )\())(   
# (_)) ((_)\   )\ (()\ (_))/  )\  /((_)(_))/ )\  
# / __|| |(_) ((_) ((_)| |_  ((_)(_))( | |_ ((_) 
# \__ \| ' \ / _ \| '_||  _|/ _| | || ||  _|(_-< 
# |___/|_||_|\___/|_|   \__|\__|  \_,_| \__|/__/ 

# Lunar Vim Because I can
alias lvim='/home/robin/.local/bin/lvim'

# Dotfile Management
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Navigation
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nvimconfig="cd ~/.config/nvim && nvim ." # Open nvim config in nvim netrw
alias getcoding="cd ~/github"
alias hyper="cd ~/.config/hypr && nvim ." # Open Hyper config in nvim netrw

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

alias la='ls -A'                                     # List all files in long format, including hidden files
alias l='ls -CF'                                     # List all files in long format, with file type indicators
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

# Miscellaneous
alias grep='grep --color=auto'                       # Colorized grep output
alias c='clear'                                      # Clear terminal display


#  __                   __         _   _ 
# (_   _ ._ o ._ _|_   (_ _|_    _|_ _|_ 
# __) (_ |  | |_) |_   __) |_ |_| |   |  
#             |                          


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/robin/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/robin/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/robin/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/robin/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
