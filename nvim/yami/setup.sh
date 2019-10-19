#!/bin/bash


# ----------------------------------
# Colors
# ----------------------------------

apply_patch () {
    pwd | pbcopy
    cp yami.patch "$HOME/.config/nvim/plugged/vim-yami/colors"
    cd "$HOME/.config/nvim/plugged/vim-yami/colors" || exit
    git apply yami.patch
    rm yami.patch
    cd "$(pbpaste)" || exit

}

apply_patch

exit 0
