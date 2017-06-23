# !/bin/bash

inputdir=/home/lupones/XPL3/outputCSVfiles/totalGraphs/
simplotdir=/home/lupones/simplot/

# fileType can be either tot or fin
fileType=$1

function join_by { local IFS="$1"; shift; echo "$*"; }

cd $inputdir
for experiment in Total Interval; do
	outputdir=$inputdir
	# IPC total and Hits L3 graph command
        GRAPH=$(echo python3 $simplotdir/simplot.py -g 2 1 -o $outputdir/graphs-IPC-HitsL3-$fileType-$experiment.pdf --title '"'Total IPC and HitsL3 graphs '('$experiment 'measurement)''"' )


	touch commnads.out

	for policy in hg np; do

		filename="totalTable-"$fileType"-"$policy$experiment".csv"

		

		if [[ $policy == np ]]; then	
		GRAPH=$GRAPH" "$(echo --plot "'"{kind: line, datafile: $filename, index: 0, cols: [2], ylabel: "IPC Total", xlabel: "workload id", labels: [$policy]}"'")
		GRAPH=$GRAPH" "$(echo --plot "'"{kind: line, datafile: $filename, index: 0, cols: [3], ylabel: "HITS L3 Total", xlabel: "workload id", labels: [$policy]}"'")
		fi
		if [[ $policy == hg ]]; then
                GRAPH=$GRAPH" "$(echo --plot "'"{axnum: 0, kind: line, datafile: $filename, index: 0, cols: [2], ylabel: "IPC Total", xlabel: "workload id", labels: [$policy]}"'")
                GRAPH=$GRAPH" "$(echo --plot "'"{axnum: 1, kind: line, datafile: $filename, index: 0, cols: [3], ylabel: "HITS L3 Total", xlabel: "workload id", labels: [$policy]}"'")
                fi
	done

	GRAPH=$GRAPH" "$(echo --equal-xaxes)
        for((i=0;i<2;i++));do
        	GRAPH=$GRAPH" "$(echo $i)
	done
	echo $GRAPH

        echo $GRAPH >>./commands.out
        bash ./commands.out
        rm -f ./commands.out


done
