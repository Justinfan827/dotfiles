#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="tmux.conf vimrc zshrc bashrc ackrc coc-settings.json ideavimrc init.lua"    # list of files/folders to symlink in homedir
directories="fish"    # list of files/folders to symlink in homedir

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
#echo "Moving any existing dotfiles from ~ to $olddir"
#for file in $files; do
    #echo "Creating symlink to $file in home directory."
	#if [ "$file" == "coc-settings.json" ]; then
        #mv ~/.config/nvim/$file ~/dotfiles_old/
		#ln -s $dir/$file ~/.config/nvim/$file
    #elif [ "$file" == "init.lua" ]; then
        #mv ~/.hammerspoon/$file ~/dotfiles_old/
		#ln -s $dir/$file ~/.hammerspoon/$file
	#else
        #mv ~/.$file ~/dotfiles_old/
		#ln -s $dir/$file ~/.$file
	#fi
#done

for directory in $directories; do
	if [ "$directory" == "fish" ]; then
        mv ~/.config/fish ~/dotfiles_old/
		ln -s $dir/fish/ ~/.config/
    fi
done

mv ~/.bash_profile $olddir
ln -s $dir/bashrc ~/.bash_profile
mv ~/.ssh/rc $olddir
ln -s $dir/ssh  ~/.ssh/rc

