# !/bin/bash

# $1 = name of experiment
# E.g. 170719

inputdir=/home/lupones/XPL3/outputCSVfiles/$1/
simplotdir=/home/lupones/simplot/
workloadsFile=/home/lupones/XPL3/outputCSVfiles/$1/workloads$1.out
#workloadsFile=/home/lupones/XPL3/workloads2.out

cd $inputdir

outputdir=$inputdir

echo "WELCOME"

#Plot comparison graphs of policies
PLOTpolicies=$(echo python3 $simplotdir/simplot.py -g 2 1 -g 2 1 -g 2 1 -o $outputdir"/comparison-policies-graph.pdf")
filePath=$inputdir
for i in "criticalAware" "noPart"; do

    fileName=$i"-workloads-totals.csv"

    if [[ $i == "criticalAware" ]];then
        PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [2],  marker: ["X"], labels: [$i], xlabel: workload, ylabel: IPC}"'" )
        PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [3], marker: ["X"], labels: [$i], xlabel: workload, ylabel: MPKIL3}"'" )
        PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [4], marker: ["X"], labels: [$i], xlabel: workload, ylabel: STP}"'" )
        PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [5], marker: ["X"], labels: [$i], xlabel: workload, ylabel: ANTT}"'" )
        PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [6], marker: ["X"], labels: [$i], xlabel: workload, ylabel: Unfairness}"'" )
        PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [7], marker: ["X"], labels: [$i], xlabel: workload, ylabel: Tt}"'")
    else
        PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{axnum: 0, markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [2],  marker: ["X"], labels: [$i], xlabel: workload, ylabel: IPC}"'" )
        PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{axnum: 1, markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [3], marker: ["X"], labels: [$i], xlabel: workload, ylabel: MPKIL3}"'" )
        PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{axnum: 2, markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [4], marker: ["X"], labels: [$i], xlabel: workload, ylabel: STP}"'" )
        PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{axnum: 3, markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [5], marker: ["X"], labels: [$i], xlabel: workload, ylabel: ANTT}"'" )
        PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{axnum: 4, markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [6], marker: ["X"], labels: [$i], xlabel: workload, ylabel: Unfairness}"'" )
        PLOTpolicies=$PLOTpolicies" "$(echo --plot "'"{axnum: 5, markeredgewidth: 0, markersize: 4, kind: ml, datafile: $filePath/$fileName, index: 0, cols: [7], marker: ["X"], labels: [$i], xlabel: workload, ylabel: Tt}"'")
    fi
done


touch commands.out
echo $PLOTpolicies
echo $PLOTpolicies >./commands.out
bash ./commands.out
rm -f ./commands.out


