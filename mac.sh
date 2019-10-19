#!/bin/bash

###############################################################################
# Setting Up Mac                                                           #
###############################################################################

echo "Running Mac setup. This would take a while. Please sit back and relax."

# Check for Homebrew
if test ! "$(which brew)"
then
  echo "Installing Homebrew for you."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Install homebrew cask
brew tap homebrew/cask-cask
brew tap caskroom/versions



# Install wget with IRI support
# brew install wget --with-iri
# brew install curl --with-ssl --with-ssh
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Utility function to install cask formulas
function installcask() {
    if brew cask info "${@}" | grep "Not installed" > /dev/null; then
        brew cask install "${@}"
    else
        echo "$* is already installed."
    fi
}

# Install everything else
brew install git git-extras hub
brew install diff-so-fancy
brew install shellcheck

# Native apps
brew tap phinze/homebrew-cask
brew install brew-cask

###############################################################################
# Install utilities                                                           #
###############################################################################

# installcask spectacle # window management
brew cask install caskroom/versions/firefox-developer-edition
installcask google-chrome
installcask android-file-transfer
installcask transmission
installcask numi #http://numi.io
# installcask skitch  # https://evernote.com/skitch/
installcask vlc # 'cause you have to have this
# installcask dash  # awesome offline docs
# installcask nvalt  # Fork of Notational Velocity
# installcask boostnote # Awesome Electron based Note taking application


# Fonts
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
brew cask install font-firacode-nerd-font-mono
brew cask install font-sourcecodepro-nerd-font

################################################################################
#                           Dev tools                                          #
################################################################################

installcask install docker
installcask install postman
installcask visual-studio-code

# installcask install virtualbox

# Install TMUX@2.8
# brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/834d93c87ea0f6c0c10295599b6b1fc7b4aded96/Formula/tmux.rb
# brew pin tmux
brew install tmux


################################################################################
#                           Customize Shell                                    #
################################################################################

install_oh_my_zsh () {
    # Test to see if zshell is installed.  If it is:
    if [ -f /bin/zsh ] || [ -f /usr/bin/zsh ]; then
        # Install Oh My Zsh if it isn't already present
        if [[ ! -d $HOME/oh-my-zsh/ ]]; then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        fi
        # Set the default shell to zsh if it isn't currently set to zsh
        if [[ ! "$SHELL" == $(which zsh) ]]; then
            chsh -s "$(which zsh)"
        fi
    else
        # If zsh isn't installed, get the platform of the current machine
        platform=$(uname);
        # If the platform is Linux, try an apt-get to install zsh and then recurse
        if [[ $platform == 'Linux' ]]; then
            if [[ -f /etc/redhat-release ]]; then
                sudo yum install zsh
            fi
            if [[ -f /etc/debian_version ]]; then
                sudo apt-get install zsh
            fi
        # If the platform is OS X, tell the user to install zsh :)
        elif [[ $platform == 'Darwin' ]]; then
            echo "We'll install zsh, then re-run this script!"
            brew install zsh zsh-completions
            exit
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


###############################################################################
# Zsh                                                                         #
###############################################################################

set -P
# Zsh Syntax highlighting and Autosuggestion
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash


# SSH Keygen, Add to ssh-agent and icloud Keychain
cp ssh/config ~/.ssh/
# ssh-add -K ~/.ssh/id_rsa


# Remove outdated versions from the cellar
brew cleanup && brew cask cleanup

source ~/.zshrc
link_config
brew install golang
brew install fzf

$(brew --prefix)/opt/fzf/install
install_oh_my_zsh
exit 0
