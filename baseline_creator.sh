#!/bin/sh

#This will loop through the files in a directory (Put in loop of directories)

#://askubuntu.com/questions/678914/loop-through-all-files-in-a-folder
function createBaseline() {
    ABSPATH=$(find / -name Baselines 2>/dev/null)
    BASEPATH=$(find / -name $1 2>/dev/null)
    file=$(makeBase $BASEPATH)
    checker=$(nameCheck $file $ABSPATH | head -n 1)
    if [ $checker -ne 1 ]; then
        baselineWrite $BASEPATH
        mv temp.txt "$ABSPATH/$(echo $file)"
    else
        echo "Oops, you already took this baseline"
    fi
}

function makeBase() {
    prefix=$(echo -n $1 | rev | cut -d "/" -f 1 | rev)
    suffix="_baseline.txt"
    filename="$prefix$suffix"
    echo $filename
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
    for i in "$2"/*
    do
        if [ "$(echo -n $i | rev | cut -d "/" -f 1 | rev)" == "$1" ]; then
            echo 1
            break
        fi
    done
    echo 0
}
createBaseline "Downloads" "File.txt"
