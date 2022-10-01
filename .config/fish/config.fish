if status is-interactive
    # Commands to run in interactive sessions can go here
end


############################################################

# Setting variables

############################################################


# universals
# for the nvm.fish plugin
set --universal nvm_default_version v16.13.0

# globals
set -gx  PROJECT_PATHS \
~/dotfiles \
~/go/src/git.blendlabs.com/blend \
~/go/src/golang.blend.com/project \
~/go/src/golang.blend.com/project \
~/go/src/golang.blend.com/sdk \
~/go/src/golang.blend.com/shared \
/Users/justin/repo/git.blendlabs.com/blend \
/Users/justin/repo/git.blendlabs.com/blend/lending 

set -gx EDITOR nvim
## Setup vault locally
set -gx VAULT_ADDR https://vault.sandbox.k8s.centrio.com:8200
set -gx VAULT_HOST vault.sandbox.k8s.centrio.com:8200

# Go variables
set -x GO111MODULE auto # https://github.com/kubernetes/client-go/blob/master/INSTALL.md#enabling-go-modules
set -x GOPATH $HOME/go
set -x GOROOT /usr/local/opt/go/libexec
set PATH $GOPATH/bin $GOROOT/bin  $HOME/tools/lua-language-server/bin/macOS $HOME/Library/Python/3.8/bin ~/bin/openapitools $PATH
#set -gx GOPATH $HOME/go
#set -gx GOBIN $GOPATH/bin
#set -gx PATH $GOROOT/bin:$GOPATH/bin $PATH
#o
#
set -gx JIRA_API_TOKEN "b9Fqh0aleNgvGHqDocKdD505"

# Blend sourcegraph CLIENT_ID
set -gx SRC_ENDPOINT "https://sourcegraph.k8s.tools.blend.com"
set -gx SRC_ACCESS_TOKEN (cat ~/.sourcegraph_token  | jq -r '."token"')

# Blend mismo service variavles

set -gx LDFLAGS "-L/usr/local/opt/libxml2/lib"
set -gx CPPFLAGS "-I/usr/local/opt/libxml2/include"
set -gx CGO_ENABLED 1
set -gx PATH $HOME/pact/bin $PATH

set -gx GITHUB_OAUTH_TOKEN "d3609a0cfd4c0d38fa0be0b315e2349ff00310c7"
set -gx PATH $HOME/.local/bin $PATH

###########################################

if [ -f /Users/jfan/.blend_profile ]
  source /Users/jfan/.blend_profile
end
set PATH $HOME/mongodb/bin $PATH


# for local dev with sensitive data pipeline
# https://github.com/pyenv/pyenv/blob/master/README.md#basic-github-checkout
 #set PYENV_ROOT $HOME/.pyenv
#set -x PATH $PYENV_ROOT/shims $PYENV_ROOT/bin $PATH
#pyenv init - | source

#pyenv rehash
#status is-login; and pyenv init --path | source
#status is-interactive; and pyenv init - | source

############################################################

# abbreviations
# triggered by space!

############################################################
abbr -a pjo pj open


############################################################

# Aliases

############################################################

alias code "/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

alias fsa "fisher add $argv"
alias fsr "fisher remove (fisher list | fzf)"
alias fsl "fisher list"

alias we 'watchexec -c -w ./'
alias weg 'watchexec -c -w ./ go run'

alias monolint 'to gomono && repoctl lint'

alias grep 'grep --color'
alias mk 'make'
alias mr 'make run'
alias nr 'npm run'
alias chrome 'chrome -a \"Google Chrome\"'
alias ssa 'ssh -A'
alias aw 'aws-vault'

# Sourcing
alias sb 'source ~/.bashrc'
alias sz 'source ~/.zshrc'
alias st 'tmux source-file ~/.tmux.conf'
alias sf 'source ~/.config/fish/config.fish'

# Git alias
# copy current branch name
alias gitb "git branch | grep '^\*' | cut -d' ' -f2 | pbcopy" 
#
alias gg "git log --remotes --tags --branches --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gl "git log --remotes --tags --branches --no-walk --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gsb "g checkout (g branch | fzf | sed -e 's/^[ \t]*//')"
alias jj "blend-productivity-cli"
alias cc 'git checkout'
alias gcp 'git checkout -' # checkout previous branch
alias gcc 'git checkout -b' 
alias gp 'git push'
alias gpo='git push -u origin HEAD'
alias gundocommit 'git reset --soft HEAD~'
alias gpu='git pull'
alias gpum 'git checkout master | git pull'
alias gmm 'git merge master'
alias gst 'git status'
alias gd='g diff'

