#!/usr/bin/env bash

###############################################################################
# Rigel                                                                       #
###############################################################################

gen-prompt() {
    local prev_exit="$?"
    local user_color="blue"

    if [ $prev_exit -eq 1 ]; then
        user_color="red"
    fi

    local host_color="green"

    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        user_color="red"
        host_color="red"
    fi

    local DIR=" %B%F{blue}%2~ %f%b"
    local HOST="%F{${host_color}}%m%f"
    SEG_1="$DIR"

    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        local USER="%B%F{$user_color}%n%f%b"
        SEG_1="$USER@$HOST"
        RPROMPT="%F{green}%~%f"
    fi

    ## Generate a simple, informative multiline prompt.
    local _line_1="%F{red}┌─[$SEG_1%F{red}]%f"
    local _line_2="%F{red}└─%(!.#.>)%f "

    local git_branch=$(git symbolic-ref --short HEAD 2>/dev/null || {
        git rev-list --max-count=1 HEAD 2>/dev/null | cut -c 1-8
    })

    # Render git info, if available, in the prompt.
    if [ "$git_branch" ]; then
        local _git_status="$([ "$(git status --porcelain)" ] && echo "*")"
        local _git_status_color="green"

        # Ensure the index is up to date.
        git update-index --really-refresh -q &>/dev/null

        # Check for stashed files.
        if $(git rev-parse --verify refs/stash &>/dev/null); then
            _git_status='?'
        fi

        # Check for untracked files.
        if [ -n "$(git ls-files --others --exclude-standard)" ]; then
            _git_status_color="yellow"
            _git_status=' !'
        fi

        # Check for unstaged changes.
        if ! $(git diff-files --quiet --ignore-submodules --); then
            _git_status_color="blue"
            _git_status='*'
        fi

        # Check for uncommitted changes in the index.
        if ! $(git diff --quiet --ignore-submodules --cached); then
            _git_status_color="blue"
            _git_status='+'
        fi

        _line_1="$_line_1 %B%F{magenta}±%b %F{$_git_status_color}($git_branch$_git_status)%f"
    fi

    # Render python virtual env info, if available, in the prompt.
    if [[ -n "$VIRTUAL_ENV" ]]; then
        local _venv_prompt=""
        _line_1="$_line_1 %F{blue}($(basename "$VIRTUAL_ENV"))%f"
    fi

    local _newline=$'\n'

    echo "$_line_1$_newline$_line_2"
}

activate_rigel() {
    PROMPT='$(gen-prompt)'
}
