# !/bin/bash

# $1 = name of experiment
# E.g. 170719

inputdir=/home/lupones/XPL3/outputCSVfiles/$1/
simplotdir=/home/lupones/simplot/
workloadsFile=/home/lupones/XPL3/outputCSVfiles/$1/workloads$1.out

cd $inputdir

outputdir=/home/lupones/XPL3/outputCSVfiles/$1/graphs


while read workload; do
	echo $workload

	# interval graphs comparing IPC, MPKIL3, HitRatioL3 and MemoryStalls of all configs
    PLOT=$(echo python3 $simplotdir/simplot.py -g 1 1 -g 1 1 -g 1 1 -g 1 1 -o $outputdir/IPC-MPKIL3-interval-$workload"-graph.pdf" --size 8 5)

    numconfig=0
	for i in "noPart" ; do 
		filePath=$inputdir"/"$i"/resultTables"
		fileName=$workload"-total-table.csv"

		echo $filePath
		if [[ $i == "noPart" ]];then
			echo "inside if"
			PLOT=$PLOT" "$(echo --plot "'"{kind: l, colormap: magma_r, numcolors: 3, color: [d2], datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC Total, xlabel: Interval, labels: [$i]}"'" )    
			PLOT=$PLOT" "$(echo --plot "'"{kind: l, colormap: magma_r, numcolors: 3, color: [d2], datafile: $filePath/$fileName, index: 0, cols: [5], ylabel: MPKI-L3 Total, xlabel: Interval, labels: [$i]}"'" )
            PLOT=$PLOT" "$(echo --plot "'"{kind: l, colormap: magma_r, numcolors: 3, color: [d2], datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: HitRatio-L3 Total, xlabel: Interval, labels: [$i]}"'" )
            PLOT=$PLOT" "$(echo --plot "'"{kind: l, colormap: magma_r, numcolors: 3, color: [d2], datafile: $filePath/$fileName, index: 0, cols: [7], ylabel: Memory Stalls, xlabel: Interval, labels: [$i]}"'" )

		else
			PLOT=$PLOT" "$(echo --plot "'"{axnum: 0, colormap: magma_r, numcolors: 3, color: [d1], kind: l, datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC Total, xlabel: Interval, labels: [$i]}"'" )          
            PLOT=$PLOT" "$(echo --plot "'"{axnum: 1, colormap: magma_r, numcolors: 3, color: [d1], kind: l, datafile: $filePath/$fileName, index: 0, cols: [5], ylabel: MPKI-L3 Total, xlabel: Interval, labels: [$i]}"'" )
            PLOT=$PLOT" "$(echo --plot "'"{axnum: 2, kind: l, colormap: magma_r, numcolors: 3, color: [d2], datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: HitRatio-L3 Total, xlabel: Interval, labels: [$i]}"'" )
            PLOT=$PLOT" "$(echo --plot "'"{axnum: 3, kind: l, colormap: magma_r, numcolors: 3, color: [d2], datafile: $filePath/$fileName, index: 0, cols: [7], ylabel: Memory Stalls, xlabel: Interval, labels: [$i]}"'" )
		fi

        numconfig=$((numconfig+1))

		# individual graphs for each cache configuration	
		PLOTindiv=$(echo python3 $simplotdir/simplot.py -g 1 1 -g 1 1 -g 1 1 -g 1 1 -o $outputdir"/"$workload"-"$i"-graph.pdf" --size 8 5)

		core=0
		c=0
		filePath=$inputdir"/"$i"/resultTables/"$workload		
		while IFS='-' read -ra APP; do
			for i in "${APP[@]}"; do
				print $i
                
                fileName="0"$core"_"$i"-intervalDataTable.csv"
                appName="0"$core"_"$

                echo $fileName
			
				if [[ $core == 0 ]]
				then
					PLOTindiv=$PLOTindiv" "$(echo --plot "'"{kind: l, colormap: magma_r, numcolors: 9, color: [d$c],  datafile: $filePath/$fileName, index: 0, cols: [2], ylabel: IPC, xlabel: Interval, ymax: 3.5, ymin: 0, labels: [$i]}"'" )
      				#PLOTindiv=$PLOTindiv" "$(echo --plot "'"{kind: stackedarea, colormap: magma_r, datafile: $filePath/LLC_occup_apps_data_table.csv, index: 0, ylabel: LLC Occup "("MB")", xlabel: Interval, ymax: 20, ymin: 0}"'" )
					PLOTindiv=$PLOTindiv" "$(echo --plot "'"{kind: l, colormap: magma_r, numcolors: 9, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [6], ylabel: MPKI-L3, xlabel: Interval, labels: [$i]}"'" )
                    PLOTindiv=$PLOTindiv" "$(echo --plot "'"{kind: l, colormap: magma_r, numcolors: 9, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [4], ylabel: HitRatio-L3, xlabel: Interval, ymin: 0, labels: [$i]}"'" )
                    PLOTindiv=$PLOTindiv" "$(echo --plot "'"{kind: l, colormap: magma_r, numcolors: 9, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [8], ylabel: Memory Stalls, xlabel: Interval, labels: [$i]}"'" )
				else
					PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 0, kind: l, colormap: magma_r, numcolors: 9, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [2], ylabel: IPC, xlabel: Interval, ymax: 3.5, ymin: 0, labels: [$i]}"'" )
        			PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 1, kind: l, colormap: magma_r, numcolors: 9, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [6], ylabel: MPKI-L3, xlabel: Interval, labels: [$i]}"'" )	
                    PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 2, kind: l, colormap: magma_r, numcolors: 9, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [4], ylabel: HitRatio-L3, xlabel: Interval, ymin: 0, labels: [$i]}"'" )
                    PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 3, kind: l, colormap: magma_r, numcolors: 9, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [8], ylabel: Memory Stalls, xlabel: Interval, labels: [$i]}"'" )
				fi
				c=$((c+1))
				core=$((core+1))
			done

        # Plot mean lines 
        filePath=$inputdir"/linux/resultTables"
        fileName=$workload"-mean-table.csv"

        PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 0, kind: ml, marker: ["o"], datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC, xlabel: Interval, ymax: 3.5, ymin: 0, labels: [MEAN]}"'" )
        PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 1, kind: ml, marker: ["o"], datafile: $filePath/$fileName, index: 0, cols: [5], ylabel: MPKI-L3, xlabel: Interval, labels: [MEAN]}"'" )
        PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 2, kind: ml, marker: ["o"], datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: HitRatio-L3, xlabel: Interval, ymin: 0, labels: [MEAN]}"'" )
        PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 3, kind: ml, marker: ["o"], datafile: $filePath/$fileName, index: 0, cols: [7], ylabel: Memory Stalls, xlabel: Interval, labels: [MEAN]}"'" )

        # Plot median lines 
        filePath=$inputdir"/linux/resultTables"
        fileName=$workload"-median-table.csv"

        PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 0, kind: ml, marker: ["v"], datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC, xlabel: Interval, ymax: 3.5, ymin: 0, labels: [MEDIAN]}"'" )
        PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 1, kind: ml, marker: ["v"], datafile: $filePath/$fileName, index: 0, cols: [5], ylabel: MPKI-L3, xlabel: Interval, labels: [MEDIAN]}"'" )
        PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 2, kind: ml, marker: ["v"], datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: HitRatio-L3, xlabel: Interval, ymin: 0, labels: [MEDIAN]}"'" )
        PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 3, kind: ml, marker: ["v"], datafile: $filePath/$fileName, index: 0, cols: [7], ylabel: Memory Stalls, xlabel: Interval, labels: [MEDIAN]}"'" )

	
		# generate plotindiv graph
		touch commands.out
        echo $PLOTindiv >./commands.out
        bash ./commands.out
        rm -f ./commands.out

		done <<< $workload

	# generate plot graph
    #touch commands.out
    #echo $PLOT
    #echo $PLOT >./commands.out
    #bash ./commands.out
    #rm -f ./commands.out
    done

done <$workloadsFile


