#!/bin/sh
# The script aids to auto install oh-my-zsh 
# Author: safesky
# Email: safesky@163.com
# Time: 2015-04-17


if [ ! which "git" > /dev/null 2>&1 ] && [ ! which "wget" > /dev/null 2>&1 ] && [ ! which "zsh" > /dev/null 2>&1 ]; then
    echo "To install oh-my-zsh, you must installed zsh, wget and git at first."
    exit 1
fi
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
exit 0
