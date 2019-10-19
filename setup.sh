#!/bin/bash

###############################################################################
# Setting Up Mac                                                              #
###############################################################################

echo "Running Mac setup. This would take a while. Please sit back and relax."

# Check for Homebrew
if test ! "$(command -v brew)"
then
  echo "Installing Homebrew for you."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install TMUX@2.8
# brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/834d93c87ea0f6c0c10295599b6b1fc7b4aded96/Formula/tmux.rb
# brew pin tmux


install_oh_my_zsh () {
    # Test to see if zshell is installed.  If it is:
    if [ -f /bin/zsh ] || [ -f /usr/bin/zsh ]; then
        # Install Oh My Zsh if it isn't already present
        if [[ ! -d $HOME/oh-my-zsh/ ]]; then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        fi
    fi
}

link_config () {
    cp -f "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak" 2>/dev/null || true
    cp -a ./tmux/. "$HOME"/.tmux/
    ln -sf .tmux/tmux.conf "$HOME"/.tmux.conf;

    mkdir -p ~/.config/nvim ~/.config/zsh ~/.config/vim ~/.config/tmux
    cp -a alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
    cp -a zsh/.zshrc ~/.config/zsh/zshrc
    cp -a vim/.vimrc ~/.config/vim/vimrc
    cp -a tmux/next/.tmux.conf ~/.config/tmux/tmux.conf
    ls -sf ~/.config/zsh/zshrc "$HOME"/.zshrc;
    ls -sf ~/.config/vim/vimrc "$HOME"/.vimrc;
    ls -sf ~/.config/tmux/tmux.conf "$HOME"/.tmux.conf;
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

install_nvm () {
    curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
}

# SSH Keygen, Add to ssh-agent and icloud Keychain
cp ssh/config ~/.ssh/

brew update
brew upgrade
brew bundle
brew cleanup && brew cask cleanup
install_oh_my_zsh
link_config
install_nvm
"$(brew --prefix)/opt/fzf/install"

exit 0
