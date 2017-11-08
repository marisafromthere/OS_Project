#!/bin/bash

#This will loop through the files in a directory (Put in loop of directories)

#://askubuntu.com/questions/678914/loop-through-all-files-in-a-folder
function makeBase() {
    prefix=$(echo -n $1 | rev | cut -d "/" -f 1 | rev)
    suffix="_baseline.txt"
    filename="$prefix$suffix"
    checker=$(nameCheck $filename | head -n 1)
    if [ $checker -ne 1 ]; then
        baselineWrite $1
        mv temp.txt "$PWD/Baselines/$(echo $filename)"
    else
        echo "Oops, you already took this baseline"
    fi
}

function baselineWrite() { 
    for i in "$1"/*
    do
        if [ -d "$i" ]; then
            ls -l -d $i
	    baselineWrite "$i"
        elif [ -e "$i" ]; then
            ls -l $i
        fi
    done >> temp.txt
}

function nameCheck(){
    for i in "$PWD/Baselines"/*
    do
        if [ "$(echo -n $i | rev | cut -d "/" -f 1 | rev)" == "$1" ]; then
            echo 1
            break
        fi
    done
    echo 0
}
makeBase "$PWD" "File.txt"
