#!/bin/sh

CURRENT_PATH=`pwd`

echo "Symlink vimrc file"

echo ln -s $CURRENT_PATH/vimrc $HOME/.vimrc

ln -s $CURRENT_PATH/vimrc $HOME/.vimrc

git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim

vim +PluginInstall +qall

echo "Symlink zshrc file"

echo ln -s $CURRENT_PATH/zshrc $HOME/.zshrc

ln -s $CURRENT_PATH/zshrc $HOME/.zshrc
