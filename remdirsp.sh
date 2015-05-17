#!/bin/bash

if test ! -d $1 ; then
    echo "Not a valid argument."
    exit 1
fi

findres="findres.txt"

find $1 -type d | grep ' ' > $findres
#for debug echo
#less $findres

if [ -f $findres ]; then
    oIFS=$IFS
    IFS="
"
    # must use this script carefully, can not change system.
    read -p "You want continue do this? (Y/N)" res
    case $res in
        "Y"|"y")
        ;;
        "N"|"n")
            exit 2
            ;;
        *)
            echo "Can not distinguish your input."
            exit 3
            ;;
    esac

    for dir in `cat $findres`
    do
        #echo "$dir"
        direp=`echo $dir | sed 's/ \{1,\}/-/g'`
        #echo "$direp"
        mv "$dir" "$direp"
    done
    
    rm -rf $findres
    
    IFS=$oIFS
else
    echo "Can not find the directory to meet the condition."
    exit 4
fi
exit 0
