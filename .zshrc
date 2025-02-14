# Terminal Configuration
export TERM=xterm-256color
unsetopt NO_CORRECT

#------------------
# Package Managers
#------------------
# Conda Configuration
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Bun Configuration
export BUN_INSTALL="$HOME/.bun"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
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
source $HOME/dotfiles/accursedzsh/.zshrc
source ~/.zsh-alias-tips/alias-tips.plugin.zsh
