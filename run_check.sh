#!/bin/bash

#Potential start to the checking program
#https://ubuntuforums.org/showthread.php?t=950939


function change_check() {
    tempCreate $1
    if [ -e temp.txt ]
    then
        #DIRPATH=$(find / -name $1 2>/dev/null)
        base=./Baselines/$1_baseline.txt

        #if theres difference, then there's change.
        comm -3 $base temp.txt
    fi

}

tempCreate() {
    path=$(find / -name $1 2>"/dev/null")
    if [ -d "$path" ] && [ -e ./Baselines/$1_baseline.txt ]
    then
        dirLoop $path > temp.txt
    else
        echo "Oops, you don't have a baseline to check against!"
    fi
}

dirLoop() {
    for i in "$1"/*
    do
        if [ -d "$i" ]; then
            ls -lid $i
            dirLoop "$i"

        elif [ -e "$i" ]; then
            ls -lid $i
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
change_check OS_Project
