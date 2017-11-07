#! /bin/sh

#This will loop through the files in a directory (Put in loop of directories)

#://askubuntu.com/questions/678914/loop-through-all-files-in-a-folder

function loop() { 
    for i in "$1"/*
    do
        if [ -d "$i" ]; then
            loop "$i"
        elif [ -e "$i" ]; then
            echo $i
        else
            echo "$i"" - Folder Empty"
        fi
    done
}

loop "$PWD"


