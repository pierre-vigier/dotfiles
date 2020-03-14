#!/bin/sh

CURRENT_PATH=`pwd`

#echo "Symlink vimrc file"
#
#echo ln -s $CURRENT_PATH/vimrc $HOME/.vimrc
#
#ln -s $CURRENT_PATH/vimrc $HOME/.vimrc
#
#git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
#
#vim +PluginInstall +qall

echo "Neovim conf"

echo "mkdir -p $HOME/.config/nvim"

mkdir -p $HOME/.config/nvim

echo ln -s $CURRENT_PATH/nvim-init.vim $HOME/.config/nvim/init.vim

ln -s $CURRENT_PATH/nvim-init.vim $HOME/.config/nvim/init.vim

echo "Symlink zshrc file"

echo ln -s $CURRENT_PATH/zshrc $HOME/.zshrc

ln -s $CURRENT_PATH/zshrc $HOME/.zshrc

echo ln -s $CURRENT_PATH/psqlrc $HOME/.psqlrc

ln -s $CURRENT_PATH/psqlrc $HOME/.psqlrc
