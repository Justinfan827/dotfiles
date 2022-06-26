# enable below to profile zsh start time
echo "start"
#zmodload zsh/zprof
#
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
    #zsh-autosuggestions
)

# help zsh find nvm BEFORE oh my zsh is sourced
export NVM_DIR="$HOME/.nvm"

############################################################

# FZF settings

############################################################
# Set fzf installation directory path
export FZF_BASE=/path/to/fzf/install/dir
export FZF_DEFAULT_COMMAND='ag  --nocolor -g "" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
# Helps with vims preview window
export BAT_THEME="TwoDark"

#export FZF_DEFAULT_OPTS='
#--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
#--color info:108,prompt:109,spinner:108,pointer:168,marker:168
#'
# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

# On slow systems, checking the cached .zcompdump file to see if it must be 
# regenerated adds a noticable delay to zsh startup.  This little hack restricts 
# it to once a day.  It should be pasted into your own completion file.
#
# The globbing is a little complicated here:
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
# - '.' matches "regular files"
# - 'mh+24' matches files (or directories or whatever) that are older than 24 hours.
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C


ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh
echo "done loading zsh"

############################################################

# Helpful functions 

############################################################

# quickly open note taking
function bn() {
    vim ~/workbench/blend/blendclinotes/notes.txt
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

# Open the Pull Request URL for your current directory's branch (base branch defaults to master)
function openpr() {
  github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#https://#' -e 's@com:@com/@' -e 's%\.git$%%'`;
  branch_name=`git symbolic-ref HEAD | cut -d"/" -f 3,4`;
  pr_url=$github_url"/compare/"$branch_name
  open $pr_url;
}

# Run git push and then immediately open the Pull Request URL
function gpr() {
  git push origin HEAD

  if [ $? -eq 0 ]; then
    openpr
  else
    echo 'failed to push commits and open a pull request.';
  fi
}

# creates test repl to run lending tests
function createTestRepl() {
    cp ~/.blendLendingTestRepl.js /Users/justin/repo/git.blendlabs.com/blend/lending/backend/dist/testRepl.js
    cd /Users/justin/repo/git.blendlabs.com/blend/lending/backend 
    sudo DEPLOYMENT=test TENANT_LIST=test,blend-borrower NODE_ENV=dev node dist/testRepl.js
}

############################################################

# Blend functions 

############################################################

function cx_sandbox() {
    PGPASSWORD=$1 psql -h connectivity-sandbox-new.cj1yhu1y5rvu.us-east-1.rds.amazonaws.com -U blend_admin connectivity
}
# Setup vault locally
export VAULT_ADDR=https://vault.sandbox.k8s.centrio.com:8200
export VAULT_HOST=vault.sandbox.k8s.centrio.com:8200
function vault_token() {
    CLIENT_ID=`cat ~/.deployinator_api_key  | jq -r '."Client-Id"'`
    CLIENT_SECRET=`cat ~/.deployinator_api_key  | jq -r '."Client-Secret"'`
    export VAULT_TOKEN=`curl -X POST https://deployinator.sandbox.k8s.centrio.com/api/vault.tokens -H "Client-Id: ${CLIENT_ID}" -H "Client-Secret: ${CLIENT_SECRET}" | jq -r '.token'`
    echo -n $VAULT_TOKEN > ~/.vault-token
}

# pure lending locally and point to connex
function lendingCXMod() {
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    ASSETS_MODULE_HOST=http://localhost:5050 CONNECTIVITY_HOST=http://localhost:5001 npm start
}

# pure lending locally and point to connex
function lendingCX() {
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    CONNECTIVITY_HOST=https://localhost:5005 npm start
}

# lending pointing to local UI
function localUIlending() {
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    CONNECTIVITY_HOST=https://localhost:5005 SERVE_CLIENT_LOCALLY=true npm start
}
# lending pointing to local UI
function localBorrowerUIlending() {
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    CONNECTIVITY_HOST=https://localhost:5005 SERVE_CLIENT_LOCALLY=true npm start
}

# lending without the loggin
function quietLending() {
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    CONNECTIVITY_HOST=https://localhost:5005 BLEND_LOGGER_SKIP=true npm start
}

# examples
# it TestNewPartyIncomesResponse/Happy:_Incomes_from_different_orders_and_providers_with_different_data_availability  viewmodel
# it  TestPrepareForBuild_HappyNoIncomesFound gse/fannie --count=100

# run income tests + update golden files
function itg() {
    cd /Users/justin/go/src/golang.blend.com/project/income
    cmd="make unit-test extra=\" -run .*$argv[1].* ./pkg/$argv[2] --update-golden $argv[3]"\"
    echo $cmd
    watchexec -c -w ./ $cmd
}

# run income tests
function it() {
    cd /Users/justin/go/src/golang.blend.com/project/income
    cmd="make unit-test extra=\" -run .*$argv[1].* ./pkg/$argv[2] $argv[3]\""
    echo $cmd
    watchexec -c -w ./ $cmd
}

#  run income integration tests only
function iti() {
    cd /Users/justin/go/src/golang.blend.com/project/income
    cmd="make test extra=\" -run .*$argv[1].* ./pkg/verification/integrationtest $argv[2]\""
    echo $cmd
    watchexec -c -w ./ $cmd
}

## just run connex and point to local lending
function cx() {
    cd ~/go/src/git.blendlabs.com/blend/connectivity
    LENDING_API_HOST=localhost:8080 LENDING_HOST=localhost:8080 make run
}

## just run connex and point to local lending
function amod() {
    cd ~/go/src/git.blendlabs.com/blend/connectivity
    LENDING_API_HOST=localhost:8080 LENDING_HOST=localhost:8080 make run-assets-mod
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

function wev() {
    cmd="go vet ./..."
    echo $cmd
    watchexec -c -w ./ $cmd
}

function it() {
    cmd="make unit-test extra=\" -run .*$1.* ./pkg/$2\" $3"
    echo $cmd
    watchexec -c -w ./ $cmd
}

function goTest() {
    watchexec -c -w ./ "go test $3 -run .*$1.* $2"
}

############################################################
# FZF terminal functions 
############################################################

# c - browse chrome history
function c() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open=open
  else
    google_history="$HOME/.config/google-chrome/Default/History"
    open=xdg-open
  fi
  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
  awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
  fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open > /dev/null 2> /dev/null
}

# b - browse chrome bookmarks
function b() {
     bookmarks_path=~/Library/Application\ Support/Google/Chrome/Default/Bookmarks

     jq_script='
        def ancestors: while(. | length >= 2; del(.[-1,-2]));
        . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'

    jq -r "$jq_script" < "$bookmarks_path" \
        | sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' \
        | fzf --ansi \
        | cut -d$'\t' -f2 \
        | xargs open
}

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

# open a default vim session
function vims() {
    vim -S $1

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

# Helper function to install dev npm packages
# https://git.blendlabs.com/blend/npm-verdaccio#publishing-to-sandbox-registry
function dev_install() {
    echo npm i @blend/${1}@npm:@dev/${1}@${2}
    npm i @blend/${1}@npm:@dev/${1}@${2}
}

############################################################

# Bindings 

############################################################

############################################################

# Productivity in terminal 

############################################################
# LESS terminal pager optimization
# https://www.topbug.net/blog/2016/09/27/make-gnu-less-more-powerful/
# # set options for less
export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
# or the short version
# export LESS='-F -i -J -M -R -W -x4 -X -z-4'
# # Set colors for less. Borrowed from https://wiki.archlinux.org/index.php/Color_output_in_console#less .
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline



############################################################

# Aliases

############################################################

alias nag_screen='hs -A -c "nagScreen()"'

alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
# Displays previously merged commits in a pretty way
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

#alias psql='pgcli'


alias we='watchexec -c -w ./'
alias weg='watchexec -c -w ./ go run'

alias monolint='jm gomono && repoctl lint'

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
# copy current branch name
alias gitb="git branch | grep '^\*' | cut -d' ' -f2 | pbcopy" 
alias gsb='git checkout $(git branch | fzf)'
alias g='git'
alias gc='git commit -m'
alias gcp='git checkout -' # checkout previous branch
alias gnew='git checkout -b' 
alias gp='git push'
alias gpo='git push -u origin HEAD'
alias gundocommit='git reset --soft HEAD~'
alias gpu='git pull'
alias gpum='git checkout master | git pull'
alias gmm='git merge master'
alias gst='git status'
alias gd='g diff'

# Tmux aliases
alias tx='tmux'
alias txa=$'tmux a -t $(tmux ls | awk \'{print $1}\' | sed \'s/.$//\' | fzf)'
alias hsp="tmux split-window -h"
alias vsp="tmux split-window -v"


# Vim aliases
alias vaws='vim ~/.aws/config'
alias vi='nvim'
alias vim='nvim'
alias vimb='vim ~/dotfiles/bashrc'
alias vimv='vim ~/dotfiles/vimrc'
alias vimz='vim ~/dotfiles/zshrc'
alias vimt='vim ~/dotfiles/tmux.conf'
alias vf='vimf'
# open vim at root to avoid issues with coc tsserver
alias vlend='vim ~/repo/git.blendlabs.com/blend/lending/backend/Gruntfile.js'

alias nr="npm run"

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
echo "done sourcing 10k"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
echo "done sourcing fzf"
# enable vi-mode on command line
#bindkey -v


#####
# Neovim configs
#######
# suggested by neovim healthcheck https://vi.stackexchange.com/questions/7644/use-vim-with-virtualenv/7654#7654
#if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  #source "${VIRTUAL_ENV}/bin/activate"
#fi

#####
# Go configs
#######
export GO111MODULE=auto # https://github.com/kubernetes/client-go/blob/master/INSTALL.md#enabling-go-modules
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export GOBIN=$GOPATH/bin
export PATH=$GOROOT/bin:$GOPATH/bin:$PATH

export PATH="/usr/local/opt/postgresql@11/bin:$PATH"
# export PATH="/usr/local/anaconda3/bin:$PATH"  # commented out by conda initialize

################### blend configs
# note: nvm dir is set up in the first few lines for oh my zsh
# Commenting these lines out. For some reason, this really slows down startup
# my problem: i have nvm installed by brew and by make setup node. WOOO I FIXED IT! I installed nvm in HOME directory
#[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Creating an alias here to load nvm manually
alias loadnvm="source $(brew --prefix nvm)/nvm.sh"  

##########################################

# MISMO SERVICE CONFIGS

export LDFLAGS="-L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/libxml2/include"
export CGO_ENABLED=1
export PATH=$HOME/pact/bin:$PATH

##########################################


################### blend configs
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#source $(brew --prefix nvm)/nvm.sh #this loads nvm for me
#
# ulimit increase for blend
ulimit -f unlimited -t unlimited -v unlimited -n 64000 -u 2048
# krew: kubectl plugin manager
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

source /Users/justin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#zprof
echo "end"
eval "$(pyenv init -)"
