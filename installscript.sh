# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
# install iterm2
brew cask install iterm2
# install oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# install zsh-syntax-highlighting
brew install zsh-syntax-highlighting
brew install fzf
brew install nvm
brew install ag
brew install nvim
brew install tmux
brew install python #python3
# installl powerlevel
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
# make nvim file
mkdir -p ~/.config/nvim
touch ~/.config/nvim/init.vim
echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc" >>  ~/.config/nvim/init.vim
