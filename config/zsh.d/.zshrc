#!/usr/bin/env bash

# .zshrc - z shell configuration
# =========================================================
# - https://github.com/aaqaishtyaw/dotfiles
# - https://aaqa.dev

if [[ $(uname -a) =~ Darwin ]]; then
    MACOS=true
fi

# source shell config
for file in ~/.config/zsh.d/*.zsh; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done

# Export History variables
HISTFILE=~/.config/zsh.d/.zsh_history
HISTSIZE=50000
SAVEHIST=100000

#-------------------------#
# Completion
#-------------------------#
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename "$HOME/.zshrc"
bindkey '^[n' expand-or-complete
bindkey '^[p' reverse-menu-complete
bindkey '^[[Z' reverse-menu-complete

fpath+=~/.zfunc

autoload -Uz compinit

# Instead of having compinit happen on every prompt, use the cached version in
# the prompt and have it re-load every 5 minutes via Cron
# * * * * * zsh -i -c 'compinit'
if [[ "$MACOS" && $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]]; then
	compinit;
elif [[ -n $HOME/.zcompdump(#qN.mh+1) ]]; then
	compinit;
else
	compinit -C;
fi;

# emacs style keybindings
bindkey -e

#-------------------------#
# Prompt
#-------------------------#
if [ -x "$(command -v starship)" ] && [ -f $HOME/.config/starship.toml ]; then
    eval "$(starship init zsh)"
elif [ -f "$HOME/.config/zsh.d/powerlevel10k/powerlevel10k.zsh-theme" ]; then
    source "$HOME/.config/zsh.d/powerlevel10k/powerlevel10k.zsh-theme"
    ZSH_THEME="powerlevel10k/powerlevel10k"
else
    activate_bellatrix
fi

if command -v grep &>/dev/null; then
  if [ -r ~/.config/dircolors/dircolors ]; then
    eval "$(dircolors -b ~/.config/dircolors/dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

# syntax highlighting
[ -f ~/.config/zsh.d/zsh-autosuggestions/zsh-autosuggestions.zsh ] \
    && source ~/.config/zsh.d/zsh-autosuggestions/zsh-autosuggestions.zsh

# Async autosuggest
ZSH_AUTOSUGGEST_USE_ASYNC=true

# autojump using z
[ -f ~/.config/zsh.d/z/z.sh ] && source ~/.config/zsh.d/z/z.sh

# fsf (figure out  why it's not working before sourcing zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
