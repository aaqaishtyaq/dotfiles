#!/usr/bin/env bash

###############################################################################
# Environment Variables                                                       #
###############################################################################

export TERM="xterm-256color"
export ZSH=/Users/$USER/.oh-my-zsh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
# export CHE_DOMAIN=$(kubectl get services --namespace ingress-nginx -o jsonpath='{.items[*].spec.clusterIP}')

#Locale setting for python iterm2
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Rollback BuildKit Docker
export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

GPG_TTY=$(tty)
export GPG_TTY
export PATH=~/.local/bin/scripts:$PATH

command -v nvim > /dev/null && EDITOR='nvim' || EDITOR='vi'
export EDITOR

export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
