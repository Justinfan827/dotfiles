if status is-interactive
    # Commands to run in interactive sessions can go here
end


############################################################

# Setting variables

############################################################


# universals
# set nvm for the nvm.fish plugin
# The nvm install command activates the specified Node version only in the current environment. If you want to set the default version for new shells use:
set --universal nvm_default_version v19.7.0

set -gx EDITOR nvim

# Go variables
# If $GOPATH is not set, binaries are installe in $HOME/go/bin
set -Ux ANDROID_HOME $HOME/Library/Android/sdk
set PATH $ANDROID_HOME/platform-tools $ANDROID_HOME/emulator $HOME/go/bin $HOME/tools/lua-language-server/bin/macOS $HOME/Library/Python/3.8/bin ~/bin/openapitools $PATH

# Blend mismo service variables
# set -gx LDFLAGS "-L/usr/local/opt/libxml2/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/libxml2/include"
# set -gx CGO_ENABLED 1
# set -gx PATH $HOME/pact/bin $PATH
# set -gx PATH $HOME/.local/bin $PATH

if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

###########################################

fish_add_path /opt/homebrew/bin
set PATH $HOME/mongodb/bin $PATH


############################################################

# abbreviations
# triggered by space!

############################################################
abbr -a pjo pj open


############################################################

# Aliases

############################################################

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias code "/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

alias lnt "golangci-lint run --config=./.golangci.yaml ./..."
alias gma "go mod tidy && go mod vendor"
alias nu "nvm use"

alias fsa "fisher add $argv"
alias fsr "fisher remove (fisher list | fzf)"
alias fsl "fisher list"
alias cl "clear"


alias vk='NVIM_APPNAME=nvim-kickstart nvim' # Kickstart
alias tctl "docker exec temporal-admin-tools tctl"

# blend nvm
# alias we 'watchexec -c -w ./'
# alias weg 'watchexec -c -w ./ go run'
# alias wet 'watchexec -c -w ./ go test'

alias grep 'grep --color'
alias mk 'make'
alias mr 'make run'
alias nr 'npm run'
alias yr 'yarn run'
alias yff 'yarn run format:fix'
alias p 'pnpm'
alias chrome 'chrome -a \"Google Chrome\"'
alias ssa 'ssh -A'
alias gc 'gcloud'
alias y 'yarn'

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
alias gsb "g checkout (g branch --sort=-committerdate | fzf | sed -e 's/^[ \t]*//')"
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

# managine dot files with a git bare repo
alias wt='git worktree'
alias c='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cnvim='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add ~/.config/nvim/ && c status'
alias cfish='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add ~/.config/fish/ && c status'
alias cst='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME status'

# Tmux aliases
alias t 'tmux'
alias txa "tmux a -t (tmux ls | awk '{print $1}' |  sed 's/ .*\$//' | fzf)"
alias hsp "tmux split-window -h"
alias vsp "tmux split-window -v"


# Vim aliases
alias vi 'nvim'
alias vim 'nvim'
alias fv 'vim (fzf | xargs)'
alias fk 'NVIM_APPNAME=nvim-kickstart nvim (fzf | xargs)'
alias cv 'cd $(find * -type d | fzf)'
alias gts 'gt m -a && gt ss'
alias gtd 'gt diff'
alias vikl 'cd ~/.config/nvim-kickstart && NVIM_APPNAME=nvim-kickstart nvim'
alias vikt 'NVIM_APPNAME=nvim-kickstart nvim ~/.tmux.conf'
alias vikg 'NVIM_APPNAME=nvim-kickstart nvim ~/.gitconfig'
alias vikf 'NVIM_APPNAME=nvim-kickstart nvim ~/.config/fish/config.fish'
alias vikk 'NVIM_APPNAME=nvim-kickstart nvim ~/.config/kitty/kitty.conf'
alias vaws 'vim ~/.aws/config'
alias viml 'cd ~/.config/nvim && vim'
alias vimt 'vim ~/.tmux.conf'
alias vimg 'vim ~/.gitconfig'
alias vimf 'vim ~/.config/fish/config.fish'
alias vimk 'vim ~/.config/kitty/kitty.conf'
alias vaws 'vim ~/.aws/config'
alias awi 'AWS_PROFILE=jfan-indie aws'
alias tf 'terraform'
alias ti 'AWS_PROFILE=jfan-indie terraform'
alias tprod 'AWS_PROFILE=ansa-prod terraform'
alias tstaging 'AWS_PROFILE=ansa-dev terraform'
alias tappwest 'AWS_PROFILE=app-prod-west terraform'
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

# temporarily mark directory with '-' tag
alias sd 'to rm - && to add -'
alias ds 'to -'

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
# Helps with vims preview window (turn off if i want to use transparent
# background)
# set -gx BAT_THEME "TwoDark"
# set -gx FZF_DEFAULT_OPTS '--color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108 --color info:108,prompt:109,spinner:108,pointer:168,marker:168'
# https://www.reddit.com/r/vim/comments/rqhurx/comment/hqav4ek/?utm_source=share&utm_medium=web2x&context=3
# 
# 
set -gx FZF_DEFAULT_OPTS ' --color=gutter:-1,bg:-1 --color info:108,prompt:109,spinner:108,pointer:168,marker:168'

