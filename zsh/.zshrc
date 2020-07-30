#!/usr/bin/env bash

###############################################################################
# zshrc                                                                       #
###############################################################################

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/aaqa/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/aaqa/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/aaqa/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/aaqa/google-cloud-sdk/completion.zsh.inc'; fi

# Source the zsh
source $ZSH/oh-my-zsh.sh

# fsf (figure out  why it's not working before sourcing zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
