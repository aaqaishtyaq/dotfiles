#!/usr/bin/env bash

# Setup Z Shell
# =========================================================
# - https://github.com/aaqaishtyaq/dotfiles
# - https://aaqa.dev

install_zsh() {
    echo "Install ZSH"
}

set_zsh_default() {
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! "$SHELL" == "$(command -v zsh)" ]]; then
        chsh -s "$(command -v zsh)"
    fi
}

setup_shell() {
    mkdir -p "$HOME"/.config/zsh.d/
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$HOME"/.config/zsh.d/zsh-autosuggestions
    git clone --depth=1 https://github.com/rupa/z.git "$HOME"/.config/zsh.d/z
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/.config/zsh.d/powerlevel10k
}

setup_shell
