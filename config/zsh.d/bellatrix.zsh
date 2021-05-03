#!/usr/bin/env zsh
#-------------------------#
# Bellatrix
#-------------------------#

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

# Echoes information about Git repository status when inside a Git repository
# (Adapted from code found at https://gist.github.com/joshdick/4415470.)
git_info() {

  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  local AHEAD=" %{$fg[magenta]%}⇡NUM%{$reset_color%}"
  local BEHIND=" %{$fg[cyan]%}⇣NUM%{$reset_color%}"
  local MERGING=" %{$fg[magenta]%}⚡︎%{$reset_color%}"
  local UNTRACKED=" %{$fg[yellow]%}!%{$reset_color%}"
  local MODIFIED=" %{$fg[blue]%}±%{$reset_color%}"
  local STAGED=" %{$fg[blue]%}●%{$reset_color%}"
  local GIT_STATUS_COLOR="green"

  local -a DIVERGENCES
  local -a FLAGS

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    FLAGS+=( "$MERGING" )
    GIT_STATUS_COLOR="magenta"
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    FLAGS+=( "$UNTRACKED" )
    GIT_STATUS_COLOR="yellow"
  fi

  if ! git diff --quiet 2> /dev/null; then
    FLAGS+=( "$MODIFIED" )
    GIT_STATUS_COLOR="blue"
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    FLAGS+=( "$STAGED" )
    GIT_STATUS_COLOR="blue"
  fi

  if $(git rev-parse --verify refs/stash &>/dev/null); then
    local STASHED=" %{$fg[$GIT_STATUS_COLOR]%}☗%{$reset_color%}"
    FLAGS+=( "$STASHED" )
  fi

  local -a GIT_INFO
  GIT_INFO+=( "%{$fg_bold[$GIT_STATUS_COLOR]%}$GIT_LOCATION%{$reset_color%}" )
  [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
  [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
  echo " ${(j: :)GIT_INFO}"

}

gen-bellatrix() {
  local host_color='red'

  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    host_color="blue"
    local user="%F{blue}%n%f"
    local host="%F{blue}%m%f"
    local seg_1="$user@$host "
  fi

  local dir="${seg_1}%B%F{${host_color}}$(print-pwd)%f%b"

  echo "${dir}$(git_info) %B%F{blue}%#%b%f "
}

activate_bellatrix() {
  PROMPT='$(gen-bellatrix)'
}
