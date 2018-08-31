#!/usr/bin/env bash

echo "Beginning with Debian setup. Have a walk while the machine is setup"

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install git neofetch fortune cowsay wget curl htop
sudo apt-get -y install python3-pip
sudo apt-get -y install zsh
sudo pip3 install powerline-status
sudo apt-get install fonts-powerline
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s "$(which zsh)"
# Zsh Syntax highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

tmuxconf() {
    mkdir tmux
    cd tmux
    git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
}

tmuxconf
exit 0
