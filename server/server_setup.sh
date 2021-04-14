#!/usr/bin/env bash

echo "Beginning with Debian setup. Have a walk while the machine is setup"

basic_utilities() {
	sudo apt-get -y update && \
		sudo apt-get -y upgrade

	sudo apt-get -y install git \
		neofetch fortune cowsay \
		wget curl htop python3-pip \
		dnsutils screen tmux locales

	sudo locale-gen en_US.UTF-8

}

setup_shell() {
  mkdir -p "$HOME"/.config/zsh.d/
	git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME"/.config/zsh.d/zsh-autosuggestions
	git clone https://github.com/rupa/z.git "$HOME"/.config/zsh.d/z
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$HOME"/.config/zsh.d/powerlevel10k
}

link_config() {
	echo -e "\n\033[32mLinking Config!\033[0m"

	cp .zshrc "$HOME"/.zshrc
	cp .vimrc "$HOME"/.vimrc
	cp .screenrc "$HOME"/.screenrc
}


setup_zsh() {
	sudo apt -y install zsh
}

# Install docker
install_docker() {
	sudo apt-get -y install \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common

	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

	sudo add-apt-repository \
		"deb [arch=amd64] https://download.docker.com/linux/debian \
		$(lsb_release -cs) \
		stable"

	sudo apt-get update
	sudo apt-get -y install docker-ce docker-ce-cli containerd.io

	sudo usermod -aG docker "$USER"
	newgrp docker
}

basic_utilities
install_docker
link_config
setup_zsh

exit 0
