export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="bureau"

#Custom message when SSH and custom color
clear
fortune | cowsay -f tux
myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
echo "My Public IP address: ${myip}"

echo "$(uptime)"
echo ""

tmux list-sessions >/dev/null 2>&1
screen -ls >/dev/null 2>&1

if [ "$?" = "0" ] ; then
	  echo "Running tmux sessions:"
	    echo "$(tmux list-sessions)"
    else
	      echo "No running tmux sessions."
fi
echo ""

if [ "$?" = "0" ] ; then
	  echo "Running GNU Screen sessions:"
	    echo "$(screen -ls)"
    else
	      echo "No running GNU Screen sessions."
fi

      echo ""

plugins=(
  git zsh-syntax-highlighting zsh-autosuggestions
)

ZSH_AUTOSUGGEST_USE_ASYNC=true

export EDITOR='vim'

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias sl="ls -al"
alias glog="git log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $ZSH/oh-my-zsh.sh
