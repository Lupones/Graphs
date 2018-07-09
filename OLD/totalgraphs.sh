# !/bin/bash

inputdir=/home/lupones/XPL3/outputCSVfiles/slowdownGraphs/
simplotdir=/home/lupones/simplot/

# fileType can be either tot or fin (passed as first argument on the cli)
fileType=$1

function join_by { local IFS="$1"; shift; echo "$*"; }

cd $inputdir
for experiment in Total Interval; do
    outputdir=$inputdir
	# IPC total and Hits L3 graph command
        GRAPH=$(echo python3 $simplotdir/simplot.py -g 2 1 -g 2 1 -o $outputdir/graphs-totalERR-$fileType-$experiment.pdf)

#--title '"'Av. Norm. Turnaround Time ANTT graph '('$experiment 'measurement)''"' --title '"'System Thrpughput STP graph '('$experiment 'measurement)''"' --title '"'Total IPC graph '('$experiment 'measurement)''"' --title '"'Total HitsL3 graph '('$experiment 'measurement)''"' )


	touch commnads.out

	for policy in hg np; do

		filename="totalERRTable-"$fileType"-"$policy$experiment".csv"

		

		if [[ $policy == np ]]; then	
                GRAPH=$GRAPH" "$(echo --plot "'"{kind: line, datafile: $filename, index: 0, cols: [6], ecols: [7], ylabel: "ANTT", xlabel: "workload id", labels: [$policy]}"'")
		GRAPH=$GRAPH" "$(echo --plot "'"{kind: line, datafile: $filename, index: 0, cols: [8], ecols: [9], ylabel: "STP", xlabel: "workload id", labels: [$policy]}"'")
		GRAPH=$GRAPH" "$(echo --plot "'"{kind: line, datafile: $filename, index: 0, cols: [2], ecols: [3], ylabel: "IPC Total", xlabel: "workload id", labels: [$policy]}"'")
		GRAPH=$GRAPH" "$(echo --plot "'"{kind: line, datafile: $filename, index: 0, cols: [4], ecols: [5], ylabel: "HITS L3 Total", xlabel: "workload id", labels: [$policy]}"'")
		fi

		if [[ $policy == hg ]]; then
		GRAPH=$GRAPH" "$(echo --plot "'"{axnum: 0, kind: line, datafile: $filename, index: 0, cols: [6], ecols: [7], ylabel: "ANTT", xlabel: "workload id", labels: [$policy]}"'")
                GRAPH=$GRAPH" "$(echo --plot "'"{axnum: 1, kind: line, datafile: $filename, index: 0, cols: [8], ecols: [9], ylabel: "STP", xlabel: "workload id", labels: [$policy]}"'")
                GRAPH=$GRAPH" "$(echo --plot "'"{axnum: 2, kind: line, datafile: $filename, index: 0, cols: [2], ecols: [3], ylabel: "IPC Total", xlabel: "workload id", labels: [$policy]}"'")
                GRAPH=$GRAPH" "$(echo --plot "'"{axnum: 3, kind: line, datafile: $filename, index: 0, cols: [4], ecols: [5], ylabel: "HITS L3 Total", xlabel: "workload id", labels: [$policy]}"'")
                fi
	done

	#GRAPH=$GRAPH" "$(echo --equal-xaxes)
        #for((i=0;i<2;i++));do
        #	GRAPH=$GRAPH" "$(echo $i)
	#done
	#echo $GRAPH
	echo $GRAPH
	exit

        echo $GRAPH >>./commands.out
        
	bash ./commands.out
        rm -f ./commands.out


done
