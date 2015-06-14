#!/bin/bash
# The script aids to read files list and git clone or update projects.
# Author: safesky
# Email: safesky@163.com
# Time: 2015-06-14  


# Read from files list and git clone my codes.
if [ -e repo.list ]; then
    fl=`cat repo.list`
else
    echo "Can not find repo.list file."
    exit 1
fi

logf="batdown.log"
test -e $logf && rm $logf
for mf in $fl
do
    if [ "$1"x = "-u"x ]; then
        cd ${mf} && /usr/bin/git pull && cd ..
        if [ "$?"x = "0"x ]; then
            echo "Update ${mf} successed." >> $logf
        else
            echo "Update ${mf} failed." >> $logf
        fi
    else
        /usr/bin/git clone "https://github.com/liangfengchen/${mf}.git"
        test "$?"x = "0"x && echo "git clone ${mf} successed." >> $logf
    fi
done
exit 0