# Uncomment the following line to disable fuzzy completion
# export DISABLE_FZF_AUTO_COMPLETION="true"

#############################################################

## Helpful functions 

#############################################################
#
function vv -d "open nvim with fzf"
    # Assumes all configs exist in directories named ~/.config/nvim-*
    set config (fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
 
    # If I exit fzf without selecting a config, don't open Neovim
    if test -z "$config"
        echo "No config selected"
        return
    end
 
    # Open Neovim with the selected config
    env NVIM_APPNAME=(basename $config) nvim $argv
end

function gsnag -d "snag a file from another branch"

  # first arg is the branch name.
  # 2nd arg is the file name
  git show $argv[1]:$argv[2] > $argv[2]
end

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

function newHTML -d "create html and css file to run some test"
  set dirName /tmp/play_(date +%H:%M)
  echo $val
  mkdir -p $dirName
  mkdir -p $dirName/css
  cd $dirName
  touch index.html 
  touch css/style.css
  tmux split-window -v -p 20 "live-server"
  tmux last-pane
  vim index.html
end

function fcoc -d "Fuzzy-find and checkout a commit"
  git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/justinfan/Documents/code-workbench/google-cloud-sdk/path.fish.inc' ]; . '/Users/justinfan/Documents/code-workbench/google-cloud-sdk/path.fish.inc'; end

#
#
# Ansa specific configs
#
#
function gaj -d "checkout a new branch for jfan dev work"
  git checkout -b jfan/ANSA-$argv
end

function sa -d "sources ~/code/ANSA/ansa-platform/env.sh"
  nvm use v14.17.0
  bass source ~/code/ANSA/ansa-platform/env.sh
end

function si -d "sources ~/code/ANSA/ansa-platform/env.sh"
  nvm use latest
  bass source ~/code/ANSA/ansa-platform/env.sh
end

function vj -d "open vim temp file"
  # give me a random number
  set -l num  (random 0 1 100000)
  set -l tempFile /tmp/temp$num.txt
  vim $tempFile
end

function runAnsaEventHandler -d "runs ansa event handler"
  sa
  cd ~/code/ANSA/ansa-platform
  go run ansa-server/entrypoints/event_handler/event_handler.go $argv --port=8081
end

function ras -d "runs ansa server"
  sa
  cd ~/code/ANSA/ansa-platform
  go run ansa-server/entrypoints/ansa_server.go $argv --port=8087
end

function rap -d "runs ansa portal"
  cd ~/code/ANSA/ansa-portal
  nvm use 
  yarn dev
end

function runWatchAnsaServer -d "runs ansa server"
  sa
  cd ~/code/ANSA/ansa-platform
  watchexec -e go -c -r -s SIGKILL 'go run ansa-server/entrypoints/ansa_server.go --port=8080'
end

function rai -d "runs ansa api tests"
  sa
  INTEGRATION=true go test -v -timeout 15m ./ansa-server/restapi/apitests/... -run="$argv[1]"
end

#!/usr/bin/env fish

function __enter_container_id -d "Enter container with provided id"
  set selected_container $argv
  if docker exec "$selected_container" fish >/dev/null
    docker exec -it "$selected_container" fish
  else if docker exec "$selected_container" zsh >/dev/null
    docker exec -it "$selected_container" zsh
  else if docker exec "$selected_container" bash >/dev/null
    docker exec -it "$selected_container" bash
  else
    docker exec -it "$selected_container" sh
  end
end


function __enter_check_tools -d "Check if all necessary cli tools are installed"
  if not type -q docker
     echo "Docker not installed"
     return 1
  end

  if not type -q fzf
     echo "fzf not installed"
     return 1
  end
  return 0
end

function __enter_select_container -d "Select container via fzf"
  docker ps --filter status=running --format "table {{.Names}}\t{{.Image}}\t{{.ID}}" | awk 'NR > 1 { print }' | sort | read -z containers
  if [ -z "$containers" ];
      echo -e "No running container found"
      return 0
  end
  printf $containers | fzf -e --reverse | awk '{ print $3 }' | read selected_container; or return 1
  printf $selected_container
end


function enter -d "Interactively try to enter a docker container"
  __enter_check_tools; or return 1
  set selected_container (__enter_select_container); or return 1
  __enter_container_id $selected_container; or return 1
end

# https://github.com/fsnotify/fsnotify/issues/129
ulimit -n 2048

# pnpm
set -gx PNPM_HOME "/Users/justinfan/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# fish in vi mode
#fish_vi_key_bindings
fish_default_key_bindings


# Added by `rbenv init` on Tue Jan  7 16:54:32 PST 2025
if command -v rbenv >/dev/null
    status --is-interactive; and rbenv init - --no-rehash fish | source
end
