alias cls='printf "\033c"'
alias clrub='find ~ -name "*~*" -exec rm {} \;'
alias mysync='sync && sync && sync'
alias applyshrc='source /home/$(whoami)/.zshrc'
src=/usr/local/src
alias cdsrc='cd $src'
alias df='df -lh'
alias mkprodir='mkdir -p ./{Backup,RefDocs,RefVideo,Software,Work}'

#function rpmfind() {
#    rpm -qa | grep -i $1
#}

#function yumsearch() {
#    yum search $1 | grep -i ^$1 | awk -F "." '{$1=$1; print $1}' | awk 'BEGIN {ORS=" "} last!=$0 {print} {last=$0}' && echo -e "\n"
#}

#alias logoff='pkill -u $(whoami)'

function viewall() {
    ls -lh $1
    if [ "0" != "$?" ]; then                # file exist?
        return
    fi
    filesize=`ls -l $1 | awk '{print $5}'`  # file size
    if [ "0" == "$filesize" ]; then         # empty file
        return
    fi
    istext=`file $1 | grep -ioE "text"`
    if [ "text" == "$istext" ]; then
        less $1
    else
        /bin/file $1
    fi

}

function ohmyzshinstall() {
    type "upgrade_oh_my_zsh" > /dev/null 2>&1
    if [ "0"x = "$?"x ]; then
        echo "Oh-my-zsh has been installed."
        return
    fi
    if [ ! which "git" > /dev/null 2>&1 ] && [ ! which "wget" > /dev/null 2>&1 ] && [ ! which "zsh" > /dev/null 2>&1 ] ; then
        echo "To install oh-my-zsh, you must installed zsh, wget and git at first."
        return
    fi
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
}

function DelVCRub {
    printf "\033c"
    if [ -d $1 ];  then
        find $1 -type d -name '*.svn*' -exec rm -rf {} \; >/dev/null 2>&1
        find $1 -name '*.sdf' -exec rm -rf {} \; >/dev/null 2>&1 
        find $1 -name '*.plg' -exec rm -rf {} \; >/dev/null 2>&1 
        find $1 -name '*.opt' -exec rm -rf {} \; >/dev/null 2>&1
        find $1 -name '*.ncb' -exec rm -rf {} \; >/dev/null 2>&1
        find $1 -type d | grep '^Debug$' | xargs -i rm -rf {} >/dev/null 2>&1
        find $1 -type d | grep '^Release$' | xargs -i rm -rf {} >/dev/null 2>&1
        find $1 -type d | grep '^ipch$' | xargs -i rm -rf {} >/dev/null 2>&1
    else
        echo "Error directory path..."
    fi
}

C_INCLUDE_PATH=/usr/include:/usr/local/include:$C_INCLUDE_PATH
export C_INCLUDE_PATH

CPLUS_INCLUDE_PATH=/usr/include:/usr/local/include:$CPLUS_INCLUDE_PATH 
export CPP_INCLUDE_PATH

CPATH=/usr/include:/usr/local/include:$CPATH
export CPATH

OBJC_INCLUDE_PATH=/usr/include:/usr/local/include:$OBJC_INCLUDE_PATH 
export OBJC_INCLUDE_PATH

#找到静态库的路径
LIBRARY_PATH=/usr/local/lib/:/usr/local/lib64:$LIBRARY_PATH
export LIBRARY_PATH

#找到动态链接库的路径
LD_LIBRARY_PATH=/usr/local/lib/:/usr/local/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
# alias ohmyzsh="mate ~/.oh-my-zsh"
