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

    Clone the latest release to your `$HOME` directory:

    ```sh
    latest_release=$(curl -s https://api.github.com/repos/AccursedGalaxy/dotfiles/releases/latest | grep "tarball_url" | cut -d '"' -f 4)
    curl -L $latest_release | tar -xz -C $HOME
    mv $HOME/AccursedGalaxy-dotfiles-* $HOME/.dotfiles
    ```

2. **Initialize the Repository:**

    Set up the dotfiles repository in your `$HOME` directory:

    ```sh
    git clone https://github.com/AccursedGalaxy/dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles
    ```

3. **Run Installation Scripts:**

    Run the individual install scripts to set up your environment. These scripts will add necessary sourcing lines to your respective configuration files like `.zshrc`.

    ```sh
    ./install.sh
    ```

4. **Update Your Dotfiles:**

    To keep your dotfiles up to date, simply run the update script inside the dotfiles directory:

    ```sh
    cd $HOME/.dotfiles
    ./update.sh
    ```

### Disclaimer

🔒 **Security Notice:** For the sake of security, any sensitive or personal data has been excluded or anonymized.

---

Stay tuned for more updates and feel free to explore and get inspired! 🚀
