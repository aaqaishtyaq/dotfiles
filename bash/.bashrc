# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

# Bash alias
alias venv='source venv/bin/activate'

#Color prompt
export PS1='\[\e[1;32m\]\u@\h:\w${text}$\[\e[m\] '

# Custom message when SSH and custom color
clear
fortune | cowsay -f tux
echo "$(uptime)"
echo ""

tmux list-sessions >/dev/null 2>&1
if [ "$?" = "0" ] ; then
  echo "Running tmux sessions:"
  echo "$(tmux list-sessions)"
else
  echo "No running tmux sessions."
fi

echo ""
