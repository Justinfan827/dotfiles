alias ssa='ssh -A'
function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then 
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && ls
}

alias cds='cd ~/src'
alias cdv='cd /vhosts/fan/fa_web'
alias g='git'
alias gs='git status'
alias ga='git add'
alias grh='git reset HEAD'
alias mk='make'
alias smk='sudo make'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='colordiff'
# alias ls='ls --color=auto' 
alias ll='ls -la'
alias l.='ls -d .* --color=auto'