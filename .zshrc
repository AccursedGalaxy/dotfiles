# Terminal Configuration
export TERM=xterm-256color
unsetopt NO_CORRECT

#------------------
# Package Managers
#------------------
# Conda Configuration
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

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Bun Configuration
export BUN_INSTALL="$HOME/.bun"
[ -s "/home/robin/.bun/_bun" ] && source "/home/robin/.bun/_bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#------------------
# Language Paths
#------------------
# Go Configuration
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$GOPATH/bin

#------------------
# Source Files
#------------------
# Load main configuration
source /home/robin/dotfiles/accursedzsh/.zshrc
source ~/.zsh-alias-tips/alias-tips.plugin.zsh
