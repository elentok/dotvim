#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

echo "=============================="
echo "Installing ~/.vim and ~/.vimrc symlinks"
echo "=============================="
ln -sf "$DIR/vimrc" ~/.vimrc
ln -sf "$DIR/vimfiles" ~/.vim

bash "$DIR/vimfiles/bundle/powerline/fonts/install.sh"



