#!/usr/bin/env zsh

# .zshrc - z shell configuration
# =========================================================
# - https://github.com/aaqaishtyaw/dotfiles
# - https://aaqa.dev

#-------------------------#
# BASE - Environment
#-------------------------#
command -v nvim > /dev/null && EDITOR='nvim' || EDITOR='vi'
export EDITOR


#-------------------------#
# Aliases
#-------------------------#

if [ -n "$MACOS" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

alias la='ls -lah'
alias lh='ls -lh'
alias ll='ls -l'
alias sl="ls -al"
alias grep='grep --color=auto'
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias glog="git log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias k='kubectl'

#-------------------------#
# Options
#-------------------------#
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=100000
REPORTTIME=3
setopt hist_ignore_all_dups hist_ignore_space share_history extended_history
setopt hist_expire_dups_first
setopt autocd correct extended_glob notify prompt_subst

unsetopt beep correct_all
bindkey -e
autoload -U select-word-style
select-word-style bash


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

# Gray color for autosuggestions
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'
# async autosuggest
# ZSH_AUTOSUGGEST_USE_ASYNC=true


#-------------------------#
# Prompt
#-------------------------#
# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[cyan]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
LS_COLORS=$LS_COLORS:'di=1;36:'
export LS_COLORS

# generate
# gen-prompt() {
#     local prev_exit="$?"
#     local user_color="red"

#     if [ $prev_exit -eq 1 ]; then
#         user_color="yellow"
#     fi

#     if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
#         user_color="cyan"
#     fi

#     # local CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")
#     # local k8s_context = echo "(k8s: ${CONTEXT})"
#     # [%B%F{$k8s_context}%B%F{red}]%f

#     ## Generate a simple, informative multiline prompt.
#     local _line_1="%B%F{$user_color}┌─[ %B%F{cyan}%1~ %f%F{$user_color}]"
#     local _line_2="%B%F{$user_color}└─%(!.#.>)%f "

#     local git_branch=$(git symbolic-ref --short HEAD 2> /dev/null || {
#         git rev-list --max-count=1 HEAD 2>/dev/null | cut -c 1-8
#     })

#     # Render git info, if available, in the prompt.
#     if [ "$git_branch" ]; then
#         is_dirty() {
#           test -n "$(git status --porcelain --ignore-submodules)"
#         }

#         # ±
#         PLUSMINUS="\u00b1"

#         local _git_status="$git_branch"
#         if is_dirty; then
#           color=yellow
#           _git_status="${_git_status} $PLUSMINUS"
#         else
#           color=green
#           _git_status="${_git_status}"
#         fi

#         _line_1="$_line_1 %B%F{$color}%b[$_git_status]%f"
#     fi

#     # Render python virtual env info, if available, in the prompt.
#     if [[ -n "$VIRTUAL_ENV" ]];then
#         local _venv_prompt=""
#         _line_1="$_line_1 %F{blue}($(basename "$VIRTUAL_ENV"))%f"
#     fi

#     local _newline=$'\n'

#     echo "$_line_1$_newline$_line_2"
# }

# PROMPT='$(gen-prompt)'

gen-prompt () {
    local prev_exit="$?"
    local user_color="green"

    if [ $prev_exit -eq 1 ]; then
        user_color="red"
    fi

    local host_color="green"

    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        host_color="red"
    fi

    ## Generate a simple, informative multiline prompt.
    local _line_1="%F{blue}┌─[%B%F{$user_color}%n%f%b@%F{${host_color}}%m%f%F{blue}]-[%F{yellow}%*%f%F{blue}]%f"
    local _line_2="%F{blue}└─%(!.#.>)%f "

    local git_branch=$(git symbolic-ref --short HEAD 2> /dev/null || {
        git rev-list --max-count=1 HEAD 2>/dev/null | cut -c 1-8
    })

    # Render git info, if available, in the prompt.
    if [ "$git_branch" ]; then
        local _git_status="$git_branch$([ "$(git status --porcelain)" ] && echo "*")"
        _line_1="$_line_1 %B%F{green}±%b %F{cyan}($_git_status)%f"
    fi

    # Render python virtual env info, if available, in the prompt.
    if [[ -n "$VIRTUAL_ENV" ]];then
        local _venv_prompt=""
        _line_1="$_line_1 %F{blue}($(basename "$VIRTUAL_ENV"))%f"
    fi

    local _newline=$'\n'

    echo "$_line_1$_newline$_line_2"
}

#-------------------------#
# Prompt
#-------------------------#
if [ -x "$(command -v starship)" ] && \
    [ -f $HOME/.config/starship.toml ] && \
    [ -n "$MACOS" -o -n "$DISPLAY" ]; then
    eval "$(starship init zsh)"
else
    PROMPT='$(gen-prompt)'
    RPROMPT="%F{green}%~%f"
fi

export EDITOR='vim'
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
