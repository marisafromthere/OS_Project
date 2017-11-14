# OS_Project
File System Integrity checker

This program allows users to create baselines of given directory trees and run checks against them to monitor changes to files. Using BASH scripting the program presents a user-friendly main script that provides and easy and comprehensive way for the user to create baselines of their choosen directory tree, run checks against their baselines, and generate reports after running the checks. 

# How To Run
To run this program, download or clone it from this repository and run the main.sh script using: 

"./main.sh"

If you wish to run this program to take information from files/directories that require administrative priviledge run: 

"sudo ./main.sh"

or a variation that allows programs to be run as administrator.

# How is Works
* To loop through directories and sub-directories a for loop is used to hit all files and an if statement is used to check if that file is a directory or not. If yes, the function calls itself and starts over in the new directory and continues on from there
* Checking is done by reading a previously taken baseline and a newly taken temp file line by line, and field by field checking for changes. 
* These changes are flagged and the flags can be used to generate an easy to read report displaying high priority changes first and low priority changes last.
* Each bullet is its own script that are all used in the main.sh script to make it more readable and easy to understand
