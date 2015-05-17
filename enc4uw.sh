#!/bin/bash
# The script aids to bat convert file encoding.
# Author: safesky
# Email: safesky@163.com
# Time: 2015-05-17  


ep="$(type enconv | cut -d ' ' -f 3 | grep '/')"
ip="$(type iconv | cut -d ' ' -f 3 | grep '/')"
pf="(\\.cpp|\\.c|\\.cc|\\.hpp|\\.h|\\.py|\\.java|\\.m|\\.php)$"

if [ "$ep"x = ""x -o "$ip"x = ""x ]; then
    echo "Can not find enconv and iconv to convert files coding."
    exit 1;
fi

if [ ! -e $1 ]; then
    echo "Argument you input is neither a directory nor a file."
    exit 2;
fi

fcodee="zh_CN"
fcodei="cp936"
tcode="UTF-8"
sedopt=

if [ "$2"x = "u"x ]; then       # convert encode for unix
    sedopt="s/\r//g"
elif [ "$2"x = "w"x ]; then     # convert encode for windows
    sedopt="s/\n/\r\n/g"
else
    echo "Usage: sh $0 dir/file u/w"
    exit 3;
fi

if test -d $1 ; then            # bat process directories
    if [ "$2"x = "u"x ]; then
        if [ -e $ep ]; then        
            find $1 -type f | grep -E $pf | xargs -n 1 $ep -L $fcodee -x $tcode
        elif [ -e $ip ]; then
            find $1 -type f | grep -E $pf | xargs -n 1 $ip -f $fcodei -t $tcode {} -o {}
        fi
        find $1 -type f | grep -E $pf | xargs -n 1 sed -i $sedopt
    elif [ "$2"x = "w"x ]; then
        if [ -e $ep ]; then
            tcode="GBK"
            find $1 -type f | grep -E $pf | xargs -n 1 $ep -L $fcodee -x $tcode
        elif [ -e $ip ]; then
            find $1 -type f | grep -E $pf | xargs -n 1 $ip -f $tcode -t $fcodei {} -o {}
        fi
        find $1 -type f | grep -E $pf | xargs -n 1 sed -i $sedopt
    fi
elif test -f $1; then           # process single file
    if [ "$2"x = "u"x ]; then
        if [ -e $ep ]; then
            $ep -L $fcodee -x $tcode $1 && sed -i $sedopt $1
        elif [ -e $ip ]; then
            $ip -f $fcodei -t $tcode $1 -o $1 && sed -i $sedopt $1
        fi
    elif [ "$2"x = "w"x ]; then
        if [ -e $ep ]; then
            tcode="GBK"
            $ep -L $fcodee -x $tcode $1 && sed -i $sedopt $1
        elif [ -e $ip ]; then
            $ip -f $tcode -t $fcodei $1 -o $1 && sed -i $sedopt $1
        fi
    fi
fi

exit 0
