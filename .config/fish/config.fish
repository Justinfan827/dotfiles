if status is-interactive
    # Commands to run in interactive sessions can go here
end


############################################################

# Setting variables

############################################################


# set nvm for the nvm.fish plugin
# The nvm install command activates the specified Node version only in the current environment. If you want to set the default version for new shells use:
set --universal nvm_default_version v19.7.0

set -gx EDITOR nvim

# Go
# If $GOPATH is not set, Go installs binaries in $HOME/go/bin
fish_add_path $HOME/go/bin

# Android SDK
set -Ux ANDROID_HOME $HOME/Library/Android/sdk
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/emulator

# Python
fish_add_path $HOME/Library/Python/3.8/bin

# Lua language server
fish_add_path $HOME/tools/lua-language-server/bin/macOS

# OpenAPI tools
fish_add_path ~/bin/openapitools

# MongoDB
fish_add_path $HOME/mongodb/bin

# Homebrew (default binary path)
fish_add_path /opt/homebrew/bin

# Custom scripts
set -Ux CUSTOM_SCRIPTS_DIR $HOME/.config/scripts
fish_add_path $CUSTOM_SCRIPTS_DIR

# -------------------------------
# Fish completions
# -------------------------------
for dir in (brew --prefix)/share/fish/completions (brew --prefix)/share/fish/vendor_completions.d
    if test -d $dir
        set -gx fish_complete_path $fish_complete_path $dir
    end
end


############################################################

# Aliases

############################################################

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias code "/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

alias lnt "golangci-lint run --config=./.golangci.yaml ./..."
alias gma "go mod tidy && go mod vendor"
alias nu "nvm use"

alias vk='NVIM_APPNAME=nvim-kickstart nvim' # Kickstart
alias vi 'nvim'
alias vim 'nvim'
alias fv 'vim (fzf | xargs)'
alias cv 'cd $(find * -type d | fzf)'
alias gts 'gt m -a && gt ss'
alias gtd 'gt diff'
alias vkl 'cd ~/.config/nvim-kickstart && NVIM_APPNAME=nvim-kickstart nvim'
alias fk 'NVIM_APPNAME=nvim-kickstart nvim (fzf | xargs)'
alias vkt 'NVIM_APPNAME=nvim-kickstart nvim ~/.tmux.conf'
alias vkg 'NVIM_APPNAME=nvim-kickstart nvim ~/.gitconfig'
alias vkf 'NVIM_APPNAME=nvim-kickstart nvim ~/.config/fish/config.fish'
alias vkk 'NVIM_APPNAME=nvim-kickstart nvim ~/.config/kitty/kitty.conf'
alias vka 'NVIM_APPNAME=nvim-kickstart nvim ~/.aws/config'

alias fsa "fisher add $argv"
alias fsr "fisher remove (fisher list | fzf)"
alias fsl "fisher list"
alias cl "clear"
alias p3="python3"
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
alias tf 'terraform'
alias nr "npm run"
# Docker
alias kb 'kubectl'
alias dc 'docker'
alias nr 'npm run'

############################################################

# FZF settings

############################################################
set -gx FZF_DEFAULT_COMMAND 'ag -g ""'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_ALT_C_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_DEFAULT_OPTS ' --color=gutter:-1,bg:-1 --color info:108,prompt:109,spinner:108,pointer:168,marker:168'

#############################################################

## Helpful functions 

#############################################################

function gsnag -d "snag from another branch"
  # first arg is the branch name.
  # 2nd arg is the file name
  git checkout $argv[1] -- $argv[2]
end

function ghu
    set test ( git remote -v | grep push | awk '{ print $2;}')
    set URL (echo $test | sed "s/git@\(.*\):\(.*\).git/https:\/\/\1\/\2/")
    echo "Opening $URL..."
    open $URL
end

function g --wraps git -d "alias for git"
  git $argv
end

#############################################################
## FZF terminal functions 
#############################################################

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
