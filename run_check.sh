#!/bin/bash

#Potential start to the checking program
#https://ubuntuforums.org/showthread.php?t=950939


function change_check() {
    DIRPATH=$(find / -name $1 2>/dev/null)
    base="/Baselines/"$1"_baseline.txt"
    check= tempCreate $1
    if [ ! -e $base ] ;then
        find "$DIRPATH" | sort > $base
    fi
    # check
    find $DIRPATH | sort > $(echo "$check")

    #if theres difference, then there's change.
    diff $base $check
}

tempCreate() {
    path=$(find / -name $1 2>"/dev/null")
    if [ -d "$path" ] && [ -e ./Baselines/$1_baseline.txt ]
    then
        dirLoop $path > temp.txt
    fi
}

dirLoop() {
    for i in "$1"/*
    do
        if [ -d "$i" ]; then
            ls -l -d $i
            dirLoop "$i"

        elif [ -e "$i" ]; then
            ls -l $i
        fi
    done
}

comparebaseline_example () {
    if [ -d $1 ]
    then
        if [ -f "Baselines/$1.txt" ]
        then
            cat "Baselines/$1.txt" | while read record
            do
                perms=$(echo $rec | awk {'print $1'})
                filename=$(echo $rec | awk {'print $9'})
                filenow=$(ls -l $filename)
                permsnow=$(echo $filenow | awk {'print $1'})
                if [ $perms == $permsnow ]
                then
                    echo "permissions haven't changed"
                fi
            done
        fi
    fi
}


