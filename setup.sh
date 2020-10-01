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

# SSH Keygen, Add to ssh-agent and icloud Keychain
cp ssh/config ~/.ssh/

tmux_28 () {
    brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/834d93c87ea0f6c0c10295599b6b1fc7b4aded96/Formula/tmux.rb
    brew pin tmux
}


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

install_nvm () {
    curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
}

add_ssh_to_keychain() {
# If you're using macOS Sierra 10.12.2 or later, you will need to modify your ~/.ssh/config file to automatically load keys into the ssh-agent and store passphrases in your keychain.

    if [ -e ~/.ssh/config ]
    then
        echo "ssh config already exists. Skipping adding osx specific settings... "
    else
	    echo "Writing osx specific settings to ssh config... "
      cat <<EOT >> ~/.ssh/config
    	Host *
		    AddKeysToAgent yes
		    UseKeychain yes
		    IdentityFile ~/.ssh/id_rsa
EOT
fi
}

echo "Generating ssh keys, adding to ssh-agent..."
read -r -p 'Input email for ssh key: ' useremail

echo "Use default ssh file location, enter a passphrase: "
ssh-keygen -t rsa -b 4096 -C "$useremail"  # will prompt for password
eval "$(ssh-agent -s)"

# Now that sshconfig is synced add key to ssh-agent and
# store passphrase in keychain
ssh-add -K ~/.ssh/id_rsa
add_ssh_to_keychain

brew update
brew upgrade
brew bundle
brew cleanup && brew cask cleanup
install_oh_my_zsh
setup_ohmyzsh
install_nvm
"$(brew --prefix)/opt/fzf/install"

exit 0
