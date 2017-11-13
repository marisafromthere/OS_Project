#!/bin/bash

#Makes a basic report sorting the found changes by priority level
#every change displayed with path name
createReport() {
    echo "HIGH PRIORITY CHANGES"

    echo " "
    echo "Index Number Channge Detected"
    cat ./Reports/temp_Report.txt | grep "Flag 1 " | cut -d " " -f 7

    echo " "
    echo "Privilege Change Detected"
    cat ./Reports/temp_Report.txt | grep "Flag 2 " | cut -d " " -f 7

    echo " "
    echo "Owner Change Detected"
    cat ./Reports/temp_Report.txt | grep "Flag 4 " | cut -d " " -f 7

    echo " "
    echo "Group Change Detected"
    cat ./Reports/temp_Report.txt | grep "Flag 5 " | cut -d " " -f 7

    echo " "
    echo "MEDIUM PRIORITY CHANGES"

    echo " "
    echo "Number of Links Change Detected"
    cat ./Reports/temp_Report.txt | grep "Flag 3 " | cut -d " " -f 7

    echo " "
    echo "Change in File Size Detected"
    cat ./Reports/temp_Report.txt | grep "Flag 6 " | cut -d " " -f 7

    echo " "
    echo "LOW PRIORITY CHANGES"

    echo " "
    echo "Last Access Time Change Detected"
    cat ./Reports/temp_Report.txt | grep "Flag 10 " | cut -d " " -f 7

    echo " "
    echo "Change in Real Path Detected"
    cat ./Reports/temp_Report.txt | grep "Flag 11 " | cut -d " " -f 7
}
createReport
