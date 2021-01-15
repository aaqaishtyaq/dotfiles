#!/usr/bin/env bash

# Setup Z Shell
# =========================================================
# - https://github.com/aaqaishtyaq/dotfiles
# - https://aaqa.dev

install_oh_my_zsh () {
    # Test to see if zshell is installed.  If it is:
    if [ -f /bin/zsh ] || [ -f /usr/bin/zsh ]; then
        # Install Oh My Zsh if it isn't already present
        if [[ ! -d $HOME/oh-my-zsh/ ]]; then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        fi
    fi
}

setup_ohmyzsh () {
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    git clone https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
    git clone https://github.com/agkozak/zsh-z "$ZSH_CUSTOM/plugins/zsh-z"

    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! "$SHELL" == "$(command -v zsh)" ]]; then
        chsh -s "$(command -v zsh)"
    fi
}

install_oh_my_zsh
setup_ohmyzsh
