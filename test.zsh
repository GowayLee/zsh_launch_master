#!/bin/zsh

echo $(pwd)
echo $0
echo $(readlink -f $0)
echo $(dirname $(readlink -f $0))