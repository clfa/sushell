#!/bin/sh

# To clean the projects program rubbish files.
# Author: safesky
# Email: safesky@163.com

# Clean the Display Screen
printf "\033c"

# Check the Input Path Validity.
if [ ! -e $1 ] || [ "$1"X == ""X ]; then
	echo "Path Is Not Valid."
	exit 1
fi

test=""

# Remove the Rubbish Files Directories
echo ============================================================
echo Remove the Rubbish Files Directories
for i in "Unicode Debug" "Unicode Release" ".svn" "ipch"
do
	if [ "$test"X == "T"X ]; then
		echo \"$i\"
	else
		find $1 -type d -iname "$i" -exec rm -rf {} \; 2> /dev/null
	fi
done
echo ============================================================

# Remove *.sdf, *.aps, *.opt Files etc.
echo
echo ============================================================
echo Remove *.sdf, *.aps, *.opt Files etc.
for i in '*.sdf' '*.aps' '*.opt'}
do
	if [ "$test"X == "T"X ]; then
		find $1 -iname "$i"
	else
		find $1 -iname "$i" -exec rm -rf {} \; 2> /dev/null
	fi
done
echo ============================================================

# Remove Some Special Files in Bin Directory.
echo
echo ============================================================
echo Remove Some Special Files in Bin Directory.
for i in '*.ilk' 'h*.lib' 'h*.dll' '[deh]*.ocx' 'h*.exp' '[^v]*.pdb' '*.exe'
do
	if [ "$test"X == "T"X ]; then
		find "$1/bin" -iname "$i"
	else
		find "$1/bin" -iname "$i" -exec rm -rf {} \; 2> /dev/null
	fi
done
echo ============================================================
