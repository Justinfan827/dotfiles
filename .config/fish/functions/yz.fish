function yz
	if cat package.json > /dev/null 2>&1
	set scripts (cat package.json | jq .scripts | sed '1d;$d' | fzf --height 40%)

	if test -n "$scripts"
		set script_name (echo $scripts | awk -F ': ' '{gsub(/"/, "", $1); print $1}' | string trim)
		commandline -s "yarn run $script_name"
		yarn run $script_name
	else
		echo "Exit: You haven't selected any script"
	end
	else
	echo "Error: There's no package.json"
	end
end
