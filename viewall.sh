#!/bin/bash
# The script aids to view and get ascii file  info.
# Author: safesky
# Email: safesky@163.com
# Time: 2015-05-17


ls -lh $1
if [ "0" != "$?" ]; then                # file exist?
    echo "file does not exist."
    exit 1
fi

filesize=`ls -l $1 | awk '{print $5}'`  # file size
if [ "0"x = "$filesize"x ]; then         # empty file
    echo "empty file."
    exit 2
fi

istext=`file $1 | grep -ioE "text"`
if [ "text"x = "$istext"x ]; then
    if [ "2"x = "$#"x ] && [ "-e"x = "$2"x ]; then
        if [ -f "/bin/vim" ]; then /bin/vim $1
        elif [ -f "/bin/vi" ]; then /bin/vi $1
        elif [ -f "/bin/nano" ]; then /bin/nano $1
        elif [ -f "/bin/emacs" ]; then /bin/emacs $1
        elif [ -f "/usr/bin/gedit" ]; then /usr/bin/gedit $1
        else less $1
        fi
    else
        less $1
    fi
else
    /bin/file $1
fi

exit 0
