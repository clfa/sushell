#!/bin/bash
# The script aids to bat backup gpg keys.
# Author: safesky
# Email: safesky@163.com
# Time: 2015-04-11

# To get all pub key's line
allpub=`/bin/gpg --list-keys | grep -i pub`
# Is it empty? If current user has not keys, exit program and return 1.
test "$allpub"x = ""x && echo "You don't have keys to save." && exit 1
# To get all keys' id
pubid="$(/bin/gpg --list-keys | egrep -B1 'safesky' | grep pub | \
	awk '{print $2}' | grep -v '^$' | tr '/' '\t' | cut -f 2)"
# Test echo result
# echo $pubid
tarname="$(whoami)_$(date +%F).kbak"
find . -name "*.*kbak" -exec rm {} \; 2>>"$tarname"".log"
for pi in $pubid
do
	name="$(whoami)_${pi}_$(date +%F)"
	/bin/gpg -a -o ${name}.kbak --export $pi 
	op1="$?"
	/bin/gpg -a -o ${name}.skbak --export-secret-keys $pi
	op2="$?"
	if [ "$op1"x != "0"x ] || [ "$op2"x != "0"x ]; then
		echo "Pub key $pi backup operation makes mistake." 2>>"$tarname"".log"
	fi
done
/usr/bin/tar -jcp -f "$tarname"".tar.bz2" *.kbak *.skbak 2>>"$tarname"".log"
rm -rf *.kbak *.skbak 2>>"$tarname"".log"
logsize=`ls -l "$tarname"".log" | awk '{print $5}'`
test "$logsize"x = "0"x && rm "$tarname"".log" 
exit 0
