# !/bin/bash
# $1 = name of experiment
# E.g. 170719

inputdir=/home/lupones/XPL3/outputCSVfiles/$1/
simplotdir=/home/lupones/simplot/
workloadsFile=/home/lupones/XPL3/outputCSVfiles/$1/workloads$1.out

cd $inputdir

outputdir=/home/lupones/XPL3/outputCSVfiles/$1/graphs
mkdir $outputdir

while read workload; do
    echo $workload

        PLOTAPKIL3=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir"/APKIL3-instruct-"$workload"-graph.pdf" --size 8 5 --rect 0 0.25 0.97 1)
        PLOTindivMPKIL3=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir"/MPKIL3-interval-"$workload"-graph.pdf" --size 8 5 --rect 0 0.25 0.97 1)
        #PLOTindivMemStalls=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir"/MemStalls-"$i"-"$workload"-graph.pdf" --size 8 5 --rect 0 0.25 0.97 1)
        #PLOTindivLLC=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir"/LLC-"$i"-"$workload"-graph.pdf" --size 8 5 --rect 0 0.25 0.97 1)


        core=0
        c=0
        filePath=$inputdir"/noPart/resultTables/"$workload
        while IFS='-' read -ra APP; do
            for i in "${APP[@]}"; do
                print $i
                fileName="0"$core"_"$i"-intervalDataTable.csv"
                appName="0"$core"_"$i
                echo $fileName
            
                if [[ $core == 0 ]]
                then
                    PLOTAPKIL3=$PLOTAPKIL3" "$(echo --plot "'"{legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.34], ncol: 3, columnspacing: 1, fancybox: True, frameon: False}, font: {size: 16}, ymax: 36, ymin: 0, ymajorlocator: ['"'MultipleLocator'"', {base: 4}], xmin: 0, kind: l, colormap: Paired_r, numcolors: 8, color: [d$c], datafile: $filePath/$fileName, index: 14, cols: [12], ylabel: APKIL3, xlabel: Instruction, ymin: 0, labels: [$i]}"'" )
                    #PLOTindivLLC=$PLOTindivLLC" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.54], ncol: 3, columnspacing: 1, fancybox: True, frameon: False}, font: {size: 22}, xmin: 0, kind: stackedarea, colormap: Paired_r, datafile: $filePath/LLC_occup_apps_data_table.csv, index: 0, ylabel: LLC Occup "("MB")", xlabel: Interval, ymax: 20, ymin: 0}"'" )

                    PLOTindivMPKIL3=$PLOTindivMPKIL3" "$(echo --plot "'"{legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.34], ncol: 3, columnspacing: 1, fancybox: True, frameon: False}, font: {size: 16}, ymax: 18, ymin: 0, ymajorlocator: ['"'MultipleLocator'"', {base: 2}], xmin: 0, kind: l, colormap: Paired_r, numcolors: 8, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [4], ylabel: MPKI-L3, xlabel: Interval, ymin: 0, labels: [$i]}"'" )
                    #PLOTindivMemStalls=$PLOTindivMemStalls" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.54], ncol: 3, columnspacing: 1, fancybox: True, frameon: False}, font: {size: 22}, ymin: 0, xmin: 0, kind: l, colormap: Paired_r, numcolors: 8, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [8], ylabel: Mem-Stalls, xlabel: Interval, labels: [$i]}"'" )
                
                else
                    PLOTAPKIL3=$PLOTAPKIL3" "$(echo --plot "'"{legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.34], ncol: 3, columnspacing: 1, fancybox: True, frameon: False}, axnum: 0, font: {size: 16}, ymax: 36, ymin: 0, ymajorlocator: ['"'MultipleLocator'"', {base: 4}], xmin: 0, kind: l, colormap: Paired_r, numcolors: 8, color: [d$c], datafile: $filePath/$fileName, index: 14, cols: [12], ylabel: APKI_L3, xlabel: Instruction, ymin: 0, labels: [$i]}"'" )

                    PLOTindivMPKIL3=$PLOTindivMPKIL3" "$(echo --plot "'"{legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.34], ncol: 3, columnspacing: 1, fancybox: True, frameon: False}, ymax: 24, ymin: 0, ymajorlocator: ['"'MultipleLocator'"', {base: 2}], xmin: 0, axnum: 0, kind: l, colormap: Paired_r, numcolors: 8, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [4], ylabel: MPKI-L3, xlabel: Interval, labels: [$i]}"'" )
                    #PLOTindivMemStalls=$PLOTindivMemStalls" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.54], ncol: 3, columnspacing: 1, fancybox: True, frameon: False}, ymin: 0, xmin: 0, axnum: 0, kind: l, colormap: Paired_r, numcolors: 8, color: [d$c], datafile: $filePath/$fileName, index: 0, cols: [8], ylabel: Mem-Stalls, xlabel: Interval, labels: [$i]}"'" )
                fi
            
                c=$((c+1))
                core=$((core+1))
            done
            # generate plotindiv graph
            #touch commands.out
            #echo $PLOTindivLLC >./commands.out
            #bash ./commands.out
            #rm -f ./commands.out

            #touch commands.out
            #echo $PLOTindivMemStalls >./commands.out
            #bash ./commands.out
            #rm -f ./commands.out


        done <<< $workload

        touch commands.out
        echo $PLOTAPKIL3 >./commands.out
        bash ./commands.out
        rm -f ./commands.out
        
        #touch commands.out
        #echo $PLOTindivMPKIL3 >./commands.out
        #bash ./commands.out
        #rm -f ./commands.out


done <$workloadsFile
