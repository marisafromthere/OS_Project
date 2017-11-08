#!/bin/sh

#Potential start to the checking program
#https://ubuntuforums.org/showthread.php?t=950939

source ./baseline_creator.sh

function change_check() {
    DIRPATH=$(find / -name $1 2>/dev/null)
    base="/Baselines/"$1"_baseline.txt"
    check= baselineWrite  $1
    if [ ! -e $base ] ;then
        find "$DIRPATH" | sort > $base
    fi
    # check
    find $DIRPATH | sort > $check
    #if there's difference, then there's change.
    diff $base $check
}

change_check OS_Project
