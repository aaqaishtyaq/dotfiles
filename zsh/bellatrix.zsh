#!/usr/bin/env bash

###############################################################################
# Bellatrix                                                                       #
###############################################################################

print-pwd() {
    setopt localoptions extendedglob

    local pwd="${PWD/#$HOME/~}"
    local ret_directory

    if [[ "$pwd" == (#m)[/~] ]]; then
    ret_directory="$MATCH"
    unset MATCH
    else
    ret_directory="${${${${(@j:/:M)${(@s:/:)pwd}##.#?}:h}%/}//\%/%%}/${${pwd:t}//\%/%%}"
    fi

    unset pwd

    print "$ret_directory"
}

_gitstatus_() {

    # Render git info, if available, in the prompt.
    if [ "$git_branch" ]; then
        initial_status="$([ "$(git status --porcelain)" ] && echo " ")"
        local _git_status=($initial_status)
        local _git_status_color="green"

        # Ensure the index is up to date.
        git update-index --really-refresh -q &>/dev/null

        # Check for stashed files.
        if $(git rev-parse --verify refs/stash &>/dev/null); then
            _git_status+=('?')
        fi

        # Check for untracked files.
        if [ -n "$(git ls-files --others --exclude-standard)" ]; then
            _git_status_color="yellow"
            _git_status+=('!')
        fi

        # Check for unstaged changes.
        if ! $(git diff-files --quiet --ignore-submodules --); then
            _git_status_color="blue"
            _git_status+=('±')
        fi

        # Check for uncommitted changes in the index.
        if ! $(git diff --quiet --ignore-submodules --cached); then
            _git_status_color="blue"
            _git_status+=('●')
        fi

        _git_status=" %F{$_git_status_color}[$git_branch$_git_status]%f"
        echo $_git_status
    fi
}

gen-bellatrix() {
    local DIRR="%B%F{red}$(print-pwd)%f%b"
    local _OP="%B%F{blue} $%f%b "
    local __line_1="${DIRR}${_OP}"
    local git_branch=$(git symbolic-ref --short HEAD 2>/dev/null || {
        git rev-list --max-count=1 HEAD 2>/dev/null | cut -c 1-8
    })

    if [ $git_branch ]; then
        git_status="$(_gitstatus_)"
        __line_1="${DIRR}${git_status}${_OP}"
    fi

    local __new_line="\n"
    echo "$__new_line$__line_1"
}

activate_bellatrix() {
    PROMPT='$(gen-bellatrix)'
}
