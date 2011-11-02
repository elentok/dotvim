#!/bin/bash

rm config.zip
zip -r vimconfig.zip vimfiles/* .vimrc -x "vimfiles/bin/*" "vimfiles/bundle-disabled/*"
