#!/usr/bin/env bash

###############################################################################
# Environment Variables                                                       #
###############################################################################

export TERM="xterm-256color"
export ZSH=/Users/$USER/.oh-my-zsh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
# export CHE_DOMAIN=$(kubectl get services --namespace ingress-nginx -o jsonpath='{.items[*].spec.clusterIP}')

LS_COLORS=$LS_COLORS:'di=34:ln=35:so=32:pi=33:ex=31:bd=30;46:cd=30;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export LS_COLORS

#Locale setting for python iterm2
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Rollback BuildKit Docker
export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0

