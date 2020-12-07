#!/bin/sh
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="tmux.conf vimrc zshrc bashrc ackrc coc-settings.json ideavimrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    echo "Creating symlink to $file in home directory."
	if [ "$file" == "coc-settings.json" ]; then
        mv ~/.config/nvim/$file ~/dotfiles_old/
		ln -s $dir/$file ~/.config/nvim/$file
	else
        mv ~/.$file ~/dotfiles_old/
		ln -s $dir/$file ~/.$file
	fi
done

mv ~/.bash_profile $olddir
ln -s $dir/bashrc ~/.bash_profile
mv ~/.ssh/rc $olddir
ln -s $dir/ssh  ~/.ssh/rc

