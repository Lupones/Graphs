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

	# interval graphs comparing IPC and MPKIL3 of all configs
    PLOTipc=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/IPC-comparison-interval-$workload"-graph.pdf" --size 8 5)
    PLOTmpki=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/MPKIL3-comparison-interval-$workload"-graph.pdf" --size 8 5)
    
    # Graphs comparing turnaround time for all mixes
    PLOTttXPL3=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/TT-comparison-XPL3-graph.pdf --size 8 5)
    PLOTttXPL2=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/TT-comparison-XPL2-graph.pdf --size 8 5)

    # Graphs comparing unfairness for all mixes
    PLOTunf=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/unfairness_max.pdf --size 8 5)
    
    numconfig=0
	
    for i in "noPart" "criticalAware"; do 
		filePath=$inputdir"/"$i"/resultTables"
		fileName=$workload"-total-table.csv"

		echo $filePath

        if [[ $i == "noPart" ]];then
			
            PLOTipc=$PLOTipc" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1}, font: {size: 22}, ymax: 18, ymin: 0, ymajorlocator: ['"'MultipleLocator'"', {base: 2}], xmax: 266, xmin: 0, xmajorlocator: ['"'MultipleLocator'"', {base: 38}], kind: l, colormap: Paired_r, numcolors: 3, color: [d1], datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC Total, xlabel: Interval, labels: [$i]}"'" )    
			PLOTmpki=$PLOTmpki" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1}, font: {size: 22}, ymax: 18, ymin: 0, ymajorlocator: ['"'MultipleLocator'"', {base: 2}], xmax: 266, xmin: 0, xmajorlocator: ['"'MultipleLocator'"', {base: 38}], kind: l, colormap: Paired_r, numcolors: 3, color: [d1], datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: MPKI-L3 Total, xlabel: Interval, labels: [$i]}"'" )
            PLOTttXPL3=$PLOTttXPL3" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1}, font: {size: 22}, ymin: 0, ymax: 850, xmax: 34, xmin: 1, xmajorlocator: ['"'MultipleLocator'"', {base: 3}], kind: l, colormap: Paired_r, numcolors: 3, color: [d1], datafile: $inputdir/tt-table-XPL3.csv, index: 0, cols: [2], ylabel: Turnaround time, xlabel: Mixes, labels: [$i]}"'" )
            PLOTttXPL2=$PLOTttXPL2" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1}, font: {size: 22}, ymin: 0, ymax: 850, xmax: 34, xmin: 1, xmajorlocator: ['"'MultipleLocator'"', {base: 3}], kind: l, colormap: Paired_r, numcolors: 3, color: [d1], datafile: $inputdir/tt-table-XPL2.csv, index: 0, cols: [2], ylabel: Turnaround time, xlabel: Mixes, labels: [$i]}"'" )
            PLOTunf=$PLOTunf" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1}, font: {size: 22}, ymin: 0, ymax: 0.45, ymajorlocator: ['"'MultipleLocator'"', {base: 0.1}], xmax: 34, xmin: 1, xmajorlocator: ['"'MultipleLocator'"', {base: 3}], kind: l, colormap: Paired_r, numcolors: 3, color: [d1], datafile: $inputdir/unfairness_wls.csv, index: 0, cols: [3], ylabel: Unfairness, xlabel: Mixes, labels: [$i]}"'" )

		else
			PLOTipc=$PLOTipc" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1}, font: {size: 22}, ymax: 18, ymin: 0, xmax: 266, xmin: 0, xmajorlocator: ['"'MultipleLocator'"', {base: 38}], axnum: 0, colormap: Paired_r, numcolors: 3, color: [d2], kind: l, datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC Total, xlabel: Interval, labels: [$i]}"'" )          
            PLOTmpki=$PLOTmpki" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1}, ymax: 18, ymin: 0, ymajorlocator: ['"'MultipleLocator'"', {base: 2}], xmax: 266, xmin: 0, xmajorlocator: ['"'MultipleLocator'"', {base: 38}], axnum: 0, colormap: Paired_r, numcolors: 3, color: [d2], kind: l, datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: MPKI-L3 Total, xlabel: Interval, labels: [$i]}"'" )
            PLOTttXPL3=$PLOTttXPL3" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1}, ymax: 850, ymin: 0, xmax: 34, xmin: 1, xmajorlocator: ['"'MultipleLocator'"', {base: 3}], axnum: 0, kind: l, colormap: Paired_r, numcolors: 3, color: [d2], datafile: $inputdir/tt-table-XPL3.csv, index: 0, cols: [4], ylabel: Turnaround time, xlabel: Mixes, labels: [$i]}"'" )
            PLOTttXPL2=$PLOTttXPL2" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1}, ymax: 850, ymin: 0, xmax: 34, xmin: 1, xmajorlocator: ['"'MultipleLocator'"', {base: 3}], axnum: 0, kind: l, colormap: Paired_r, numcolors: 3, color: [d2], datafile: $inputdir/tt-table-XPL2.csv, index: 0, cols: [3], ylabel: Turnaround time, xlabel: Mixes, labels: [$i]}"'" )
            PLOTunf=$PLOTunf" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1}, axnum: 0, font: {size: 22}, ymin: 0, ymax: 0.45, ymajorlocator: ['"'MultipleLocator'"', {base: 0.1}], xmax: 34, xmin: 1, xmajorlocator: ['"'MultipleLocator'"', {base: 3}], kind: l, colormap: Paired_r, numcolors: 3, color: [d2], datafile: $inputdir/unfairness_wls.csv, index: 0, cols: [1], ylabel: Unfairness, xlabel: Mixes, labels: [$i]}"'" )
		fi

        numconfig=$((numconfig+1))

		# individual graphs for each application mix for eachcache configuration
		#PLOTindivIPC=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir"/IPC-"$i"-"$workload"-graph.pdf" --size 8 5)
        PLOTindivMPKIL3=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir"/MPKILLC-"$i"-"$workload"-graph.pdf" --size 8 5 --rect 0 0.25 0.97 1)
        PLOTindivLLC=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir"/LLC-"$i"-"$workload"-graph.pdf" --size 8 5 --rect 0 0.25 0.97 1)

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
					 #PLOTindivIPC=$PLOTindivIPC" "$(echo --plot "'"{xmax: 266, xmin: 0, xmajorlocator: ['"'MultipleLocator'"', {base: 38}], kind: l, colormap: Paired_r, numcolors: 8, color: [d$c],  datafile: $filePath/$fileName, index: 0, cols: [2], ylabel: IPC, xlabel: Interval, ymax: 3.5, ymin: 0, labels: [$i]}"'" )
				     PLOTindivMPKIL3=$PLOTindivMPKIL3" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.54], ncol: 3, columnspacing: 1, fancybox: True, frameon: False}, font: {size: 25}, ymax: 10, ymin: 0, ymajorlocator: ['"'MultipleLocator'"', {base: 2}], xmax: 266, xmin: 0, xmajorlocator: ['"'MultipleLocator'"', {base: 38}], kind: l, colormap: Paired_r, numcolors: 8, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [6], ylabel: MPKI-L3, xlabel: Interval, ymin: 0, labels: [$i]}"'" )
                    PLOTindivLLC=$PLOTindivLLC" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.54], ncol: 3, columnspacing: 1, fancybox: True, frameon: False}, font: {size: 25}, xmax: 266, xmin: 0, xmajorlocator: ['"'MultipleLocator'"', {base: 38}], kind: stackedarea, colormap: Paired_r, datafile: $filePath/LLC_occup_apps_data_table.csv, index: 0, ylabel: LLC Occup "("MB")", xlabel: Interval, ymax: 20, ymin: 0}"'" )
                 
                 else
					#PLOTindivIPC=$PLOTindivIPC" "$(echo --plot "'"{xmax: 266, xmin: 0, xmajorlocator: ['"'MultipleLocator'"', {base: 38}], axnum: 0, kind: l, colormap: Paired_r, numcolors: 8, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [2], ylabel: IPC, xlabel: Interval, ymax: 3.5, ymin: 0, labels: [$i]}"'" )
                    PLOTindivMPKIL3=$PLOTindivMPKIL3" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.54], ncol: 3, columnspacing: 1, fancybox: True, frameon: False}, ymax: 10, ymin: 0, ymajorlocator: ['"'MultipleLocator'"', {base: 2}], xmax: 266, xmin: 0, xmajorlocator: ['"'MultipleLocator'"', {base: 38}], axnum: 0, kind: l, colormap: Paired_r, numcolors: 8, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [6], ylabel: MPKI-L3, xlabel: Interval, labels: [$i]}"'" )
				fi
                c=$((c+1))
                core=$((core+1))
                total=$((total-1))
			done
	
		# generate plotindiv graph
		touch commands.out
        echo $PLOTindivMPKIL3 >./commands.out 
        bash ./commands.out
        rm -f ./commands.out

        #touch commands.out
        #echo $PLOTindivIPC >./commands.out
        #bash ./commands.out
        #rm -f ./commands.out

        touch commands.out
        echo $PLOTindivLLC >./commands.out
        bash ./commands.out
        rm -f ./commands.out


		done <<< $workload

    touch commands.out
    echo $PLOTmpki >./commands.out
    bash ./commands.out
    rm -f ./commands.out

    touch commands.out
    echo $PLOTunf >./commands.out
    bash ./commands.out
    rm -f ./commands.out

    # generate plot graph
    touch commands.out
    echo $PLOTttXPL3 >./commands.out
    bash ./commands.out
    rm -f ./commands.out

    touch commands.out
    echo $PLOTttXPL2 >./commands.out
    bash ./commands.out
    rm -f ./commands.out

    # generate plot graph
    touch commands.out
    echo $PLOTipc >./commands.out
    bash ./commands.out
    rm -f ./commands.out
    done

