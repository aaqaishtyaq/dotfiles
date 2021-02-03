#!/usr/bin/env bash

###############################################################################
# Alias                                                                       #
###############################################################################

if [ "$MACOS" ]; then
   alias dircolors='gdircolors'
   alias date='gdate'
fi

alias ls="ls -G -h"
alias le="exa -l"
alias tree-"exa -T"
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
which vim &>/dev/null && alias vim='nvim'
