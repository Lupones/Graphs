# !/bin/bash

inputdir=/home/lupones/XPL3/outputCSVfiles/individualStalls/num-ways-tables/
simplotdir=/home/lupones/simplot/
workloadsFile=/home/lupones/XPL3/outputCSVfiles/individualStalls/spec-06-17.out
outputdir=/home/lupones/XPL3/outputCSVfiles/individualStalls/stalls-comparison-graphs/

mkdir $outputdir

function join_by { local IFS="$1"; shift; echo "$*"; }

cd $inputdir

# varied colors
colors=("#4169e1" "#e4001b" "#fd9c47" "#ae01c7" "#007144" "#7f3358" "#244777" "#ed4255" "#c7ae01" "#011ac7" "#fb7f71" "#9faded" "#9781b5" "#08080a" "#00dead")

#colors=("#fa523f" "#e4001b" "#7f0019" "#ff0000" "#ed4255" "#d41137" "#5cb82e" "#007144" "#00de3e" "#73ec4e" "#197f00" "#1e3d0f")

num=0

outputdir=/home/lupones/XPL3/outputCSVfiles/individualStalls/
PLOTstalls=$(echo python3 $simplotdir/simplot.py -g 1 1 -g 1 1 -g 1 1 -g 1 1 -g 1 1 -o $outputdir/$workload"-stalls-comparison.pdf" --size 8 5 --rect 0 0.25 1 1)

min=5
max=8
PLOTaux=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/$workload"-$min-$max.pdf" --size 8 5 --rect 0 0.25 1 1)

while read workload; do
	echo $workload
    fileName=$inputdir$workload"_num-ways-table.csv"
   
    if [[ $num == 0 ]];then

        PLOTaux=$PLOTaux" "$(echo --plot "'"{color: ['"'${colors[$num]}'"'], legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, xmin: $min, xmax: $max, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [5], ylabel: LDMstalls, xlabel: Number of ways, labels: [$workload]}"'" )

        PLOTstalls=$PLOTstalls" "$(echo --plot "'"{color: ['"'${colors[$num]}'"'], legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, xmin: 0, xmax: 20, ymin: 0, ymax: 100, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [10], ylabel: CPUstallsWRTtot, xlabel: Number of ways, labels: [$workload]}"'" )

        PLOTstalls=$PLOTstalls" "$(echo --plot "'"{color: ['"'${colors[$num]}'"'], legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, xmin: 0, xmax: 20, ymin: 0, ymax: 100, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [11], ylabel: MemstallsWRTtot, xlabel: Number of ways, labels: [$workload]}"'" )

        PLOTstalls=$PLOTstalls" "$(echo --plot "'"{color: ['"'${colors[$num]}'"'], legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, xmin: 0, xmax: 20, ymin: 0, ymax: 7.5, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [7], ylabel: CPU Stalls, xlabel: Number of ways, labels: [$workload]}"'" )

        PLOTstalls=$PLOTstalls" "$(echo --plot "'"{color: ['"'${colors[$num]}'"'], legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, xmin: 0, xmax: 20, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [15], ylabel: Cycles, xlabel: Number of ways, labels: [$workload]}"'" )

        PLOTstalls=$PLOTstalls" "$(echo --plot "'"{color: ['"'${colors[$num]}'"'], legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, ymin: 0, ymax: 2, ymajorlocator: ['"'MultipleLocator'"', {base: 1}], xmin: 0, xmax: 20, xmajorlocator: ['"'MultipleLocator'"', {base: 2}], kind: ml, datafile: $filePath/$fileName, index: 0, cols: [1], marker: ["o"], ylabel: IPC, xlabel: Number of ways, labels: [$workload]}"'" )

    else

        PLOTaux=$PLOTaux" "$(echo --plot "'"{axnum: 0, color: ['"'${colors[$num]}'"'], legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, xmin: $min, xmax: $max, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [5], ylabel: LDMstalls, xlabel: Number of ways, labels: [$workload]}"'" )

        PLOTstalls=$PLOTstalls" "$(echo --plot "'"{color: ['"'${colors[$num]}'"'], axnum: 0, legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, xmin: 0, xmax: 20, ymin: 0, ymax: 100, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [10], ylabel: CPUstallsWRTtot, xlabel: Number of ways, labels: [$workload]}"'" )

        PLOTstalls=$PLOTstalls" "$(echo --plot "'"{color: ['"'${colors[$num]}'"'], axnum: 1, legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, xmin: 0, xmax: 20, ymin: 0, ymax: 100, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [11], ylabel: MemstallsWRTtot, xlabel: Number of ways, labels: [$workload]}"'" )

        PLOTstalls=$PLOTstalls" "$(echo --plot "'"{color: ['"'${colors[$num]}'"'], axnum: 3, legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, xmin: 0, xmax: 20, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [15], ylabel: Cycles, xlabel: Number of ways, labels: [$workload]}"'" )

        PLOTstalls=$PLOTstalls" "$(echo --plot "'"{color: ['"'${colors[$num]}'"'], axnum: 2, legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, xmin: 0, xmax: 20, ymin: 0, ymax: 7.5, kind: dl, linestyle: "-", datafile: $filePath/$fileName, index: 0, cols: [7], ylabel: CPU Stalls, xlabel: Number of ways, labels: [$workload]}"'" )

        PLOTstalls=$PLOTstalls" "$(echo --plot "'"{color: ['"'${colors[$num]}'"'], axnum: 4, legend_options: {fontsize: 15, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.47], ncol: 3, columnspacing: 1, fancybox: True}, font: {size: 22}, ymin: 0, ymax: 2, ymajorlocator: ['"'MultipleLocator'"', {base: 1}], xmin: 0, xmax: 20, xmajorlocator: ['"'MultipleLocator'"', {base: 2}], kind: ml, datafile: $filePath/$fileName, index: 0, cols: [1], marker: ["o"], ylabel: IPC, xlabel: Number of ways, labels: [$workload]}"'" )



    fi  

    num=$((num+1))


done <$workloadsFile


touch commands.out
echo $PLOTstalls >./commands.out
bash ./commands.out
rm -f ./commands.out

touch commands.out
echo $PLOTaux >./commands.out
bash ./commands.out
rm -f ./commands.out



