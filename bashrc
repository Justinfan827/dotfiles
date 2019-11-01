alias ssa='ssh -A'
function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && ls
}
function fp() { ack &quot;proc\s+(flightaware_|fa_)?$*&quot; --type=tcl ; }
function ff() { find . -type f -iname '*'$*'*' -ls ; }

alias cds='cd ~/src'
alias cdv='cd /vhosts/fan/fa_web'
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias grh='git reset HEAD'
alias mk='make'
alias smk='sudo make'
alias ll='ls -al'
