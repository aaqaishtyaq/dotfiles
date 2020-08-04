#!/usr/bin/env bash

# .zshrc - z shell configuration
# =========================================================
# - https://github.com/aaqaishtyaw/dotfiles
# - https://aaqa.dev

# source shell config
for file in ~/.config/zsh/.zsh.{functions,prompt,exports,aliases,keybindings,paths}; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done

plugins=(
  git osx zsh-autosuggestions zsh-z kubectl minikube
)

ZSH_AUTOSUGGEST_USE_ASYNC=true

###############################################################################
# Git                                                                         #
###############################################################################
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

###############################################################################
# Source                                                                      #
###############################################################################

# work-specific configuration and exports
[ -f ~/.zsh.hackerrank ] && source ~/.zsh.hackerrank

# shellcheck disable=SC1091
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/aaqa/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/aaqa/google-cloud-sdk/path.zsh.inc'; fi

# shellcheck disable=SC1091
# The next line enables shell command completion for gcloud.
if [ -f '/Users/aaqa/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/aaqa/google-cloud-sdk/completion.zsh.inc'; fi

# add global node_modules in NODE_PATH
# shellcheck disable=SC2155
export NODE_PATH="$(npm root -g)"

# Source the zsh
source "$ZSH/oh-my-zsh.sh"

# fsf (figure out  why it's not working before sourcing zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
