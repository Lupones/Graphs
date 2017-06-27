# !/bin/bash

inputdir=/home/lupones/XPL3/outputCSVfiles/numWaysDataGraphs/
simplotdir=/home/lupones/simplot/
workloadsFile=/home/lupones/XPL3/workloads.out

function join_by { local IFS="$1"; shift; echo "$*"; }

cd $inputdir
for policy in np; do
	for experiment in Total; do
		dir=$policy$experiment
		echo $dir
		outputdir=$inputdir"/"$dir"/graphs-"$policy$experiment"/"	
        	cd $dir
		while read workload; do
			echo $workload
			cd $workload
			filePath=$(pwd)

			# have in a single pdf all the graphs of the workload
 			PLOT=$(echo python3 $simplotdir/simplot.py -g 2 2 -g 2 2 -o $outputdir/numWaysDataGraph-$workload.pdf)
			# loop over all the apps in the workload
			# generate a graph for each one 
			core=0
			while IFS='-' read -ra APP; do
      				for i in "${APP[@]}"; do
					
					if [[ $i == *.* ]]
					then
						fileName="0"$core"_"$i"-numWaysDataTable-fin.csv"
					else
						fileName="0"$core"_"$i"_base-numWaysDataTable-fin.csv"
					fi
					echo $fileName

					PLOT=$PLOT" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [1], linewidth: 0, marker: ["X"], ylabel: IPC, xlabel: Number of ways, labels: [$i"-IPC"]}"'" )
					PLOT=$PLOT" "$(echo --plot "'"{axnum: $core, markeredgewidth: 0, markersize: 4, yright: True, color: ['"'#d490c6'"'], kind: ml, linewidth: 0, marker: ["s"], datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: hits/storage, xlabel: Number of ways, labels: [$i"-hits/storage"], legend_options: {loc: 2}}"'" )
					core=$((core+1))
					
      				done

 			done <<< $workload

			PLOT=$PLOT" "$(echo --equal-xaxes)
			for((i=0;i<16;i++));do
                                PLOT=$PLOT" "$(echo $i)	
			done
			PLOT=$PLOT" "$(echo --equal-yaxes)
                        for((i=0;i<16;i=i+2));do
                                PLOT=$PLOT" "$(echo $i)
                        done
			PLOT=$PLOT" "$(echo --equal-yaxes)
                        for((i=1;i<16;i=i+2));do
                                PLOT=$PLOT" "$(echo $i)
                        done


			touch commands.out
			echo $PLOT >./commands.out
                        bash ./commands.out
                        rm -f ./commands.out

			cd ..

		done <$workloadsFile
        done
done







