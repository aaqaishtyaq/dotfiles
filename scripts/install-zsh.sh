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
    local zsh_plugin_dir="${HOME}/.config/zsh.d/lib/plugins"

    mkdir -p "${zsh_plugin_dir}"
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${zsh_plugin_dir}/zsh-autosuggestions"
    git clone --depth=1 https://github.com/rupa/z.git "${zsh_plugin_dir}/z"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${zsh_plugin_dir}/powerlevel10k"
}

setup_shell
