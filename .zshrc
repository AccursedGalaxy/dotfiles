export TERM=xterm-256color
# Personal aliases and configurations
# Include other personal configurations
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$(go env GOPATH)/bin
