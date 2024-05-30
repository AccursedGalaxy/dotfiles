```
 ________     ______ ___________ _______ __   ___      _______  ________  
|"      "\   /    " ("     _   ")"     "|" \ |"  |    /"     "|/"       ) 
(.  ___  :) // ____  )__/  \\__(: ______)|  |||  |   (: ______|:   \___/  
|: \   ) ||/  /    ) :) \\_ /   \/    | |:  ||:  |    \/    |  \___  \    
(| (___\ |(: (____/ //  |.  |   // ___) |.  | \  |___ // ___)_  __/  \\   
|:       :)\        /   \:  |  (:  (    /\  |( \_|:  (:      "|/" \   :)  
(________/  \"_____/     \__|   \__/   (__\_|_)_______)_______|_______/   
```                                                                          
  _______  _______  _______  _______  _______  _______  _______  _______
  

## Welcome to My Configuration Universe! 🌌

This repository is my digital garden 🌱, a place where I nurture and grow my system configurations. It's more than just a backup; it's a portal 🌀 to my ideal working environment, carefully crafted and constantly evolving.

It is designed to transform your command-line experience into a streamlined, productive, and enjoyable environment. Here's what you can expect:
- **Enhanced Command-Line Interface:** Leveraging the power of `zsh` with a highly customizable prompt powered by Starship.
- **Productivity Boosters:** Includes plugins like `zsh-autosuggestions`, `zsh-syntax-highlighting`, `zsh-history-substring-search`, and `zsh-completions` to make your workflow smoother and more efficient.
- **Convenient Aliases:** A comprehensive set of aliases for common tasks, such as navigating directories, managing system updates, and handling git commands.
- **SSH Management:** Automated SSH agent configuration to manage your keys seamlessly.
- **Visual Enhancements:** Fun and functional additions like Pokémon colorscripts to keep your terminal lively.
- **Development Ready:** Pre-configured settings for `nvim`, making it easy to dive into coding right away.
- **Miscellaneous Tools:** Integration with tools like `thefuck` and `fzf` to correct mistakes and find files quickly.

### What's Inside?

- **Shell Magic 🐚:** My custom `zsh` configurations, fine-tuned for a magical command-line experience.
- **Desktop Alchemy 🎨:** Desktop environment settings that transform my workspace into a productivity elixir.

### How to Use My Dotfiles

1. **Clone and Conquer:**
   ```sh
   git clone --bare https://github.com/AccursedGalaxy/dotfiles.git $HOME/.cfg
   alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
   dotfiles checkout
   dotfiles config --local status.showUntrackedFiles no
   ```
   Clone the repository to your home directory and set up the alias for managing the dotfiles.

2. **Customization and Care:**
   - Personalize these dotfiles to match your preferences by editing the configuration files.
   - Use the provided aliases to quickly navigate and modify your settings.

### Zsh Configuration (`zshrc`)

This section provides an overview of the custom `zshrc` configuration included in this repository.

#### Path Configuration
Adjusts your `$PATH` to include custom binaries.
```sh
export PATH="$HOME/bin:/usr/local/bin:$PATH"
```

#### Starship Prompt
Initializes the Starship prompt for a sleek and minimalistic command-line interface.
```sh
eval "$(starship init zsh)"
```

#### Plugins and Autocompletion
Enhances your shell with plugins for autosuggestions, syntax highlighting, and more.
```sh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^[[C' autosuggest-accept # Use the right arrow key
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
autoload -U compinit && compinit
source ~/.zsh/zsh-you-should-use/you-should-use.plugin.zsh
```

#### Default Editor
Sets `nvim` as the default editor.
```sh
export VISUAL=nvim
export EDITOR="$VISUAL"
```

#### Visual Enhancements
Displays a random Pokémon colorscript on terminal start.
```sh
pokemon-colorscripts --no-title -s -r
```

#### SSH Agent Configuration
Automatically starts the SSH agent and adds the default SSH key if not already running.
```sh
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
```

#### Aliases
Custom aliases to streamline navigation, system management, and development tasks.
```sh
alias lvim='/home/robin/.local/bin/lvim'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias nvimconfig="cd ~/.config/nvim && nvim ."
alias coding="cd ~/github && conda activate DevEnv && nvim ."
alias hyper="cd ~/.config/hypr && nvim ."
alias update='sudo apt update && sudo apt upgrade'
alias install='sudo apt install'
alias remove='sudo apt remove'
alias search='apt search'
alias df='df -h'
alias du='du -h'
alias htop='sudo btop'
alias ports='netstat -tulanp'
alias myip='curl http://ipecho.net/plain; echo'
alias flushdns='sudo systemctl restart nscd'
alias meminfo='free -m -l -t'
alias cpuinfo='lscpu'
alias reboot='sudo systemctl reboot'
alias poweroff='sudo systemctl poweroff'
alias ls='exa --icons -F -H --group-directories-first --git -1'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -pv'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gpull='git pull'
alias glog='git log --oneline --decorate --graph'
alias grep='grep --color=auto'
alias c='clear'
alias cat='batcat'
alias countpy='find . -name "*.py" -not -path "*/migrations/*" -not -path "*/__pycache__/*" -not -path "*/.venv/*" -not -path "*/.git/*" -print0 | xargs -0 cat | wc -l'
alias fzcat='fzf --preview "batcat --color=always --style=header,grid --line-range :500 {}"'
```

#### Conda and Thefuck
Initializes Conda and sets up Thefuck alias.
```sh
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

eval $(thefuck --alias)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
```

### Disclaimer

🔒 Please be aware, for the sake of security, any sensitive or personal data has been excluded or anonymized.

---

Stay tuned for more updates and feel free to explore and get inspired! 🚀
