#!/usr/bin/env bash

# .zshrc - z shell configuration
# =========================================================
# - https://github.com/aaqaishtyaw/dotfiles
# - https://aaqa.dev

# source shell config
for file in ~/.config/zsh/*.zsh; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done

NEW_PROMPT=false

# Do not load p10k if want new prompt
if [ "$NEW_PROMPT" = true ]; then
	activate_rigel
else
	ZSH_THEME="powerlevel10k/powerlevel10k"
fi

plugins=(
  git osx zsh-autosuggestions zsh-z kubectl minikube
)

ZSH_AUTOSUGGEST_USE_ASYNC=true
EDITOR=nvim

###############################################################################
# Git                                                                         #
###############################################################################
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

###############################################################################
# Source                                                                      #
###############################################################################

# Source the zsh
source "$ZSH/oh-my-zsh.sh"

# fsf (figure out  why it's not working before sourcing zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
