# !/bin/bash

outputdir=/home/lupones/XPL3/outputCSVfiles/comparisonGraphs/
inputdirSH=/home/lupones/XPL3/outputCSVfiles/numWaysDataGraphs/
inputdirINDIV=/home/lupones/XPL3/outputCSVfiles/indivExecGraphs/
simplotdir=/home/lupones/simplot/
workloadsFile=/home/lupones/XPL3/workloads2.out

function join_by { local IFS="$1"; shift; echo "$*"; }

cd $inputdirSH 
	for experiment in Total; do
		while read workload; do

			echo $workload
			
			filePathHG=$inputdirSH"/hg"$experiment"/"$workload
			filePathNP=$inputdirSH"/np"$experiment"/"$workload

			# have in a single pdf all the graphs of the workload
 			PLOT=$(echo python3 $simplotdir/simplot.py -g 2 2 -g 2 2 -g 2 2 -g 2 2 -g 2 2 -g 2 2 -g 2 2 -g 2 2 -o $outputdir/comparisonGraph-$workload.pdf)
            PLOTaux=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/ipc-ways-$workload.pdf)			
			# loop over all the apps in the workload
			# generate a graph for each one 
			core=0
                        axnum=0
			
			while IFS='-' read -ra APP; do
      				for i in "${APP[@]}"; do
					
					echo $i
					if [[ $i == *.* ]]
					then
						fileName="0"$core"_"$i"-numWaysDataTable-fin.csv"
					else
						fileName="0"$core"_"$i"_base-numWaysDataTable-fin.csv"
					fi

					# hg policy GRAPHS
					PLOT=$PLOT" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePathHG/$fileName, index: 0, cols: [1], linewidth: 0, marker: ["X"], ylabel: IPC, xlabel: Number of ways, labels: [$i"-hg-IPC"]}"'" )
					PLOT=$PLOT" "$(echo --plot "'"{axnum: $axnum, markeredgewidth: 0, markersize: 4, yright: True, color: ['"'#d490c6'"'], kind: ml, linewidth: 0, marker: ["s"], datafile: $filePathHG/$fileName, index: 0, cols: [3], ylabel: hits/storage, xlabel: Number of ways, labels: [$i"-hg-hits/storage"], legend_options: {loc: 2}}"'" )
	
					axnum=$((axnum+1))

					# np policy GRAPHS
                                        PLOT=$PLOT" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePathNP/$fileName, index: 0, cols: [1], linewidth: 0, marker: ["X"], ylabel: IPC, xlabel: Number of ways, labels: [$i"-np-IPC"]}"'" )
                                        PLOT=$PLOT" "$(echo --plot "'"{axnum: $axnum, markeredgewidth: 0, markersize: 4, yright: True, color: ['"'#d490c6'"'], kind: ml, linewidth: 0, marker: ["s"], datafile: $filePathNP/$fileName, index: 0, cols: [3], ylabel: hits/storage, xlabel: Number of ways, labels: [$i"-np-hits/storage"], legend_options: {loc: 2}}"'" )			

					axnum=$((axnum+1))

					# individual execution num ways graph
        				fileName=$i"-numWaysDataTable.csv"

                        PLOTaux=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/ipc-ways-$i.pdf)
                        PLOTaux=$PLOTaux" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $inputdirINDIV/$fileName, index: 0, cols: [1], linewidth: 2, ymax: 3, marker: ["X"], ylabel: IPC, xlabel: Espacio ocupado LLC / MB}"'" )
                        touch com.out
                        echo $PLOTaux
                        echo $PLOTaux >./com.out
                        bash ./com.out
                        rm -f ./com.out


        				PLOT=$PLOT" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $inputdirINDIV/$fileName, index: 0, cols: [1], linewidth: 0, marker: ["X"], ylabel: IPC, xlabel: Number of ways, labels: [$i"-indiv-IPC"]}"'" )
        				PLOT=$PLOT" "$(echo --plot "'"{axnum: $axnum, markeredgewidth: 0, markersize: 4, yright: True, color: ['"'#d490c6'"'], kind: ml, linewidth: 0, marker: ["s"], datafile: $inputdirINDIV/$fileName, index: 0, cols: [3], ylabel: hits/storage, xlabel: Number of ways, labels: [$i"-indiv-hits/storage"], legend_options: {loc: 2}}"'" )

					axnum=$((axnum+1))

					# individual execution interval graph
					for ways in 20; do	
						fileName=$i"-"$ways"ways-intervalDataTable.csv"

	        				PLOT=$PLOT" "$(echo --plot "'"{kind: l, datafile: $inputdirINDIV/$i/$fileName, index: 0, cols: [1], ylabel: IPC, xlabel: Interval, labels: [$i"-"$ways"ways-indiv-IPC"]}"'" )
        					PLOT=$PLOT" "$(echo --plot "'"{axnum: $axnum, yright: True, color: ['"'#d490c6'"'], kind: l, datafile: $inputdirINDIV/$i/$fileName, index: 0, cols: [3], ylabel: hits/storage, xlabel: Interval, labels: [$i"-"$ways"ways-indiv-hits/storage"], legend_options: {loc: 5}}"'" )
					
					done
					axnum=$((axnum+1))
					core=$((core+1))
					
      				done
 			done <<< $workload

			PLOT=$PLOT" "$(echo --equal-xaxes)
			for((i=0;i<6;i++));do
                                PLOT=$PLOT" "$(echo $i)	
			done
			for((i=8;i<14;i++));do
                                PLOT=$PLOT" "$(echo $i) 
                        done
			for((i=16;i<22;i++));do
                                PLOT=$PLOT" "$(echo $i) 
                        done
			for((i=24;i<30;i++));do
                                PLOT=$PLOT" "$(echo $i) 
                        done
			for((i=32;i<38;i++));do
                                PLOT=$PLOT" "$(echo $i) 
                        done
                        for((i=40;i<46;i++));do
                                PLOT=$PLOT" "$(echo $i)
                        done
                        for((i=48;i<54;i++));do
                                PLOT=$PLOT" "$(echo $i)
                        done
                        for((i=56;i<62;i++));do
                                PLOT=$PLOT" "$(echo $i)
                        done

			PLOT=$PLOT" "$(echo --equal-yaxes)
                        for((i=0;i<64;i=i+2));do
                                PLOT=$PLOT" "$(echo $i)
                        done
			PLOT=$PLOT" "$(echo --equal-yaxes)
                        for((i=1;i<64;i=i+2));do
                                PLOT=$PLOT" "$(echo $i)
                        done


			touch commands.out
			echo $PLOT >./commands.out
                        bash ./commands.out
                        rm -f ./commands.out

		done <$workloadsFile
        done







