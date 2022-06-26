#
# this script runs lending locally with lending UI
#

 #In the most recently created session, split the (only) window
 #and run htop in the new pane
#tmux split-window -v
# Split the new pane
tmux split-pane -h lfgrunt
tmux split-pane -h lfrun
# Make all three panes the same size (currently, the first pane
# is 50% of the window, and the two new panes are 25% each).
tmux select-layout even-horizontal
