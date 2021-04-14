#!/usr/bin/env bash

###############################################################################
# Alias                                                                       #
###############################################################################

if [ "$MACOS" ]; then
   alias dircolors='gdircolors'
   alias date='gdate'
fi

if [ -n "$MACOS" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

command -v nvim &>/dev/null && alias vim='nvim'

# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias sl="ls -al"
alias brewclean="brew update && brew upgrade && brew cleanup; brew doctor"
alias glog="git log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias dev='cd $HOME/Developer'
alias hr="cd ~/Developer/hackerrank/"
alias kctx="kubectx"
alias kx="kubectx"
alias kns="kunens"
alias ctags='/usr/local/bin/ctags'
alias e='nvim'
alias chmox="chmod u+x"
alias ipinfo="curl ipinfo.io"
alias weather="curl wttr.in"
alias more='less -R'
alias cl="clear"
alias grep='grep --color=auto'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias k='kubectl'
alias tm="byobu-tmux"
