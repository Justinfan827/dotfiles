# How to git add, commit, and push using one function in friendly interactive shell (Fish Shell).
# Save this file within '~/.config/fish/functions' as 'quickgit.fish'. Create the directory if it does not exist.
# '--git-dir=$PWD/.git' Ensures that we run the git commands against the git project where we called the function

function quickgit
    git add .
    git commit -a -m $argv
    git push
end
# Restart terminal, navigate to project, make changes, and now you can call 'quickgit "example message"'.
# Changes will now be added, committed, and puh :).

# Inspired by an answer found on SO https://stackoverflow.com/a/23328996/1852191s
