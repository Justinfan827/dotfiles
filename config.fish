
function vs
	open $argv -a "Visual Studio Code"
end

function vsf 
	vs "~/.config/fish/.config.fish"
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
	 source ~/.config/fish/.config.fish
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

# The next line updates PATH for the Google Cloud SDK.

if [ -f '/Users/Justinfan/google-cloud-sdk/path.fish.inc' ]; . '/Users/Justinfan/google-cloud-sdk/path.fish.inc'; end

set PATH ~/dev/flutter/bin $PATH
