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
brew tap caskroom/cask
brew tap caskroom/versions

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."

# Setup shell
brew install bash
brew install zsh zsh-completions
brew install shellcheck

# Install wget with IRI support
brew install wget --with-iri
brew install curl --with-ssl --with-ssh
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
brew install tmux
brew install cookiecutter
brew install node
brew install python3

# Native apps
brew tap phinze/homebrew-cask
brew install brew-cask

###############################################################################
# Install utilities                                                           #
###############################################################################

installcask spectacle # The most important software
brew cask install caskroom/versions/firefox-developer-edition
installcask google-chrome-dev
installcask android-file-transfer
installcask transmission
installcask numi #http://numi.io
# installcask skitch  # https://evernote.com/skitch/
installcask vlc # 'cause you have to have this
installcask dash  # awesome offline docs
installcask nvalt  # Fork of Notational Velocity
installcask boostnote # Awesome Electron based Note taking application

# Postgres 9 Database
brew install postgres
installcask pgadmin3
# ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
# launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
psql postgres -c 'CREATE EXTENSION "adminpack";'
sudo gem install pg

# Fonts
brew tap caskroom/fonts
installcask font-source-code-pro
installcask font-firacode-nerd-font

################################################################################
#                           Dev tools                                          #
################################################################################

installcask install virtualbox
installcask install docker
installcask install postman
installcask sublime-text
installcask visual-studio-code

# Some frontend stuff
brew install node
npm i -g postcss-cli
npm i -g autoprefixer

# Install custom stuff
installcask install telegram  # Telegram
installcask teamviewer # TeamViewer
installcask install slack # Slack
brew install tor #TOR

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
            brew install zsh
            exit
        fi
    fi
}

install_oh_my_zsh

###############################################################################
# Zsh                                                                         #
###############################################################################

set -P
# Zsh Syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting

# Install Powerlevel9k theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# Remove outdated versions from the cellar
brew cleanup && brew cask cleanup

exit 0
