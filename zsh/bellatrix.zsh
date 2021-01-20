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

gen-bellatrix() {
    local DIRR="%B%F{red}$(print-pwd) %f%b"
    local _OP="%B%F{blue}$%f%b "
    local __line_1="${DIRR}${_OP}"
    local __new_line="\n"
    echo "$__new_line$__line_1"
}

activate_bellatrix() {
    PROMPT='$(gen-bellatrix)'
}
