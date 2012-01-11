#!/bin/bash

DIR=$(dirname "${BASH_SOURCE[0]}")
DIR=$(cd -P $DIR && pwd)

ln -sf "$DIR/vimrc" ~/.vimrc
ln -sf "$DIR/vimfiles" ~/.vim
