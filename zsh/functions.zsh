#!/usr/bin/env bash

###############################################################################
# Functions                                                                   #
###############################################################################

# Start local_ops
ops() {
    local task="${1:-start}"
    if [[ $task == 'start' ]]; then
        local_ops okta login
    else
        echo -e "\n\033[33mSkipping OKTA Login\033[0m\n"
    fi
    local_ops "$task" -s hrw-slim --tmux
}

_rspec() {
    command="RAILS_ENV=test rspec $1"
    local_ops run -s hrw-rails -c "exec" -a "$command && exit"
}

# Change aws profile
aws-prf() {
    local PROFILE="${1:-hr-dev}"
    export AWS_PROFILE="$PROFILE"
}

# list_out_all_256_colors
color_ls() {
    for i in {0..255} ; do
        printf "\x1b[48;5;%sm%3d\e[0m " "$i" "$i"
        if (( i == 15 )) || (( i > 15 )) && (( (i-15) % 6 == 0 )); then
            printf "\n";
        fi
    done
}

# create a temporary file and open it for editing
tmpf() {
    ${EDITOR} +"set filetype=$1" + "/tmp/temp-$(date +'%Y%m%d-%H%M%S')"
}

# Exec into che containers
_kx() {
    local KOUTPUT
    local NAMESPACE
    local POD
    local CONTAINER
    KOUTPUT=$(kubectl get pods --all-namespaces | grep "$1")
    NAMESPACE=$(echo "$KOUTPUT" | awk '{print $1}')
    POD=$(echo "$KOUTPUT" | awk '{print $2}')
    CONTAINER=${2:-dev}

    kubectl exec -it "$POD" -n "$NAMESPACE" -c "$CONTAINER" -- bash
}

# QA Rails Exec
_qx() {
    kubectx hr-qa
    local POD
    POD=$(kubectl get pods -n qatest | grep hrw-web-rails | awk 'FNR==1{print $1}')
    kubectl exec -it "$POD" -n qatest -c rails -- bash
}

# Private/PreProd Rails Exec
_px() {
    kubectx hr-private
    local NAMESPACE
    local POD
    NAMESPACE="${1:-rba}"
    POD=$(kubectl get pods -n "$NAMESPACE" | grep hrw-web-rails | awk 'FNR==1{print $1}')
    kubectl exec -it "$POD" -n "$NAMESPACE" -c rails -- bash
}

dots() {
    code "$HOME/Developer/dotfiles"
}

# create a temporary directory and enter it
tmpd() {
    local dir
    if [ $# -eq 0 ]; then
        dir=$(mktemp -d)
    else
        dir=$(mktemp -d -t "${1}.XXXXXXXXXX")
    fi
    cd "$dir" || exit
}

# exec into docker container
de() {
    local cid
    cid=$(docker ps -a --format "{{.ID}} \t{{.Names}}\t {{.Status}}\t{{.Image}}" | sed 1d | fzf -1 -q "$1" | awk '{print $1}')
    [ -n "$cid" ] && docker exec -it "$cid" bash
}

# serve current directory over http
serve() {
    local port="${1:-8000}"
    sleep 1 && open "http://localhost:${port}/" &

    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# better history command
fh() {
    print -z "$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history | uniq) | fzf +s --tac | sed 's/ *[0-9]* *//')"
}

# move to the top-level parent directory
cdp() {
    TEMP_PWD="$(pwd)"
    while ! [ -d .git ]; do
        cd ..
    done
    OLDPWD=$TEMP_PWD
}
