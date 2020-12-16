#!/usr/bin/env bash

###############################################################################
# Alias                                                                       #
###############################################################################

alias ls="ls -G"
alias le="exa -l"
alias tree-"exa -T"
alias ex_ip="dig +short myip.opendns.com @resolver1.opendns.com"
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