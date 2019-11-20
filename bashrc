function cd() {
    new_directory="$*";
    if [ $# -eq 0 ]; then
        new_directory=${HOME};
    fi;
    builtin cd "${new_directory}" && ls
}

function reset_multicom() {
	sudo service bacon stop
	sudo bacon -reset -5 -children 5
	sudo service sqlbirdd stop
	cd /usr/local/flightaware/src/sqlbird
	sudo rm /var/db/sqlbird/*
	tclsh db/repsets.tcl
	sqlbasebird
	sudo service sqlbirdd start
}

function ide() {
	tmux split-window -v -p 30
	tmux split-window -h -p 66
	tmux split-window -h -p 50
}

function fixssh() {
	for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
		if (tmux show-environment | grep "^${key}" > /dev/null); then
			value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
			export ${key}="${value}"
		fi
	done				
}
alias tagdir='/usr/local/bin/exctags -R --langmap=TCL:.tcl.rvt *' 
alias grep='grep --color'
alias ssa='ssh -A'
alias gsb='git checkout $(git branch | fzf)'
alias cds='cd ~/src'
alias cdv='cd /vhosts/fan/fa_web'
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias grh='git reset HEAD'
alias mk='make'
alias smk='sudo make'
alias ll='ls -al'
alias tx='tmux'
alias txa=$'tmux a -t $(tmux ls | awk \'{print $1}\' | sed \'s/.$//\' | fzf)'
alias sb='source ~/.bashrc'
alias st='tmux source-file ~/.tmux/conf'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
set -o vi
