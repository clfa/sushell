#/bin/sh

#The script aims to clean directories' files which were created by make command.
#The argument '-r' or '--r' is does clean work recusive in current directory.
#Author: safesky
#Email: safesky@163.com
#Date:  2016/10/05

function doclwk () {
    #whether the input directory is valid?
    if [ ! -e "$1" ]; then
        exit 1 
    fi 
    
    cd "$1"
    `make clean 2> /dev/null` 

    for nmf in "$1"/*
    do
    	if [ -d "$nmf" ]; then 
    	    if [ "$dorecusive"x == "1"x ]; then
        		#recursive does clean work
		        doclwk "$nmf" 
	        fi 
	    fi 
    done
}

#whether the input directory is valid?
if [ ! -e $1 ]; then
    echo - e "$1 is not exist!" 
    exit 1 
fi 

dorecusive="0"
if [ "$2"x == "-r"x ] ||[ "$2"x == "--r"x ] ||[ "$2"x == "-R"x ] ||[ "$2"x == "--R"x ]; then
    dorecusive="1"
fi 

doclwk "$1" 
