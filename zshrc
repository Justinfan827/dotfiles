#zmodload zsh/zprof
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

#export TERM="xterm-256color"
# Path to your oh-my-zsh installation.
export ZSH="/Users/$USER/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
DEFAULT_USER=`whoami`

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    jump
    fzf
    aws
    web-search
    zsh-autosuggestions
)

# help zsh find nvm BEFORE oh my zsh is sourced
export NVM_DIR="$HOME/.nvm"
############################################################

# FZF settings

############################################################
# Set fzf installation directory path
export FZF_BASE=/path/to/fzf/install/dir
export FZF_DEFAULT_COMMAND='ag  --nocolor -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
# Helps with vims preview window
export BAT_THEME="TwoDark"

# Add Tmuxifier to bin path. It's for managing my tmuxlayouts
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"


#export FZF_DEFAULT_OPTS='
#--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
#--color info:108,prompt:109,spinner:108,pointer:168,marker:168
#'
# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

#autoload -Uz compinit
#if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  #compinit
#else
  #compinit -C
#fi

ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

############################################################

# Helpful functions 

############################################################

# call ls after cd is called
 function chpwd() {
    emulate -L zsh
    ls -a
}
# Split tmux pane into ide-style 3 windows
function ide() {
	tmux split-window -v -p 30
	tmux split-window -h -p 66
}

## fixssh in tmux 
function fixssh() {
	for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
		if (tmux show-environment | grep "^${key}" > /dev/null); then
			value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
			export ${key}="${value}"
		fi
	done
}

function tms() {
    tmux new -s $1 -d 
    tmux switch -t $1
}

############################################################

# Blend functions 

############################################################


# pure lending locally and point to connex
function lending() {
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    CONNECTIVITY_HOST=https://localhost:5005 npm start
}

# lending pointing to local UI
function localUIlending() {
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    CONNECTIVITY_HOST=https://localhost:5005 SERVE_CLIENT_LOCALLY=true npm start
}

# lending without the loggin
function quietLending() {
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    CONNECTIVITY_HOST=https://localhost:5005 BLEND_LOGGER_SKIP=true npm start
}

## just run connex and point to local lending
function connex() {
    cd ~/go/src/git.blendlabs.com/blend/connectivity
    LENDING_API_HOST=localhost:8080 LENDING_HOST=localhost:8080 make run
}

## just run connex and point to local lending
function cxadmin() {
    cd ~/go/src/git.blendlabs.com/blend/connectivity
    LOAN_TOOLBOX_URL=http://localhost:19222 AUTH_SERVER_HOST=auth-server.sandbox.k8s.centrio.com \
         AUTH_SERVER_USERNAME=connectivity-1ea1c5ffdc4f@service.blendlabs.com  AUTH_SERVER_PASSWORD=Ac0G3aETFxdU36JUv9j3BzziAcwWlnpG \
            make run-admin
}



function unsetConnex() {
    cd ~/go/src/git.blendlabs.com/blend/connectivity
    unset AWS_VAULT && aws-vault exec cx-dev --duration=12h --no-session
    LENDING_API_HOST=localhost:8080 LENDING_HOST=localhost:8080 make run
}

function unsetLending() {
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    unset AWS_VAULT && aws-vault exec lending-dev --duration=12h --no-session
    CONNECTIVITY_HOST=https://localhost:5005 npm start
}

## Whenever I get issues with the sqs queue during local dev
function purgeLocalSqs() {
    ## Make sure to connect as sandbox-dev first
    for queue in $(aws sqs list-queues --queue-name-prefix=dev-jfan --query 'QueueUrls[*]' --output text) ; \
    do aws sqs purge-queue --queue-url=$queue ; done

}

function svault() {
    export VAULT_ADDR=https://vault.sandbox.k8s.centrio.com:8200
    export VAULT_HOST=vault.sandbox.k8s.centrio.com:8200
    export VAULT_TOKEN=$(cat ~/.vault-token)
}


