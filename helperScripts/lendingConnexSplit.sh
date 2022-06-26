#!/bin/sh

# shell script to start up lending / connex from scratch locally

tmux splitw -h

# Select pane 1: run zsh alias for lending
tmux selectp -t 1 
tmux send-keys "unset AWS_VAULT &&  aws-vault exec lending-dev --duration=12h --no-session && lending" C-m 

# Select pane 2: run zsh alias for connex
tmux selectp -t 2 
tmux send-keys "unset AWS_VAULT && aw exec cx-dev && connex" C-m
