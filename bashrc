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
}

function fixssh() {
	for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
		if (tmux show-environment | grep "^${key}" > /dev/null); then
			value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
			export ${key}="${value}"
		fi
	done
}
alias cdf='cd /usr/local/flightaware'
alias cdfe='cd /usr/local/flightaware/etc'
alias cdfs='cd /usr/local/flightaware/src'
alias cds='cd ~/src'
alias cdv='cd /vhosts/fan/fa_web'
alias g='git'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gd='git diff'
alias gpl='git pull'
alias grep='grep --color'
alias grh='git reset HEAD'
alias gs='git status'
alias gsb='git checkout $(git branch | fzf)'
alias ll='ls -al'
alias mk='make'
alias sb='source ~/.bashrc'
alias smk='sudo make'
alias ssa='ssh -A'
alias st='tmux source-file ~/.tmux.conf'
alias tagdir='/usr/local/bin/exctags -R --langmap=TCL:.tcl.rvt *' 
alias tx='tmux'
alias txa=$'tmux a -t $(tmux ls | awk \'{print $1}\' | sed \'s/.$//\' | fzf)'
alias vimb='vim ~/.bashrc'
alias vimv='vim ~/.vimrc'
alias tagify=' /usr/local/bin/exctags -R --langmap=TCL:.tcl.rvt *'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

