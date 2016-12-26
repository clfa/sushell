# To get the latest files in special directory ipath.
# Author: safesky
# Email: safesky@163.com

printf "\033c"

# Check ipath valitility
if [ ! -e $1 ]; then
    echo "$1 Is Not Valid Directory."
fi

test="T"

ti=`date "+%F"`
latestdir="$1""_""$ti""_bk"
if [ ! -e "$latestdir" ]; then
    mkdir "$latestdir"
fi

if [ "$3"X == ""X ]; then
    find $1 -mtime $2 ! -ipath '*bin*' ! -ipath '*.tlog*' ! -ipath '*ipch*' ! -ipath '*.svn*' ! -ipath '*.git*' ! -ipath '*.user*' ! -ipath '*Unicode*Debug*'  ! -ipath '*Unicode*Release*' ! -ipath '*DebugU*' ! -ipath '*ReleaseU*' ! -ipath '*.log*' ! -ipath '*.obj*' ! -ipath '*.sbr*' ! -ipath '*.aps*' ! -ipath '*.sdf*' ! -ipath '*.opt*' ! -ipath '*.lib*' ! -ipath '*.dll*' ! -ipath '*.ocx*' ! -ipath '*.tlh*' ! -ipath '*.tlb*' ! -ipath '*.exp' ! -ipath '*.ilk' ! -ipath '*.pdb' ! -ipath '*.sln' ! -ipath '*.suo' ! -ipath '*.res' ! -ipath '*.idb' ! -ipath '*_i.h' ! -ipath '*_i.c' |  grep -i '\.'  | xargs -t -i -n 1 cp -r -u --parents '{}' "$latestdir"
elif [ "$3"X == "-a"X ]; then
    for fileone in `find $1 ! -ipath '*bin*' ! -ipath '*.tlog*' ! -ipath '*ipch*' ! -ipath '*.svn*' ! -ipath '*.git*' ! -ipath '*.user*' ! -ipath '*Unicode*Debug*'  ! -ipath '*Unicode*Release*' ! -ipath '*DebugU*' ! -ipath '*ReleaseU*' ! -ipath '*.log*' ! -ipath '*.obj*' ! -ipath '*.sbr*' ! -ipath '*.aps*' ! -ipath '*.sdf*' ! -ipath '*.opt*' ! -ipath '*.ilk' ! -ipath '*.pdb' ! -ipath '*.idb' ! -ipath '*.bz2' ! -ipath '*.rar' ! -ipath '*.7z' ! -ipath '*.zip'`
    do
        if [ -f "$fileone" ]; then
            cp -r -u --parents "$fileone" "$latestdir"
        fi
    done

fi

tar jcPf "${latestdir}.tar.bz2" "$latestdir"
