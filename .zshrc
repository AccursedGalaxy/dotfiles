export TERM=xterm-256color
# Personal aliases and configurations
# Include other personal configurations
# Dotfile Management
alias d='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias sentinel='cd ~/github/SentinelBot/ && conda activate SentinelEnv && nvim .'
alias dcabot='cd ~/github/Fitzo-Crypto-DCA-Bot/ && conda activate FitzoCryptoDCAEnv && nvim .'
alias azsh="cd /home/robin/dotfiles/accursedzsh && nvim .zshrc"
alias make='noglob make'

unsetopt NO_CORRECT

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
source /home/robin/dotfiles/accursedzsh/.zshrc
source ~/.zsh-alias-tips/alias-tips.plugin.zsh

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# bun completions
[ -s "/home/robin/.bun/_bun" ] && source "/home/robin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
