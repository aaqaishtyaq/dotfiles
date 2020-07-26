export ZSH=/Users/$USER/.oh-my-zsh

export TERM="xterm-256color"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git osx zsh-autosuggestions zsh-z kubectl minikube
)

ZSH_AUTOSUGGEST_USE_ASYNC=true

export SSH_KEY_PATH="~/.ssh/rsa_id"

###############################################################################
# Alias                                                                       #
###############################################################################

alias ls="ls -G"
alias le="exa -l"
alias tree-"exa -T"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias sl="ls -al"
alias brewclean="brew update && brew upgrade && brew cleanup; brew doctor"
alias glog="git log --all --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias dev="cd ${HOME}/Developer/"
alias hr="cd ~/Developer/hackerrank/"

#Locale setting for python iterm2
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

###############################################################################
# Powerline                                                                   #
###############################################################################

#PowerLine plugin
# source ~/.oh-my-zsh/custom/themes/powerlevel10k
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="000"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="007"
POWERLEVEL9K_DIR_HOME_BACKGROUND="001"
POWERLEVEL9K_DIR_HOME_FOREGROUND="000"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="001"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="000"
POWERLEVEL9K_RVM_BACKGROUND="black"
POWERLEVEL9K_RVM_FOREGROUND="249"
POWERLEVEL9K_RVM_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"
POWERLEVEL9K_TIME_FORMAT="\UF43A %D{%I:%M  \UF133  %d.%m.%y}"
POWERLEVEL9K_RVM_BACKGROUND="black"
POWERLEVEL9K_RVM_FOREGROUND="249"
POWERLEVEL9K_RVM_VISUAL_IDENTIFIER_COLOR="blue"
POWERLEVEL9K_NODE_VERSION_BACKGROUND="black"
POWERLEVEL9K_NODE_VERSION_FOREGROUND="green"
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='cyan'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='blue'
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_STATUS_VERBOSE=false
#POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
POWERLEVEL9K_VCS_COMMIT_ICON="\uf417"
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{red}\u256D\u2500%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{red}\u2570\uf460%f "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon ssh root_indicator virtualenv dir dir_writable vcs kubecontext)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rvm)
#(command_execution_time  status  time node_version)
HIST_STAMPS="mm/dd/yyyy"
DISABLE_UPDATE_PROMPT=true
POWERLEVEL9K_KUBECONTEXT_BACKGROUND='black'
POWERLEVEL9K_KUBECONTEXT_FOREGROUND='white'
POWERLEVEL9K_KUBECONTEXT_SHORTEN=(gke eks)
typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='k|kubectl|helm|kubens|kubectx|oc|istioctl|kogito'

###############################################################################
# Git                                                                         #
###############################################################################
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

export NVM_DIR="/Users/$USER/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# add global node_modules in NODE_PATH
export NODE_PATH="$(npm root -g)"

# Export path for openssl
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

# # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$GEM_HOME/bin:$PATH"
export PATH="$HOME/chectl/bin:$PATH"

# export CHE_DOMAIN=$(kubectl get services --namespace ingress-nginx -o jsonpath='{.items[*].spec.clusterIP}')

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/aaqa/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/aaqa/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/aaqa/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/aaqa/google-cloud-sdk/completion.zsh.inc'; fi

function kube() {
  if [ $commands[kubectl] ]; then
      source <(kubectl completion zsh)
  fi
}

export LDFLAGS="-L/usr/local/opt/mysql@5.7/lib"
export CPPFLAGS="-I/usr/local/opt/mysql@5.7/include"
export PKG_CONFIG_PATH="/usr/local/opt/mysql@5.7/lib/pkgconfig"
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# Source the zsh
source $ZSH/oh-my-zsh.sh

# fsf (figure out  why it's not working before sourcing zsh)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
