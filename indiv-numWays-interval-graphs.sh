# !/bin/bash

inputdir=/home/lupones/XPL3/outputCSVfiles/numWaysDataGraphs/npIndivTotal
simplotdir=/home/lupones/simplot/
workloadsFile=/home/lupones/XPL3/indiv-workloads.out

function join_by { local IFS="$1"; shift; echo "$*"; }

cd $inputdir

outputdir=$inputdir"/indivExecGraphs/"
		
while read app; do
	echo $app

 	PLOT=$(echo python3 $simplotdir/simplot.py -g 2 1 -o $outputdir/indivExecGraph-$app.pdf)
				
        filePath=$inputdir  	
        
	# num ways graph
	fileName=$app"-numWaysDataTable.csv"

	PLOT=$PLOT" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [1], linewidth: 0, marker: ["X"], ylabel: IPC, xlabel: Number of ways, labels: [$i"-IPC"]}"'" )
	PLOT=$PLOT" "$(echo --plot "'"{axnum: 0, markeredgewidth: 0, markersize: 4, yright: True, color: ['"'#d490c6'"'], kind: ml, linewidth: 0, marker: ["s"], datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: hits/storage, xlabel: Number of ways, labels: [$i"-hits/storage"], legend_options: {loc: 2}}"'" )
					
        
	# interval graph
        fileName=$app"-intervalDataTable.csv"

	PLOT=$PLOT" "$(echo --plot "'"{kind: l, datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC, xlabel: Interval, labels: [$i"-IPC"]}"'" )
        PLOT=$PLOT" "$(echo --plot "'"{axnum: 1, yright: True, color: ['"'#d490c6'"'], kind: l, datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: hits/storage, xlabel: Interval, labels: [$i"-hits/storage"], legend_options: {loc: 2}}"'" )

	# equalize axis
	PLOT=$PLOT" "$(echo --equal-yaxes)
        for((i=0;i<4;i=i+2));do
        	PLOT=$PLOT" "$(echo $i)
        done
        
	PLOT=$PLOT" "$(echo --equal-yaxes)
        for((i=1;i<4;i=i+2));do
        	PLOT=$PLOT" "$(echo $i)
        done

	touch commands.out
	echo $PLOT >./commands.out
        bash ./commands.out
        rm -f ./commands.out

done <$workloadsFile







