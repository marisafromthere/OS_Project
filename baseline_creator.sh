#!/bin/bash

#This will loop through the files in a directory (Put in loop of directories)

#://askubuntu.com/questions/678914/loop-through-all-files-in-a-folder
createBaseline() {
    BASEPATH=$(find / -name $1 2>/dev/null | head -n1)

    #Checks to make sure user input is an existing directory
    if [ -d "$BASEPATH" ]
    then
        #stores absolute bath to the Baselines folder
        ABSPATH=$(realpath Baselines)

        #calls makeBase func and create custom file name
        #nameCheck is called to ensure a baseline does not already exist
        file=$(makeBase $BASEPATH)
        checker=$(nameCheck $file $ABSPATH | head -n 1)

        #if there is no baseline file then baselineWrite is called to create it
        if [ $checker -ne 1 ]; then
            baselineWrite $BASEPATH > "$ABSPATH/$(echo $file)"
        else
            echo "Oops, you already took this baseline"
        fi
    else
        echo "Oops, that's not a directory!"
    fi
}

makeBase() {
    prefix=$(echo -n $1 | rev | cut -d "/" -f 1 | rev)
    suffix="_baseline.txt"
    filename="$prefix$suffix"
    echo $filename
}

baselineWrite() {
    #Function loops through all files in a folder
    #Uses recursion to loop through existing subdirectories
    for i in "$1"/*
    do
        if [ -d "$i" ]; then
            ls -lid $i
	    baselineWrite "$i"
        elif [ -e "$i" ]; then
            ls -li $i
        fi
    done
}

nameCheck(){
    #Used to make surea baseline doesn't already exist so it doesn't get overwriten
    for i in "$2"/*
    do
        name=$(echo -n "$i" | rev | cut -f 1 -d "/" | rev)
        if [ "$name" == "$1" ]; then
            echo 1
            break
        fi
    done
    echo 0
}
#Call function
createBaseline $1
