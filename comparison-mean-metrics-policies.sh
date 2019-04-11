# !/bin/bash

# $1 = name of experiment
# E.g. 170719

inputdir=/home/lupones/XPL3/outputCSVfiles/$1/
simplotdir=/home/lupones/simplot/
workloadsFile=/home/lupones/XPL3/outputCSVfiles/$1/workloads$1.out

cd $inputdir

outputdir=$inputdir

echo "WELCOME"

#Plot comparison graphs of policies
for i in "stp" "antt" "power-energy-pkg-" "power-energy-ram-" "interval" "unfairness" "ipc"; do

    PLOTpolicies=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir"/"$i"-graph.pdf")
    filePath=$inputdir
    fileName=$i"-workloads-totals.csv"
    fileName=$i"table.csv"

    PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [2,3,4,5,6,7,8,9],  marker: ["X"], xlabel: workload, ylabel: $i}"'" )


    touch commands.out
    echo $PLOTpolicies
    echo $PLOTpolicies >./commands.out
    bash ./commands.out
    rm -f ./commands.out
done
