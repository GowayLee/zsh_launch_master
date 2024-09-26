#!/bin/zsh

# init variables
local opt
local OPIND=1

while getopts ":h" opt; do
    case $opt in
        h)
            echo "Usage: launch_master_main [-$OPTARG]"
            echo "  -h: show this help message and exit"
            return 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            return 1
            ;;
    esac
done

