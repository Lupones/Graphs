# !/bin/bash

# $1 = name of experiment
# E.g. 170719

inputdir=/home/lupones/XPL3/outputCSVfiles/$1/
#inputdir=$2
simplotdir=/home/lupones/simplot/
workloadsFile=/home/lupones/XPL3/outputCSVfiles/$1/workloads$1.out

cd $inputdir

outputdir=$inputdir

while read workload; do

	echo $workload

	filePath=$inputdir
	fileName=$workload"-totalDataTable.csv"
	fileNameSU=$workload"-STP-Unfairness-Table.csv"
	
	# graphs for IPC total, MPKI-L3 total, STP and Unfairness 
	PLOTtotal=$(echo python3 $simplotdir/simplot.py -g 2 1 -g 2 1 -o $outputdir/Total-stats-$workload"-graph.pdf")
	PLOTtotal=$PLOTtotal" "$(echo --plot "'"{kind: b, datafile: $filePath/$fileName, index: 0, cols: [1],  ylabel: IPC Total, xlabel: configuration}"'" )
	PLOTtotal=$PLOTtotal" "$(echo --plot "'"{kind: b, datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: MPKIL3 Total, xlabel: configuration}"'" )
	PLOTtotal=$PLOTtotal" "$(echo --plot "'"{kind: b, datafile: $filePath/$fileNameSU, index: 0, cols: [1], ylabel: STP, xlabel: configuration}"'" )
	PLOTtotal=$PLOTtotal" "$(echo --plot "'"{kind: b, datafile: $filePath/$fileNameSU, index: 0, cols: [3], ylabel: Unfairness, xlabel: configuration}"'" )


	# interval graphs comparing IPC and MPKIL3 of all configs
	PLOT=$(echo python3 $simplotdir/simplot.py -g 2 1 -o $outputdir/IPC-MPKIL3-interval-$workload"-graph.pdf")

	#for i in 9,11 10,10 12,8 12,10 20,20; do
	#for i in 20,20 15,5 14,6 13,7 12,8 10,10 9,11; do
	for i in 20,20 12,10 12,8 10,10 9,11; do 
    		IFS=',' read waysCR waysO <<< "${i}"
    		echo "${waysCR}" and "${waysO}"


		filePath=$inputdir"/"$waysCR"cr"$waysO"others"
		fileName=$workload"-total-table.csv"


		echo $filePath
		if [[ $waysCR == 20 ]];then
		#if [[ $waysCR == 11 ]];then
			echo "inside if"
			PLOT=$PLOT" "$(echo --plot "'"{kind: l, datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC Total, xlabel: Interval, labels: [$waysCR"-"$waysO]}"'" )    
			PLOT=$PLOT" "$(echo --plot "'"{kind: l, datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: MPKI-L3 Total, xlabel: Interval, labels: [$waysCR"-"$waysO]}"'" )
			echo $PLOT

		else
			PLOT=$PLOT" "$(echo --plot "'"{axnum: 0, kind: l, datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC Total, xlabel: Interval, labels: [$waysCR"-"$waysO]}"'" )          
                	PLOT=$PLOT" "$(echo --plot "'"{axnum: 1, kind: l, datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: MPKI-L3 Total, xlabel: Interval, labels: [$waysCR"-"$waysO]}"'" )

		fi

		# individual graphs for each cache configuration	
		PLOTindiv=$(echo python3 $simplotdir/simplot.py -g 2 2 -o $outputdir"/"$workload"-"$waysCR"cr"$waysO"others-graph.pdf")

		core=0
		column=1
		filePath=$inputdir"/"$waysCR"cr"$waysO"others/"$workload		
		while IFS='-' read -ra APP; do
			for i in "${APP[@]}"; do
				print $i
				if [[ $i == *.* ]]
                        	then
					fileName="0"$core"_"$i"-intervalDataTable.csv"
					appName="0"$core"_"$i
                        	else
                                	fileName="0"$core"_"$i"_base-intervalDataTable.csv"
					appName="0"$core"_"$i"_base"
                        	fi
                        	echo $fileName
			
				if [[ $core == 0 ]]
				then
					PLOTindiv=$PLOTindiv" "$(echo --plot "'"{kind: l, datafile: $filePath/$fileName, index: 0, cols: [2], ylabel: IPC, xlabel: Interval, ymax: 3.5, ymin: 0, labels: [$i]}"'" )
      					PLOTindiv=$PLOTindiv" "$(echo --plot "'"{kind: stackedarea, datafile: $filePath/LLC_occup_apps_data_table.csv, index: 0, ylabel: LLC Occup "("MB")", xlabel: Interval, ymax: 20, ymin: 0}"'" )
					PLOTindiv=$PLOTindiv" "$(echo --plot "'"{kind: l, datafile: $filePath/$fileName, index: 0, cols: [6], ylabel: MPKI-L3, xlabel: Interval, ymax: 1400, ymin: 0, labels: [$i]}"'" )
				else
					PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 0, kind: l, datafile: $filePath/$fileName, index: 0, cols: [2], ylabel: IPC, xlabel: Interval, ymax: 3.5, ymin: 0, labels: [$i]}"'" )
	        			#PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 1, kind: stackedarea, datafile: $filePath/LLC_occup_apps_data_table.csv, index: 0, ylabel: LLC Occup "("MB")", xlabel: Interval, ymax: 20, ymin: 0, labels: [$i]}"'" )
        				PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 2, kind: l, datafile: $filePath/$fileName, index: 0, cols: [6], ylabel: MPKI-L3, xlabel: Interval, ymax: 1400, ymin: 0, labels: [$i]}"'" )	
				fi
				column=$((column+1))
				core=$((core+1))
			done
	
		# generate plotindiv graph
		touch commands.out
		echo $PLOTindiv
        	echo $PLOTindiv >./commands.out
        	bash ./commands.out
        	rm -f ./commands.out

		done <<< $workload

	# generate plot graph
        touch commands.out
        echo $PLOT
        echo $PLOT >./commands.out
        bash ./commands.out
        rm -f ./commands.out
        done

	# generate plot graph
	touch commands.out
	echo $PLOTtotal
	echo $PLOTtotal >./commands.out
	bash ./commands.out
	rm -f ./commands.out


done <$workloadsFile


