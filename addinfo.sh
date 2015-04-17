#!/bin/bash
# The script aids to add "info" model into input script.
# "Info" contents is as follow.
# Author: safesky
# Email: safesky@163.com
# Time: 2015-02-21

info="# The script aids to ......\\
# Author: safesky\\
# Email: safesky@163.com\\
# Time: 2015- - "

if [ ! -e $1 ]; then
    echo -e "Not exist input file."
    exit 1
fi

sed -i "1a $info \n" $1
