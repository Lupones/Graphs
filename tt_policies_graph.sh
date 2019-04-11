# !/bin/bash
# $1 = name of experiment
# $2 = ymin 
# $3 = ymax
# E.g. 170719

inputdir=/home/lupones/XPL3/outputCSVfiles/$1
simplotdir=/home/lupones/simplot/
workloadsFile=/home/lupones/XPL3/outputCSVfiles/$1/workloads$1.out

cd $inputdir

outputdir=/home/lupones/XPL3/outputCSVfiles/$1/


PLOT=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir"/interval-"$2"-"$3".pdf" --size 8 5 --rect 0 0.25 0.97 1)

PLOT=$PLOT" "$(echo --plot "'"{legend_options: {fontsize: 18, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.44], ncol: 3, columnspacing: 1, fancybox: True, frameon: False}, font: {size: 18}, ymin: $2, ymax: $3, xmin: 0, kind: l, datafile: $inputdir/intervaltable.csv, index: 0, cols: [4,5,6,7,8,9,10,11,12], ylabel: TurnaroundTime, xlabel: workloadID}"'" )

touch commands.out
echo $PLOT
echo $PLOT >./commands.out
bash ./commands.out
rm -f ./commands.out
