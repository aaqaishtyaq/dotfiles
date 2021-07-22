#!/usr/bin/env bash
#-------------------------#
# Paths
#-------------------------#

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

GNU_SED_PATH="/usr/local/opt/gnu-sed/libexec"
OPENSSL_PATH="/usr/local/opt/openssl@1.1"
GEM_PATH="$HOME/.asdf/shims"

export                        PATH="$HOME/.local/bin/scripts:$PATH"
[ -d "${GNU_SED_PATH}" ]  &&  PATH="$GNU_SED_PATH/gnubin:$PATH"
[ -d "${OPENSSL_PATH}" ]  &&  PATH="$OPENSSL_PATH/bin:$PATH"
[ -d "${GEM_PATH}" ]      &&  PATH="$GEM_PATH/bin:$PATH"

export GOPATH="${HOME}/Developer/go"
export GOBIN=$GOPATH/bin

export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOBIN
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:~/.local/bin
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
