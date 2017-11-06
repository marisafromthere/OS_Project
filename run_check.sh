#! /bin/sh

#Potential start to the checking program
#https://ubuntuforums.org/showthread.php?t=950939

function change_check(baseline, directory, check)
{
    base="/tmp/monitor.base"
    dir_to_monitor="/home/yhlee/test/"
    check="/tmp/status_now"
    if [ ! -e $base ] ;then
        find "$dir_to_monitor" |sort > $base
    fi
    # check 
    find $dir_to_monitor | sort > $check
    #if there's difference, then there's change.
    diff $base $check
} 
