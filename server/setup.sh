#!/usr/bin/env bash

echo "Beginning with Debian setup. Have a walk while the machine is setup"

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install git neofetch fortune cowsay wget curl htop tmux dnsutils screen
sudo apt-get -y install python3-pip
sudo apt-get -y install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Zsh Syntax highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
cp -rf .zshrc ~/
cp .vimrc ~/
cp .screenrc ~/
tmuxconf

sudo chsh -s "$(command -v zsh)"



exit 0
