# !/bin/bash

# $1 = Type of individual experiment (Prefetch, AKC, Stalls)


simplotdir=/home/lupones/simplot/

if [ $1 -eq "Prefetch"]
then
    inputdir=/home/lupones/XPL3/outputCSVfiles/individualPrefetch/num-ways-tables/
    workloadsFile=/home/lupones/XPL3/outputCSVfiles/individualPrefetch/problematic.out
    outputdir=/home/lupones/XPL3/outputCSVfiles/individualPrefetch/num-ways-graphs/
elif [ $1 -eq "AKC" ]
then
    inputdir=/home/lupones/XPL3/outputCSVfiles/individualAKC/num-ways-tables/
    workloadsFile=/home/lupones/XPL3/outputCSVfiles/individualAKC/spec-06-17.out
    outputdir=/home/lupones/XPL3/outputCSVfiles/individualAKC/num-ways-graphs/
elif [ $1 -eq "Stalls" ]
then
    inputdir=/home/lupones/XPL3/outputCSVfiles/individualStalls/num-ways-tables/
    workloadsFile=/home/lupones/XPL3/outputCSVfiles/individualStalls/spec-06-17.out
    outputdir=/home/lupones/XPL3/outputCSVfiles/individualStalls/num-ways-graphs/
else
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
 	
    PLOTMKPI_IPC=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/numWaysDataGraph-$workload.pdf --size 8 5)
    PLOTMKPI_IPC=$PLOTMKPI_IPC" "$(echo --plot "'"{font: {size: 22}, legend_options: {}, yright: True, colormap: Paired, numcolors: 9, color: [d$c], ymin: 0, ymax: 12, ymajorlocator: ['"'MultipleLocator'"', {base: 3}], xmin: 0, xmax: 20, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [3], ylabel: MPKIL3, xlabel: Number of ways}"'" )
    PLOTMKPI_IPC=$PLOTMKPI_IPC" "$(echo --plot "'"{legend_options: {fontsize: 22, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, colormap: Paired, numcolors: 9, color: [d$c], axnum: 0, ymin: 0, ymax: 3, ymajorlocator: ['"'MultipleLocator'"', {base: 1}], xmin: 0, xmax: 20, xmajorlocator: ['"'MultipleLocator'"', {base: 1}], kind: ml, datafile: $filePath/$fileName, index: 0, cols: [1], marker: ["o"], ylabel: IPC, xlabel: Number of ways, labels: [$workload]}"'" )




    if [ $1 -eq "Prefetch"]
    then
        PLOTPrefetch=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/$workload"-prefetchGraph.pdf" --size 8 5 --rect 0 0.25 1 1)
        PLOTPrefetch=$PLOTindiv" "$(echo --plot "'"{legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], columnspacing: 1, fancybox: True}, font: {size: 22}, xmajorlocator: ['"'MultipleLocator'"', {base: 4}], xmin: 0, xmax: 20, ymax: 100, ymin: 0, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [5], ylabel: Prefetchs/KC, xlabel: Number of ways}"'" )
        
        touch commands.out
        echo $PLOTPrefetch >./commands.out
        bash ./commands.out
        rm -f ./commands.out
    
    
    elif [ $1 -eq "AKC" ]
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
    
    elif [ $1 -eq "Stalls" ]
    then
        PLOTStalls=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/$workload"-stalls.pdf" --size 8 5 --rect 0 0.25 1 1)
        PLOTStalls=$PLOTStalls" "$(echo --plot "'"{legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, ymin: 0, ymax: 24, ymajorlocator: ['"'MultipleLocator'"', {base: 3}], xmin: 0, xmax: 20, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [3,5,7], ylabel: Stalls e+10, xlabel: Number of ways}"'" )

        PLOTspeedup=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/$workload"-ipc-speedup.pdf" --size 8 5 --rect 0 0.25 1 1)
        PLOTspeedup=$PLOTspeedup" "$(echo --plot "'"{legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, ymax: 2, xmin: 0, xmax: 20, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [17], ylabel: Speedup, xlabel: Number of ways}"'" )
    
        touch commands.out
        echo $PLOTStalls >./commands.out
        bash ./commands.out
        rm -f ./commands.out
        
        touch commands.out
        echo $PLOTspeedup >./commands.out
        bash ./commands.out
        rm -f ./commands.out 
    
    fi


    c=$((c+1))


	touch commands.out
    echo $PLOTMPKI_IPC >./commands.out
    bash ./commands.out
    rm -f ./commands.out

done <$workloadsFile






