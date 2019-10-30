set PATH ~/flutter_dev/flutter/bin $PATH

function fs
	if  test (count $argv) -lt 4
		echo "Usage: <SERVER NAME>  <FILE NAME> [<src> for ~/src/ OR <usr> for /usr/local/flightaware/src)] <FILE NAME in /dev/dev_fs> >"
		return
	end
	if ! test -d ~/dev/dev_fs/$argv[4]
		mkdir ~/dev/dev_fs/$argv[4]
	end 
	echo $argv
	if [ "$argv[3]" = "src" ]
		sshfs -o allow_other,defer_permissions,reconnect justin.fan@$argv[1]:/home/justin.fan/src/$argv[2] ~/dev/dev_fs/$argv[4] 
		echo "connected (/usr) in local dir: /dev/dev_fs/$argv[4])"
	else if [ "$argv[3]" = "usr" ]
		sshfs -o allow_other,defer_permissions,reconnect justin.fan@$argv[1]:/usr/local/flightaware/src/$argv[2] ~/dev/dev_fs/$argv[4]
		echo "connected (~/src) in local dir: /dev/dev_fs/$argv[4]"
	end 
end

function vs
	open $argv -a "Visual Studio Code"
end

function vsf 
	vs "/Users/justin.fan/.config/fish/config.fish"
end

function vsb
	vs ~/.bash_profile
end

function cd
    if count $argv > /dev/null
        builtin cd "$argv"; and ls
    else
        builtin cd ~; and ls
    end
end

function cdd
	cd /Users/justin.fan/dev/dev_fs
end

function cdp
	cd /Users/justin.fan/personal
end

function save
	 source ~/.config/fish/config.fish
end

function ssa
	ssh -A "$argv"
end

function gc
	git commit $argv
end

function gs 
	git status 
end

function ga
	git add $argv
end

function gp
	git push
end

function myfunc
	echo "cd"
	echo "cdp"
	echo "cdd"
	echo "fs"
	echo "vs"
	echo "vsf"
	echo "vsb"
	echo "save"

end

