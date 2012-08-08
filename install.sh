#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

if [ "`uname -s`" == "Darwin" ]; then
  echo "=============================="
  echo "Installing MacVim"
  echo "=============================="
  brew install macvim --with-cscope --override-system-vim --with-lua
  cd /usr/bin
  sudo mv vim vim-builtin
  sudo ln -s /usr/local/Cellar/macvim/7.3-64/bin/vim vim
fi

echo "=============================="
echo "Installing ~/.vim and ~/.vimrc symlinks"
echo "=============================="
ln -sf "$DIR/.vimrc" ~/.vimrc
ln -sf "$DIR/vimfiles" ~/.vim

echo "=============================="
echo "Installing Vundle"
echo "=============================="
cd ~/.vim
git clone http://github.com/gmarik/vundle.git bundle/vundle

echo "=============================="
echo "Installing Powerline fonts"
echo "=============================="
if [ "`uname -s`" == "Linux" ]; then
  bash "$DIR/vimfiles/powerline-fonts/install.sh"
fi

echo "=============================="
echo "Installing Vundle Bundles"
echo "=============================="
vim +BundleInstall +qall
