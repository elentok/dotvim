@echo off

echo "=============================="
echo "Installing Vundle"
echo "=============================="
git clone http://github.com/gmarik/vundle.git vimfiles\bundle\vundle

echo "=============================="
echo "Installing Vundle Bundles"
echo "=============================="
gvim +BundleInstall +qall
