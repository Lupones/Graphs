# !/bin/bash

# $1 = Type of individual experiment (Prefetch, AKC, Stalls)


simplotdir=/home/lupones/simplot/

echo $1

if [[ "$1" == "Prefetch" ]]
then
    inputdir=/home/lupones/XPL3/outputCSVfiles/individualPrefetch/num-ways-tables/
    workloadsFile=/home/lupones/XPL3/outputCSVfiles/individualPrefetch/spec-06-17.out
    outputdir=/home/lupones/XPL3/outputCSVfiles/individualPrefetch/num-ways-graphs/
elif [[ "$1" == "AKC" ]]
then
    inputdir=/home/lupones/XPL3/outputCSVfiles/individualAKC/num-ways-tables/
    workloadsFile=/home/lupones/XPL3/outputCSVfiles/individualAKC/spec-06-17.out
    outputdir=/home/lupones/XPL3/outputCSVfiles/individualAKC/num-ways-graphs/
elif [[ "$1" == "Stalls" ]]
then
    inputdir=/home/lupones/XPL3/outputCSVfiles/individualStalls/num-ways-tables/
    workloadsFile=/home/lupones/XPL3/outputCSVfiles/individualStalls/spec-06-17.out
    outputdir=/home/lupones/XPL3/outputCSVfiles/individualStalls/core-mem-graphs/
elif [[ "$1" == "Individual" ]]
then
    inputdir=/home/lupones/XPL3/outputCSVfiles/individual/num-ways-tables/
    workloadsFile=/home/lupones/XPL3/outputCSVfiles/individual/spec-06-17.out
    outputdir=/home/lupones/XPL3/outputCSVfiles/individual/num-ways-graphs/
fi

mkdir $outputdir

cd $inputdir

c=1

