#!/usr/bin/env bash
#-------------------------#
# Environment Variables
#-------------------------#

export TERM="xterm-256color"
export ZSH=/Users/$USER/.oh-my-zsh
export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
# export CHE_DOMAIN=$(kubectl get services --namespace ingress-nginx -o jsonpath='{.items[*].spec.clusterIP}')

# Starship prompt config dir location
command -v starship > /dev/null \
  && export STARSHIP_CONFIG="${HOME}/.config/starship/starship.toml"

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

# basedir defaults, in case they're not already set up.
# http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
if [[ -z "$XDG_DATA_HOME" ]]; then
	export XDG_DATA_HOME="$HOME/.local/share"
fi

if [[ -z "$XDG_CONFIG_HOME" ]]; then
	export XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ -z "$XDG_CACHE_HOME" ]]; then
	export XDG_CACHE_HOME="$HOME/.cache"
fi
