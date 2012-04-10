#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

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
bash "$DIR/vimfiles/powerline-fonts/install.sh"

echo "=============================="
echo "Installing Vundle Bundles"
echo "=============================="
vim +BundleInstall +qall