while read workload; do
	echo $workload
    fileName=$inputdir$workload"_num-ways-table.csv"
 	
    #PLOTMKPI_IPC=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/numWaysDataGraph-$workload.pdf --size 8 5)
    #PLOTMKPI_IPC=$PLOTMKPI_IPC" "$(echo --plot "'"{font: {size: 22}, legend_options: {}, yright: True, colormap: Paired, numcolors: 9, color: [d$c], ymin: 0, ymax: 12, ymajorlocator: ['"'MultipleLocator'"', {base: 3}], xmin: 0, xmax: 20, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: MPKIL3, xlabel: Number of ways}"'" )
    #PLOTMKPI_IPC=$PLOTMKPI_IPC" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, colormap: Paired, numcolors: 9, color: [d$c], axnum: 0, ymin: 0, ymax: 3, ymajorlocator: ['"'MultipleLocator'"', {base: 1}], xmin: 0, xmax: 20, xmajorlocator: ['"'MultipleLocator'"', {base: 1}], kind: ml, datafile: $filePath/$fileName, index: 0, cols: [1], marker: ["o"], ylabel: IPC, xlabel: Number of ways, labels: [$workload]}"'" )




    if [[ "$1" == "Prefetch" ]]
    then
        PLOTPrefetch=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/$workload"-prefetchGraph.pdf" --size 8 5 --rect 0 0.25 1 1)
        PLOTPrefetch=$PLOTPrefetch" "$(echo --plot "'"{legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], columnspacing: 1, fancybox: True}, font: {size: 22}, xmajorlocator: ['"'MultipleLocator'"', {base: 4}], xmin: 0, xmax: 20, ymax: 100, ymin: 0, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [5], ylabel: Prefetchs/KC, xlabel: Number of ways}"'" )
        
        touch commands.out
        echo $PLOTPrefetch >./commands.out
        bash ./commands.out
        rm -f ./commands.out
    
    
    elif [[ "$1" == "AKC" ]]
    then
        PLOTMKPI_AKC=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/$workload"-mpkil3-akc.pdf" --size 8 5 --rect 0 0.25 1 1)
        PLOTMKPI_AKC=$PLOTMKPI_AKC" "$(echo --plot "'"{font: {size: 22}, legend_options: {}, yright: True, colormap: Paired, numcolors: 9, color: [d$c], ymin: 0, ymax: 12, ymajorlocator: ['"'MultipleLocator'"', {base: 3}], xmin: 0, xmax: 20, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: MPKIL3, xlabel: Number of ways}"'" )
        PLOTMKPI_AKC=$PLOTMKPI_AKC" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, colormap: Paired, numcolors: 9, color: [d$c], axnum: 0, ymin: 0, ymax: 20, ymajorlocator: ['"'MultipleLocator'"', {base: 2}], xmin: 0, xmax: 20, xmajorlocator: ['"'MultipleLocator'"', {base: 2}], kind: ml, datafile: $filePath/$fileName, index: 0, cols: [5], marker: ["o"], ylabel: "AKC (L3)", xlabel: Number of ways, labels: [AKC]}"'" )

        PLOTMKPI_BR=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/$workload"-mpkil3-branch.pdf" --size 8 5 --rect 0 0.25 1 1)
        PLOTMKPI_BR=$PLOTMKPI_BR" "$(echo --plot "'"{font: {size: 22}, legend_options: {}, yright: True, colormap: Paired, numcolors: 9, color: [d$c], ymin: 0, ymax: 12, ymajorlocator: ['"'MultipleLocator'"', {base: 3}], xmin: 0, xmax: 20, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: MPKIL3, xlabel: Number of ways}"'" )
        PLOTMKPI_BR=$PLOTMKPI_BR" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, colormap: Paired, numcolors: 9, color: [d$c], axnum: 0, ymin: 95, ymax: 100, ymajorlocator: ['"'MultipleLocator'"', {base: 0.5}], xmin: 0, xmax: 20, xmajorlocator: ['"'MultipleLocator'"', {base: 2}], kind: ml, datafile: $filePath/$fileName, index: 0, cols: [7], marker: ["o"], ylabel: "correct branch predictions", xlabel: Number of ways, labels: [BRANCH CORRECT PREDICTIONS]}"'" )
    
        touch commands.out
        echo $PLOTMKPI_AKC >./commands.out
        bash ./commands.out
        rm -f ./commands.out

        touch commands.out
        echo $PLOTMKPI_BR >./commands.out
        bash ./commands.out
        rm -f ./commands.out 
    
    elif [[ "$1" == "Stalls" ]]
    then
        PLOTStalls=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/$workload"-stalls.pdf" --size 8 5 --rect 0 0.25 1 1)
        PLOTStalls=$PLOTStalls" "$(echo --plot "'"{color: ['"'#4169e1'"'], font: {size: 20}, legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.01, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, yright: True, ymin: 0, ymax: 3.5, ymajorlocator: ['"'MultipleLocator'"', {base: 0.5}], xmin: 0, xmax: 20, kind: ml, marker: ["s"], datafile: $filePath/$fileName, index: 0, cols: [1], ylabel: IPC, xlabel: Number of ways, labels: ["IPC"]}"'" )
        PLOTStalls=$PLOTStalls" "$(echo --plot "'"{axnum: 0, legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 20}, ymin: 0, ymax: 36, ymajorlocator: ['"'MultipleLocator'"', {base: 3}], xmin: 0, xmax: 20, kind: ml, marker: ["X"], datafile: $filePath/$fileName, index: 0, cols: [5,6], ylabel: Stalls e+10, xlabel: Number of ways}"'" )

        #PLOTspeedup=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/$workload"-ipc-speedup.pdf" --size 8 5 --rect 0 0.25 1 1)
        #PLOTspeedup=$PLOTspeedup" "$(echo --plot "'"{legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, ymax: 2, xmin: 0, xmax: 20, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [17], ylabel: Speedup, xlabel: Number of ways}"'" )
    
        touch commands.out
        echo $PLOTStalls >./commands.out
        bash ./commands.out
        rm -f ./commands.out
        
        #touch commands.out
        #echo $PLOTspeedup >./commands.out
        #bash ./commands.out
        #rm -f ./commands.out 

    elif [[ "$1" == "Individual" ]]
    then
        PLOTMPKILLC=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/h_mpkil3_ipc_$workload.pdf --size 8 5 --rect 0 0.25 1 1)
        PLOTMPKILLC=$PLOTMPKILLC" "$(echo --plot "'"{font: {size: 16}, legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.1, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, yright: True, colormap: Paired, numcolors: 9, color: [d2], ymin: 0, ymax: 24, ymajorlocator: ['"'MultipleLocator'"', {base: 3}], xmin: 0, xmax: 20, kind: ml, marker: ["X"], datafile: $filePath/$fileName, index: 0, cols: [3], ecols: [4], ylabel: M-HPKIL3, xlabel: Number of ways, labels: ["MPKI_L3"]}"'" )
        PLOTMPKILLC=$PLOTMPKILLC" "$(echo --plot "'"{axnum: 0, font: {size: 16}, legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.7, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, yright: True, colormap: Paired, numcolors: 9, color: [d7], ymin: 0, ymax: 24, ymajorlocator: ['"'MultipleLocator'"', {base: 3}], xmin: 0, xmax: 20, kind: ml, marker: ["X"], datafile: $filePath/$fileName, index: 0, cols: [7], ecols: [8], ylabel: M-HPKIL3, xlabel: Number of ways, labels: ["HPKI_L3"]}"'" )
        PLOTMPKILLC=$PLOTMPKILLC" "$(echo --plot "'"{legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.4, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 16}, colormap: Paired, numcolors: 9, color: [d5], axnum: 0, ymin: 0, ymax: 20, ymajorlocator: ['"'MultipleLocator'"', {base: 2}], xmin: 0, xmax: 20, xmajorlocator: ['"'MultipleLocator'"', {base: 1}], kind: ml, datafile: $filePath/$fileName, index: 0, cols: [1], ecols: [2], marker: ["o"], ylabel: "IPC", xlabel: Number of ways, labels: ["IPC"]}"'" )
        #PLOTMPKILLC=$PLOTMPKILLC" "$(echo --plot "'"{legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.4, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 16}, colormap: Paired, numcolors: 9, color: [d5], axnum: 0, ymin: 0, ymax: 20, ymajorlocator: ['"'MultipleLocator'"', {base: 2}], xmin: 0, xmax: 20, xmajorlocator: ['"'MultipleLocator'"', {base: 1}], kind: ml, datafile: $filePath/$fileName, index: 0, cols: [5], ecols: [6], marker: ["o"], ylabel: "LLC Occup. (MB)", xlabel: Number of ways, labels: ["LLC_Occup"]}"'" )
        


        PLOTipcLLC=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/ipc_llc_$workload.pdf --size 8 5 --rect 0 0.25 1 1)
        PLOTipcLLC=$PLOTipcLLC" "$(echo --plot "'"{font: {size: 16}, legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.1, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, yright: True, colormap: Paired, numcolors: 9, color: [d2], ymin: 0, ymax: 3.5, ymajorlocator: ['"'MultipleLocator'"', {base: 0.5}], xmin: 0, xmax: 20, kind: ml, marker: ["X"], datafile: $filePath/$fileName, index: 0, cols: [1], ecols: [2], ylabel: IPC, xlabel: Number of ways, labels: ["IPC"]}"'" )
        PLOTipcLLC=$PLOTipcLLC" "$(echo --plot "'"{legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 16}, colormap: Paired, numcolors: 9, color: [d5], axnum: 0, ymin: 0, ymax: 20, ymajorlocator: ['"'MultipleLocator'"', {base: 2}], xmin: 0, xmax: 20, xmajorlocator: ['"'MultipleLocator'"', {base: 1}], kind: ml, datafile: $filePath/$fileName, index: 0, cols: [5], ecols: [6], marker: ["o"], ylabel: "LLC Occup. (MB)", xlabel: Number of ways, labels: ["LLC_Occup"]}"'" )


        touch commands.out
        echo $PLOTMPKILLC
        echo $PLOTMPKILLC >./commands.out
        bash ./commands.out
        rm -f ./commands.out

    fi


    c=$((c+1))


	#touch commands.out
    #echo $PLOTMPKI_IPC >./commands.out
    #bash ./commands.out
    #rm -f ./commands.out

done <$workloadsFile






