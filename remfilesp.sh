#!/bin/bash
# The script aids to replace file name's space character with '-'.
# Author: safesky
# Email: safesky@163.com
# Time: 2015-04-27 

set -e

# Distinguish directory reality
if test ! -d $1 ; then
    echo "Not exist directory."
    return
fi

# Change field sperator
oIFS=$IFS
IFS="
"
# Make temp file to save temp results.
findres=$(mktemp /tmp/tmp.XXXXXXXXXX)
if test ! -f $findres ; then
    echo "Can not make temp file."
    return
fi

find $1 -type f | grep ' ' > $findres

for fi in `cat $findres`
do
    firp=`echo $fi | sed 's/ \{1,\}/-/g'`
    #for debug output
    #echo $fi $firp
    mv "$fi" "$firp"
done

# Delete temp file.
rm -rf $findres

# Resume field sperator
IFS=$oIFS
