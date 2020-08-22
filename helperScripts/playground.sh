#!/bin/sh

# shell script to open up a typescript dev environment with nodemon set up!

# Using this to open up dev and vim in new tmux session
# https://unix.stackexchange.com/questions/335087/how-to-execute-code-in-a-new-tmux-session-from-within-current-session
if [[ "$TERM" =~ "screen".* ]]; then
  echo "We are in TMUX!"
    # Check if tmux has the dev session
    tmux has-session -t development
    if [ $? != 0 ] # $? captures the status of last command
    then
      tmux new-session -s development -d 
    fi
    tmux switch -t development
else
  echo "We are not in TMUX :/  Let's get in!"
  # Launches tmux in a session called 'base'.
  tmux attach -t development || tmux new -s development
fi


