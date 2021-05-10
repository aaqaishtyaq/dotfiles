#!/usr/bin/env bash
#-------------------------#
# Paths
#-------------------------#

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Export path for openssl
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

export PATH=~/.local/bin/scripts:$PATH

# # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
export GEM_PATH="$HOME/.asdf/shims/"
export PATH="$GEM_PATH/bin:$PATH"

export GOPATH="${HOME}/.local/go"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH:$GOBIN


if [[ "${MACOS}" ]];then
  . $(brew --prefix asdf)/asdf.sh
fi

# Rust stuff
if [ -f "$HOME/.cargo/env" ]; then source "$HOME/.cargo/env"; fi

# shellcheck disable=SC2206
fpath=(${ASDF_DIR}/completions $fpath)

# shellcheck disable=SC1091
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"; fi

# shellcheck disable=SC1091
# The next line enables shell command completion for gcloud.
if [ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"; fi