alias c='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Tmux aliases
alias t 'tmux'
alias txa "tmux a -t (tmux ls | awk '{print $1}' |  sed 's/ .*\$//' | fzf)"
alias hsp "tmux split-window -h"
alias vsp "tmux split-window -v"


# Vim aliases
alias vaws 'vim ~/.aws/config'
alias vi 'nvim'
alias fv 'fzf | xargs nvim'
alias vim 'nvim'
alias viml 'cd ~/.config/nvim && vim'
alias vimb 'cd ~/dotfiles && vim ~/dotfiles/bashrc'
alias vimv 'cd ~/dotfiles && vim ~/dotfiles/vimrc'
alias vimz 'cd ~/dotfiles && vim ~/dotfiles/zshrc'
alias vimt 'cd ~/dotfiles && vim ~/dotfiles/tmux.conf'
alias vimf 'cd ~/dotfiles/fish && vim ~/dotfiles/fish/config.fish'
# leverage vim auto sessions by cding to project root first 
alias vmon 'to gomono && vim'
alias vin 'to in && vim'
alias vcx 'to cx && vim'
alias vlb 'to lb && vim'
alias vlf 'to lf && cd ./lender-react && vim'
alias vaus 'to aus && vim'
alias vdcs 'to dcs && vim'
alias vmismo 'to mismo && vim'
alias vcp 'to caliper && vim'
alias vlt 'to loandr && vim' # loan toolbox

alias nr "npm run"
# Docker
alias kb 'kubectl'
alias kbconnect 'eval (minikube docker-env)'
alias docom 'docker-compose'
alias doc 'docker'
alias mkbe 'minikube'

# npm 
alias nr 'npm run'
alias nb 'nvm use 14'
alias nn 'nvm use 16'

############################################################

# FZF settings

############################################################
# Set fzf installation directory path
#set -gx FZF_DEFAULT_COMMAND 'ag  -U --nocolor -g "" 2> /dev/null'
set -gx FZF_DEFAULT_COMMAND 'ag -g ""'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "$FZF_DEFAULT_COMMAND"
# Helps with vims preview window
set -gx BAT_THEME "TwoDark"

set -gx FZF_DEFAULT_OPTS '--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108 --color info:108,prompt:109,spinner:108,pointer:168,marker:168'

# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

#############################################################

## Helpful functions 

#############################################################

