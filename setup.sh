#! /usr/bin/env bash

# setup - system setup script for macOS
# =========================================================
# - https://github.com/aaqaishtyaq/dotfiles
# - https://aaqa.dev

echo "Running Mac setup. This would take a while. Please sit back and relax."

# Check for Homebrew
if test ! "$(command -v brew)"
then
  echo "Installing Homebrew for you."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

tmux_28 () {
    brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/834d93c87ea0f6c0c10295599b6b1fc7b4aded96/Formula/tmux.rb
    brew pin tmux
}

setup_neovim() {
    # Install Plug
    # shellcheck disable=SC1004
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

brew update
brew upgrade
brew bundle
brew cleanup && brew cask cleanup

exit 0
