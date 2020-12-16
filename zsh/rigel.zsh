#!/usr/bin/env bash

###############################################################################
# Rigel                                                                       #
###############################################################################

gen-prompt () {
    local prev_exit="$?"
    local user_color="red"

    if [ $prev_exit -eq 1 ]; then
        user_color="yellow"
    fi

    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        user_color="blue"
    fi

    # local CONTEXT=$(cat ~/.kube/config | grep "current-context:" | sed "s/current-context: //")
    # local k8s_context = echo "(k8s: ${CONTEXT})"
    # [%B%F{$k8s_context}%B%F{red}]%f

    ## Generate a simple, informative multiline prompt.
    local _line_1="%B%F{$user_color}┌─[ %B%F{blue}%1~ %f%F{$user_color}]"
    local _line_2="%F{$user_color}└─%(!.#.>)%f "

    # shellcheck disable=SC2155
    local git_branch=$(git symbolic-ref --short HEAD 2> /dev/null || {
        git rev-list --max-count=1 HEAD 2>/dev/null | cut -c 1-8
    })

    # Render git info, if available, in the prompt.
    if [ "$git_branch" ]; then
        is_dirty() {
          test -n "$(git status --porcelain --ignore-submodules)"
        }

        # ±
        PLUSMINUS="\u00b1"

        local _git_status="$git_branch"
        if is_dirty; then
          color=yellow
          _git_status="${_git_status} $PLUSMINUS"
        else
          color=green
          _git_status="${_git_status}"
        fi

        _line_1="$_line_1 %B%F{$color}%b[$_git_status]%f"
    fi

    # Render python virtual env info, if available, in the prompt.
    if [[ -n "$VIRTUAL_ENV" ]];then
        local _venv_prompt=""
        _line_1="$_line_1 %F{cyan}($(basename "$VIRTUAL_ENV"))%f"
    fi

    local _newline=$'\n'

    echo "$_line_1$_newline$_line_2"
}

activate_rigel() {
    PROMPT="$(gen-prompt)"
}