function ghu
    set test ( git remote -v | grep push | awk '{ print $2;}')
    set URL (echo $test | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")
    echo "Opening $URL..."
    open $URL
end

function ss -d "sourcegraph search"
  src search $argv[1]
end

function g --wraps git
  git $argv
end

function inc --wraps income
 INCOME_USERNAME=(cat ~/.income_user) INCOME_PASSWORD=(cat ~/.income_pw) income $argv
end

## quickly open note taking
function bn
    vim ~/workbench/blend/blendclinotes/notes.txt
end

# Split tmux pane into ide-style 3 windows
function ide
    tmux split-window -v -p 30
    tmux split-window -h -p 66
end

function tms
    tmux new -s $1 -d 
    tmux switch -t $1
end

# Open the Pull Request URL for your current directory's branch (base branch defaults to master)
function op
  set github_url (git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#https://#' -e 's@com:@com/@' -e 's%\\.git$%%')
  set branch_name (git symbolic-ref HEAD | cut -d"/" -f 3,4);
  set pr_url $github_url"/compare/"$branch_name
  open $pr_url;
end

# creates test repl to run lending tests
function createTestRepl
    nvm use 14
    cp ~/.blendLendingTestRepl.js /Users/justin/repo/git.blendlabs.com/blend/lending/backend/dist/testRepl.js
    cd /Users/justin/repo/git.blendlabs.com/blend/lending/backend 
    chmod +x /Users/justin/repo/git.blendlabs.com/blend/lending/backend/dist/testRepl.js
    DEPLOYMENT=test TENANT_LIST=test,blend-borrower NODE_ENV=dev node dist/testRepl.js
end

#############################################################

## Blend functions 

#############################################################

function makeGoProtos -d "make protos and create definitions in monorepo"
  cd ~/repo/git.blendlabs.com/blend/protos
  make pretty
  cd /Users/justin/go/src/golang.blend.com
  repoctl generate-protos-protogen --source=/Users/justin/repo/git.blendlabs.com/blend/protos
end

function cx_sandbox 
    PGPASSWORD=$1 psql -h connectivity-sandbox-new.cj1yhu1y5rvu.us-east-1.rds.amazonaws.com -U blend_admin connectivity
end

function vault_token
    set CLIENT_ID (cat ~/.deployinator_api_key  | jq -r '."Client-Id"')
    set CLIENT_SECRET ( cat ~/.deployinator_api_key  | jq -r '."Client-Secret"' )
    set VAULT_TOKEN (curl -X POST https://deployinator.sandbox.k8s.centrio.com/api/vault.tokens -H "Client-Id: $CLIENT_ID" -H "Client-Secret: $CLIENT_SECRET" | jq -r '.token')
    echo -n $VAULT_TOKEN > ~/.vault-token
end

function lstyle -d "run lending style"
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    nvm use 14
    npm run styleDiff
end


function lfgrunt -d "run lending lender side angular app"
    cd ~/repo/git.blendlabs.com/blend/lending/frontend/client
    nvm use 14
    grunt dev
end
function lfrun -d "run lending lender side react app"
    cd ~/repo/git.blendlabs.com/blend/lending/frontend/lender-react
    nvm use 14
    npm run start
end

function crun -d "run caliper"
    cd ~/repo/git.blendlabs.com/blend/caliper/server
    nvm use 14
    npm run start
end

function startMongo -d "start mongo"
  mkdir -p ~/mongodb/data/db && mongod --dbpath ~/mongodb/data/db > /dev/null 2>&1 &
end

function inrun -d "run income"
    to in
    make run
end

function lbrun -d "run lending backend"
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    nvm use 14
    npm run start
end

function ltype -d "run lending type check"
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    nvm use 14
    npm run typeCheck:watch
end

function ltest -d "run lending test"
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    nvm use 14
    npm run testFast
end

function lbin -d "run lending locally and point to income"
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    nvm use 14
    INCOME_VERIFICATION_HOST=http://localhost:5010 npm run start
end

function lbcx -d "pure lending locally and point to connex"
    nvm use 14
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    CONNECTIVITY_HOST=https://localhost:5005 npm start
end

# lending pointing to local UI
function lbui
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    nvm use 14
    SERVE_CLIENT_LOCALLY=true npm start
end

# lending without the loggin
function quietLending
    nvm use 14
    cd ~/repo/git.blendlabs.com/blend/lending/backend
    CONNECTIVITY_HOST=https://localhost:5005 BLEND_LOGGER_SKIP=true npm start
end

# just run connex and point to local lending
function cx
    cd ~/go/src/git.blendlabs.com/blend/connectivity
    LENDING_API_HOST=localhost:8080 LENDING_HOST=localhost:8080 make run
end

# just run connex and point to local lending
function amod
    cd ~/go/src/git.blendlabs.com/blend/connectivity
    LENDING_API_HOST=localhost:8080 LENDING_HOST=localhost:8080 make run-assets-mod
end

# Whenever I get issues with the sqs queue during local dev
function purgeLocalSqs
    # Make sure to connect as sandbox-dev first
    for queue in (aws sqs list-queues --queue-name-prefix=dev-jfan --query 'QueueUrls[*]' --output text) ; \
        aws sqs purge-queue --queue-url=$queue;
    end
end


function wev
    set cmd "go vet ./... && revive ./..."
    watchexec -c -w ./ $cmd
end

# examples
# it TestNewPartyIncomesResponse/Happy:_Incomes_from_different_orders_and_providers_with_different_data_availability  viewmodel
# it  TestPrepareForBuild_HappyNoIncomesFound gse/fannie --count=100

function itg -d 'run income tests + update golden files'
    cd /Users/justin/go/src/golang.blend.com/project/income
    set cmd "make unit-test extra=\" -run .*$argv[1].* ./pkg/$argv[2] --update-golden $argv[3]"\"
    echo $cmd
    watchexec -c -w ./ $cmd
end

function it -d 'run income tests'
    cd /Users/justin/go/src/golang.blend.com/project/income
    set cmd "make unit-test extra=\" -run .*$argv[1].* ./pkg/$argv[2] $argv[3]\""
    echo $cmd
    watchexec -c -w ./ $cmd
end

function iti -d 'run income integration tests only'
    cd /Users/justin/go/src/golang.blend.com/project/income
    set cmd "make test extra=\" -run .*$argv[1].* ./pkg/verification/integrationtest $argv[2]\""
    echo $cmd
    watchexec -c -w ./ $cmd
end

function goTest
    watchexec -c -w ./ "go test $3 -run .*$1.* $2"
end


#############################################################
## FZF terminal functions 
#############################################################

function fhist -d 'cd to one of the previously visited locations'
	# Clear non-existent folders from cdhist.
	set -l buf
	for i in (seq 1 (count $dirprev))
		set -l dir $dirprev[$i]
		if test -d $dir
			set buf $buf $dir
		end
	end
	set dirprev $buf
	string join \n $dirprev | tail -r | sed 1d | eval (__fzfcmd) +m --tiebreak=index --toggle-sort=ctrl-r $FZF_CDHIST_OPTS | read -l result
	[ "$result" ]; and cd $result
	commandline -f repaint
end

function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
end

# not really working
function snag -d "Pick desired files from a chosen branch"
  # use fzf to choose source branch to snag files FROM
  set branch (git for-each-ref --format='%(refname:short)' refs/heads | fzf --height 20% --layout=reverse --border)
  # avoid doing work if branch isn't set
  if test -n "$branch"
    # use fzf to choose files that differ from current branch
    set files (git diff --name-only $branch | fzf --height 20% --layout=reverse --border --multi)
  end
  # avoid checking out branch if files aren't specified
  if test -n "$files"
    git checkout $branch $files
  end
end

function fs -d "Switch tmux session"
  tmux list-sessions -F "#{session_name}" | fzf | read -l result; and tmux switch-client -t "$result"
end

function fssh -d "Fuzzy-find ssh host via ag and ssh into it"
  ag --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf | read -l result; and ssh "$result"
end

# open a vim session via fzf
function vims
    set session (ls ~/vim-sessions | fzf)
    vim -S ~/vim-sessions/$session
end



#############################################################

## BLEND MISC

#############################################################
#
## Helper function to install dev npm packages
## https://git.blendlabs.com/blend/npm-verdaccio#publishing-to-sandbox-registry
#function dev_install() {
    #echo npm i @blend/${1}@npm:@dev/${1}@${2}
    #npm i @blend/${1}@npm:@dev/${1}@${2}
#}

# Compilation flags
set ARCHFLAGS "-arch x86_64"

#####
# Neovim configs
#######
# suggested by neovim healthcheck https://vi.stackexchange.com/questions/7644/use-vim-with-virtualenv/7654#7654
#if  [ -n $VIRTUAL_ENV ] && [ -e "$VIRTUAL_ENV/bin/activate" ]
  #vf  activate "$VIRTUAL_ENV"
#end


#################### 
#################### misc blend configs
#################### 
## Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="/usr/local/bin:$PATH"
#export PATH="$PATH:$HOME/.rvm/bin"
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# ulimit increase for blend
## krew: kubectl plugin manager
#export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

set -gx NODE_ENV dev
set -gx SERVICE_ENV dev
set -gx DEPLOYMENT blend-borrower
set -gx TENANT_LIST blend-borrower
ulimit -f unlimited  # file size limit
ulimit -t unlimited  # cpu
ulimit -v unlimited 
ulimit -n 64000 
ulimit -u 2048
if string match -r -q  '/Users/justin/repo/git.blendlabs.com/blend/lending/*' (pwd)
    source /Users/justin/repo/git.blendlabs.com/blend/lending/venv-py3/bin/activate.fish
    set PATH /usr/local/opt/openjdk/bin:$HOME/mongodb/bin $PATH
    pgrep mongod > /dev/null ||  mkdir -p ~/mongodb/data/db && mongod --dbpath ~/mongodb/data/db > /dev/null 2>&1 &
end
