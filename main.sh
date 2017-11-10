#! /bin/bash

main() {
    echo "Welcome to your at home File Integrity Checker!"
    echo "What are you looking to do today? Create Baseline(1) Run Check(2) Generate report(3)"

    read opt
    while [ "$opt" != "q" ] || [ "$opt" != "quit" ] || [ "opt" !=  "exit" ]
    do
        case $opt in 
        if [ "$opt" == "1" ];
        then
            echo "Please enter a Directory to create a baseline of: "
            read dir
            source ./baseline_creator.sh "$dir"

        elif [ "$opt" == "2" ];
        then
            echo "WARNING! Running a check destroys any data stored in the temp_Reports file. Do you wish to continue? (y/n) "
            read ans
            if [ "$ans" == "y" ]; then
                echo "Please enter the Directory you want to check: "
                read dir
                source ./run_check.sh "$dir"
            fi

        elif [ "$opt" == "3" ];
        then
            echo "Reporting is in a trial phase, but here's what you can do!"

        fi

    echo "Would you like to do anything else? Create Baseline(1) Run Check(2) Generate report(3) Quit(q) "
    read opt

    done

}

main
