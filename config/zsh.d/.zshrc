#!/usr/bin/env zsh

# .zshrc - z shell configuration
# =========================================================
# - https://github.com/aaqaishtyaw/dotfiles
# - https://aaqa.dev

[[ $- != *i* ]] && return

if [[ $(uname -a) =~ Darwin ]]; then
  MACOS=true
fi

ZSH="${HOME}/.config/zsh.d"

if [ -d "${ZSH}" ]; then
  mkdir -p "${ZSH}"
fi

# Export History variables
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
export ZSH_CACHE_DIR"=${ZSH}/lib/cache"
export ZSH_PLUGIN_DIR="${ZSH}/lib/plugins"

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

# source shell config
for file in "${ZSH}"/*.zsh; do
	if [[ -r "$file" ]] && [[ -f "$file" ]]; then
		source "$file"
	fi
done

#-------------------------#
# Prompt
#-------------------------#
if [ -x "$(command -v starship)" ] && [ -f "${STARSHIP_CONFIG}" ] && [ -z "${NEW_PROMPT}" ]; then
  eval "$(starship init zsh)"
elif [ -f "${ZSH_PLUGIN_DIR}/powerlevel10k/powerlevel10k.zsh-theme" ] && [ -z "${NEW_PROMPT}" ]; then
  source "${ZSH_PLUGIN_DIR}/powerlevel10k/powerlevel10k.zsh-theme"
  light_saber
  ZSH_THEME="powerlevel10k/powerlevel10k"
else
  autoload -Uz add-zsh-hook
  _iay_prompt() {
    PROMPT="$(iay -zm)"
  }
  add-zsh-hook precmd _iay_prompt
fi

if command -v grep &>/dev/null; then
  if [ -r ~/.config/dircolors/dircolors ]; then
    eval "$(dircolors -b ~/.config/dircolors/dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

# syntax highlighting
[ -f "${ZSH_PLUGIN_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
  source "${ZSH_PLUGIN_DIR}/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Async autosuggest
ZSH_AUTOSUGGEST_USE_ASYNC=true

# autojump using z
[ -f "${ZSH_PLUGIN_DIR}/z/z.sh" ] && source "${ZSH_PLUGIN_DIR}/z/z.sh"

unset ZSH
unset ZSH_CACHE_DIR
unset ZSH_PLUGIN_DIR
unset GOOGLE_APPLICATION_CREDENTIALS

# fsf (figure out  why it's not working before sourcing zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
