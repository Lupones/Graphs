# !/bin/bash

inputdir=/home/lupones/XPL3/outputCSVfiles/workloadsGraphs/
simplotdir=/home/lupones/simplot/

# fileType can be either tot or fin
fileType=$1

function join_by { local IFS="$1"; shift; echo "$*"; }

cd $inputdir

DIR=$(echo $inputdir"*")

while IFS='' read -r line || [[ -n "$line" ]]; do
	#echo "Processing $(basename $f) in $DIR"
	
	workload=$line
        echo "workload = $workload"

	for experiment in Total Interval; do
		outputdir=$inputdir
		# IPC, Hits L3 and Occupancy graph command
        	GRAPH=$(echo python3 $simplotdir/simplot.py -g 4 1 -o $outputdir/bargraph-$fileType-$workload-$experiment.pdf ) 

#--title '"'Comparative graphs for $workload '('$experiment 'measurement)''"')


		touch commnads.out
		
			
		filename="results-"$fileType"_"$workload"_"$experiment".csv"
		echo $filename
		
		# HITS L3
		GRAPH=$GRAPH" "$(echo --plot "'"{kind: b, datafile: $inputdir/$filename, index: 0, cols: [3,6], ylabel: "Total Hits L3", xlabel: "App"}"'")
		
		# OCCUP L3
		GRAPH=$GRAPH" "$(echo --plot "'"{kind: b, datafile: $inputdir/$filename, index: 0, cols: [2,5], ylabel: "Total Occup. L3", xlabel: "App"}"'")
                		
		# IPC
		GRAPH=$GRAPH" "$(echo --plot "'"{kind: b, datafile: $inputdir/$filename, index: 0, cols: [1,4], ylabel: "Total IPC", xlabel: "App"}"'")
		

		echo $GRAPH
        	echo $GRAPH >>./commands.out
        	bash ./commands.out
        	rm -f ./commands.out

	done
done </home/lupones/XPL3/workloads.out
