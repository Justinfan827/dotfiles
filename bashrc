function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && ls
}

function ide() {
	tmux split-window -v -p 30
	tmux split-window -h -p 66
	tmux split-window -h -p 50
}

alias grep='grep --color'
alias ssa='ssh -A'
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
alias tx='tmux'



[ -f ~/.fzf.bash ] && source ~/.fzf.bash
