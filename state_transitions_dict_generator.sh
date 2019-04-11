#!/bin/bash
# set -x

# $1 = experiment 
# E.g 170719

inputdir=/home/lupones/XPL3/outputCSVfiles/$1/criticalAlone/states/
outputdir=/home/lupones/XPL3/outputCSVfiles/$1/criticalAlone/states/


sudo python3 ./state_transitions_dict_generator.py -id $inputdir -od $outputdir $listways
