#Install
sudo -v
install_util_linux() {
    platform=$(uname);
            if [[ $platform == 'Linux' ]]; then
                if [[ -f /etc/redhat-release ]]; then
                    sudo yum -y update
                    sudo yum -y upgrade
                    sudo yum -y install fortune cowsay tmux git
                fi
                elif [[ -f /etc/debian_version ]]; then
                    sudo apt-get update
                    sudo apt-get upgrade
                    sudo apt-get install fortune cowsay tmux git
                fi
        fi
}

install_util_linux

mkdir -p ~/migrations
cp ~/.bashrc ~/migrations
sudo cp .bashrc ~/