done <$workloadsFile

exit
#generate individual MPKILLC GRAPH
#col=7
#for j in "xalancbmk" "omnetpp"; do
#    fPath="/home/lupones/XPL3/outputCSVfiles/europar/indivTables/resultTables/"$j
#    fName="00_"$j"-intervalDataTable.csv"
    
#    P=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir"/MPKILLC-"$j"-indiv-graph.pdf" --size 8 5)
#    P=$P" "$(echo --plot "'"{font: {size: xx-large}, ymax: 10, ymin: 0, ymajorlocator: ['"'MultipleLocator'"', {base: 2}], xmax: 266, xmin: 0, xmajorlocator: ['"'MultipleLocator'"', {base: 38}], kind: l, colormap: Paired_r, numcolors: 9, color: [d$col], datafile: $fPath/$fName, index: 0, cols: [6], ylabel: MPKI-L3, xlabel: Interval, labels: [$j]}"'" )

#    col=$((col+1))
    # generate plotindiv graph
#    touch commands.out
#    echo $P
#    echo $P >./commands.out
#    bash ./commands.out
#    rm -f ./commands.out


#done

# plot % gain in turnaround time 
Ptt=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir"/bars-TT-XPL3.pdf" --size 8 5 --rect 0 0 1 1)
Ptt=$Ptt" "$(echo --plot "'"{legend_options: {}, font: {size: 22}, ymax: 15, ymin: 0, ymajorlocator: ['"'MultipleLocator'"', {base: 3}], kind: b, colormap: Paired_r, numcolors: 3, color: [d2], datafile: $inputdir/tt-summary.csv, index: 0, cols: [1], ylabel: Percentage gain tt, xlabel: Num. critical apps / mix}"'" )

# generate plotindiv graph
touch commands.out
echo $Ptt 
bash ./commands.out
rm -f ./commands.out

Ptt2=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir"/bars-TT-XPL2.pdf" --size 8 5 --rect 0 0 1 1)
Ptt2=$Ptt2" "$(echo --plot "'"{legend_options: {}, font: {size: 22}, ymax: 15, ymin: 0, ymajorlocator: ['"'MultipleLocator'"', {base: 3}], kind: b, colormap: Paired_r, numcolors: 3, color: [d2], datafile: $inputdir/tt-summary.csv, index: 0, cols: [2], ylabel: Percentage gain tt, xlabel: Num. critical apps / mix}"'" )

touch commands.out
echo $Ptt2 
bash ./commands.out
rm -f ./commands.out






