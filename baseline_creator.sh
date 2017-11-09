#!/bin/bash

#This will loop through the files in a directory (Put in loop of directories)

#://askubuntu.com/questions/678914/loop-through-all-files-in-a-folder
createBaseline() {
    ABSPATH=$(realpath Baselines)
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

makeBase() {
    prefix=$(echo -n $1 | rev | cut -d "/" -f 1 | rev)
    suffix="_baseline.txt"
    filename="$prefix$suffix"
    echo $filename
}

baselineWrite() { 
    for i in "$1"/*
    do
        if [ -d "$i" ]; then
            ls -lid $i
	    baselineWrite "$i"
        elif [ -e "$i" ]; then
            ls -li $i
        fi
    done >> temp.txt
}

nameCheck(){
    for i in "$2"/*
    do
        stuff=$(echo -n "$i" | rev | cut -f 1 -d "/" | rev)
        if [ "$stuff" == "$1" ]; then
            echo 1
            break
        fi
    done
    echo 0
}
