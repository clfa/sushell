#!/bin/bash

if test ! -d $1 ; then
    echo "Not a valid argument."
    return
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
            return
            ;;
        *)
            echo "Can not distinguish your input."
            return
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
    return
fi
