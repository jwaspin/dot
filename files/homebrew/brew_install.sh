#!/bin/bash

CASKS=0

while getopts ":c:" opt; do
    case $opt in
        c)
            CASKS=1
            CASKSLIST=$OPTARG
            ;;
        :)
            if [[ $OPTARG == "c" ]]; then
                CASKS=1
                CASKLIST="casks_min.txt"
            fi
            ;;
    esac
done

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

if [ $CASKS -eq 1 ]; then
    brew cask install $(cat $CASKLIST)
fi