########## fzf functions

## fd - cd to selected directory
function fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# cdf - cd into the directory of the selected file
function cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# Search a file with fzf inside a Tmux pane and then open it in an editor
function vimf() {
  local file=$(fzf-tmux)
  # Open the file if it exists
  if [ -n "$file" ]; then
    # Use the default editor if it's defined, otherwise Vim
    ${EDITOR:-nvim} "$file"
  fi
}

############################################################

# Bindings 

############################################################



############################################################

# Aliases

############################################################

alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
# Displays previously merged commits in a pretty way
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

#

alias grep='grep --color'
alias mk='make'
alias chrome='chrome -a \"Google Chrome\"'
alias ssa='ssh -A'
alias aw='aws-vault'
alias jm='jump'

# Sourcing
alias sb='source ~/.bashrc'
alias sz='source ~/.zshrc'
alias st='tmux source-file ~/.tmux.conf'

# Git alias
alias gsb='git checkout $(git branch | fzf)'
alias g='git'
alias gc='git commit -m'
alias gp='git push'
alias gu='git pull'
alias gst='git status'

# Tmux aliases
alias tx='tmux'
alias txa=$'tmux a -t $(tmux ls | awk \'{print $1}\' | sed \'s/.$//\' | fzf)'
alias hsp="tmux split-window -h"
alias vsp="tmux split-window -v"


# Vim aliases
alias vaws='vim ~/.aws/config'
alias vi='nvim'
alias vim='nvim'
alias vimb='vim ~/.bashrc'
alias vimv='vim ~/.vimrc'
alias vimz='vim ~/.zshrc'
alias vimt='vim ~/.tmux.conf'
alias vf='vimf'
# open vim at root to avoid issues with coc tsserver
alias vlend='vim ~/repo/git.blendlabs.com/blend/lending/backend/Gruntfile.js'

# Docker
alias kb='kubectl'
alias kbconnect='eval $(minikube docker-env)'
alias docom='docker-compose'
alias doc='docker'
alias mkbe='minikube'


############################################################
# Environment variables
############################################################
export GITHUB_OAUTH_TOKEN="d3609a0cfd4c0d38fa0be0b315e2349ff00310c7"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#export WORKON_HOME=$HOME/.virtualenvs   # Optional
#export PROJECT_HOME=$HOME/projects      # Optional
#export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
#source /usr/local/bin/virtualenvwrapper.sh

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR='nvim'
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# enable vi-mode on command line
#bindkey -v

#####
# Go configs
#######
export GO111MODULE=off # https://github.com/kubernetes/client-go/blob/master/INSTALL.md#enabling-go-modules
export GOPATH=$HOME/go
#export GOROOT=/usr/local/opt/go@1.12/libexec
export GOROOT=/usr/local/opt/go@1.13/libexec
export GOBIN=$GOPATH/bin
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH

export PATH="/usr/local/opt/postgresql@11/bin:$PATH"
# export PATH="/usr/local/anaconda3/bin:$PATH"  # commented out by conda initialize

################### blend configs
# note: nvm dir is set up in the first few lines for oh my zsh
# Commenting these lines out. For some reason, this really slows down startup
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Creating an alias here to load nvm manually
alias loadnvm="/usr/local/opt/nvm/nvm.sh && /usr/local/opt/nvm/etc/bash_completion.d/nvm"  

##########################################

# MISMO SERVICE CONFIGS

export LDFLAGS="-L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/libxml2/include"
export CGO_ENABLED=1
export PATH=$HOME/pact/bin:$PATH

##########################################

if [ -f /Users/jfan/.blend_profile ]; then
  source /Users/jfan/.blend_profile
fi
export PATH=$HOME/mongodb/bin:$PATH

################### blend configs

# blend profile contents
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/justin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/justin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/justin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/justin/google-cloud-sdk/completion.zsh.inc'; fi


source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#zprof
