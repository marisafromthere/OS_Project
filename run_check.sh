#!/bin/bash

#Potential start to the checking program
#https://ubuntuforums.org/showthread.php?t=950939


function change_check() {
    echo "Running Check... This takes a moment"
    tempCreate $1
    if [ -e temp.txt ]
    then
        #DIRPATH=$(find / -name $1 2>/dev/null)
        base=./Baselines/$1_baseline.txt

        rm ./Reports/temp_Report.txt

        for i in {1..11..1}
        do
            spotDiff $base temp.txt $i >> ./Reports/temp_Report.txt
        done
        #if theres difference, then there's change.
        #comm -3 --total $base temp.txt
    fi

    rm temp.txt
    echo "Finished Check! Results will be stored in temp_Report until a report is generated."
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

spotDiff() {
    i=1
    j=2
    cat $1 | while read rec 
    do
        BaseTake=$(echo $rec | cut -d " " -f "$3")
        #filename=$(echo $rec | awk {print $9'})
        #filenow=$(ls -l $filename)
        CheckTake=$(head -n$i "$2" | tail -n1 | cut -d " " -f "$3")
        deleteCheck=$(head -n$j "$2" | tail -n1 | cut -d " " -f "$3")
        if [ "$BaseTake" != "$CheckTake" ]
        then
            if [ "$deleteCheck" == "$BaseTake" ]
            then
                 (( i+=1 ))
            else
                echo -n "Change detected in Flag "$3" at: "
                echo -n $rec | cut -d " " -f 10
            fi
        fi
        (( i+=1 ))
        (( j+=1 ))
    done
}

change_check "$1"
