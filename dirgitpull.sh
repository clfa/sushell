#/bin/sh

#The script aims to bat pull source code directories' which were pulled from github.
#Author: safesky
#Email: safesky@163.com
#Date:  2016/10/22

# Whether the input directory is valid?
if [ ! -e $1 ]; then
    echo - e "Directory $1 is not exist!" 
    exit 1 
fi

# Distinguish test or work: 'T' for test
to_test=''

# Get the git folders of $1
cd "$1"
full_dir=`pwd`
git_pull_dir=`find "$full_dir" -name .git | awk -F ".git" '{$1=$1; print $1}' | grep -i "/$"`
if [ "$to_test"X == "T"X ]; then
	echo $git_pull_dir
fi

# If the git_pull_dir has source code which pulled by git, redo 'git pull' operation 
# to update the source code now.
if [ ! "$git_pull_dir"X == ""X ]; then
	for gitsubdir in $git_pull_dir
	do
		if [ -d "$gitsubdir" ]; then
			if [ "$to_test"X == "T"X ]; then
				echo "$gitsubdir"
			else
				echo "=== Into directory $gitsubdir ==="
				echo ""
				cd "$gitsubdir" && git pull && cd "$full_dir"
				echo ""				
				echo "=== Out of directory $gitsubdir ==="
				echo ""
			fi
		fi
	done
else
	echo "Can not find source code directories."
fi