while read workload; do
	echo $workload
	filePath=$inputdir
	fileName=$workload"-totalDataTable.csv"
	
	# bar charts for IPC total, MPKI-L3 total, STP, ANTT, WTt and Unfairness 
	PLOTtotal=$(echo python3 $simplotdir/simplot.py -g 2 1 -g 2 1 -g 2 1 -o $outputdir/Total-stats-$workload"-graph.pdf")
	PLOTtotal=$PLOTtotal" "$(echo --plot "'"{kind: b, datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC}"'" )
	PLOTtotal=$PLOTtotal" "$(echo --plot "'"{kind: b, datafile: $filePath/$fileName, index: 0, cols: [5], ylabel: MPKIL3}"'" )
	PLOTtotal=$PLOTtotal" "$(echo --plot "'"{kind: b, datafile: $filePath/$fileName, index: 0, cols: [7], ylabel: STP}"'" )
	PLOTtotal=$PLOTtotal" "$(echo --plot "'"{kind: b, datafile: $filePath/$fileName, index: 0, cols: [9], ylabel: ANTT}"'" )
    PLOTtotal=$PLOTtotal" "$(echo --plot "'"{kind: b, datafile: $filePath/$fileName, index: 0, cols: [11], ylabel: Unfairness}"'" )
    PLOTtotal=$PLOTtotal" "$(echo --plot "'"{kind: b, datafile: $filePath/$fileName, index: 0, cols: [13], ylabel: Tt}"'" )


	# interval graphs comparing IPC and MPKIL3 of all configs
	PLOT=$(echo python3 $simplotdir/simplot.py -g 2 1 -o $outputdir/IPC-MPKIL3-interval-$workload"-graph.pdf")

    PLOTIPCs=$(echo python3 $simplotdir/simplot.py -g 2 1 -g 2 1 -o $outputdir/IPC-comparison-interval-$workload"-graph.pdf")

    numconfig=0
	for i in "criticalAware" "noPart"; do 
		filePath=$inputdir"/"$i
		fileName=$workload"-total-table.csv"

		echo $filePath
		if [[ $i == "criticalAware" ]];then
		#if [[ $waysCR == 11 ]];then
			echo "inside if"
			PLOT=$PLOT" "$(echo --plot "'"{kind: l, datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC Total, xlabel: Interval, labels: [$i]}"'" )    
			PLOT=$PLOT" "$(echo --plot "'"{kind: l, datafile: $filePath/$fileName, index: 0, cols: [5], ylabel: MPKI-L3 Total, xlabel: Interval, labels: [$i]}"'" )
			echo $PLOT

		else
			PLOT=$PLOT" "$(echo --plot "'"{axnum: 0, kind: l, datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC Total, xlabel: Interval, labels: [$i]}"'" )          
            PLOT=$PLOT" "$(echo --plot "'"{axnum: 1, kind: l, datafile: $filePath/$fileName, index: 0, cols: [5], ylabel: MPKI-L3 Total, xlabel: Interval, labels: [$i]}"'" )
		fi


        #IPC comparison graphs 
        PLOTIPCs=$PLOTIPCs" "$(echo --plot "'"{kind: l, datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC-$waysCR"-"$waysO, xlabel: Interval, labels: ["real_IPC"]}"'" )
        PLOTIPCs=$PLOTIPCs" "$(echo --plot "'"{axnum: $numconfig, kind: l, datafile: $filePath/$fileName, index: 0, ymin: 1, cols: [2], ylabel: IPC-$waysCR"-"$waysO, xlabel: Interval, labels: ["predicted_IPC"]}"'" )

        numconfig=$((numconfig+1))

		# individual graphs for each cache configuration	
		PLOTindiv=$(echo python3 $simplotdir/simplot.py -g 2 2 -o $outputdir"/"$workload"-"$i"-graph.pdf")

		core=0
		column=1
		filePath=$inputdir"/"$i"/"$workload		
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
					PLOTindiv=$PLOTindiv" "$(echo --plot "'"{kind: l, datafile: $filePath/$fileName, index: 0, cols: [7], ylabel: MPKI-L3, xlabel: Interval, ymax: 1400, ymin: 0, labels: [$i]}"'" )
				else
					PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 0, kind: l, datafile: $filePath/$fileName, index: 0, cols: [2], ylabel: IPC, xlabel: Interval, ymax: 3.5, ymin: 0, labels: [$i]}"'" )
	        		#PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 1, kind: stackedarea, datafile: $filePath/LLC_occup_apps_data_table.csv, index: 0, ylabel: LLC Occup "("MB")", xlabel: Interval, ymax: 20, ymin: 0, labels: [$i]}"'" )
        			PLOTindiv=$PLOTindiv" "$(echo --plot "'"{axnum: 2, kind: l, datafile: $filePath/$fileName, index: 0, cols: [7], ylabel: MPKI-L3, xlabel: Interval, ymax: 1400, ymin: 0, labels: [$i]}"'" )	
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

    # generate comparison IPCs graph
    touch commands.out
    echo $PLOTIPCs
    echo $PLOTIPCs >./commands.out
    bash ./commands.out
    rm -f commands.out

	# generate plot graph
	touch commands.out
	echo $PLOTtotal
	echo $PLOTtotal >./commands.out
	bash ./commands.out
	rm -f ./commands.out





done <$workloadsFile


