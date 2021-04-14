#!/usr/bin/env bash
#-------------------------#
# Alias
#-------------------------#

if [[ "${MACOS}" ]]; then
   alias dircolors='gdircolors'
   alias date='gdate'
fi

if [[ -n "${MACOS}" ]] && \
    command -v gls &>/dev/null; then
    alias ls='gls --color=auto'
else
    alias ls='ls --color=auto'
fi

command -v nvim &>/dev/null && alias vim='nvim'

# Brew
alias brewclean="brew update && brew upgrade && brew cleanup; brew doctor"

# git
alias ga="git add"
alias gb='git branch'
alias gbl='git blame -b -w'
alias gc="git commit -m"
alias gd='git diff'
alias gds='git diff --staged'
alias gfo='git fetch origin'
alias gl='git pull'
alias glog="git log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias gp='git push'
alias gpu='git push upstream'
alias gr='git remote'
alias gra='git remote add'
alias grv='git remote -v'
alias gs="git status"
alias gsh='git show'
alias gsi='git submodule init'

# k8s
alias k='kubectl'
alias kctx="kubectx"
alias kns="kunens"
alias kx="kubectx"

# List directory contents
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias lsa='ls -lah'
alias sl="ls -al"

# Utility
alias chmox="chmod u+x"
alias cl="clear"
alias ctags='/usr/local/bin/ctags'
alias e='nvim'
alias grep='grep --color=auto'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ipinfo="curl ipinfo.io"
alias more='less -R'
alias weather="curl wttr.in"

# workspace
alias dev='cd $HOME/Developer'
alias hr="cd ~/Developer/hackerrank/"
alias tm="byobu-tmux"
