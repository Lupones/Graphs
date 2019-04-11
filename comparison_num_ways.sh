# !/bin/bash

simplotdir=/home/lupones/simplot
inputdir=/home/lupones/XPL3/outputCSVfiles/individual/num-ways-tables/
workloadsFile=/home/lupones/XPL3/outputCSVfiles/individual/$1.out
outputdir=/home/lupones/XPL3/outputCSVfiles/individual

# $1 workloads file name
# $2 ymax

colors=("#4ED358"  "#BE3EB6"  "#1A0F81"  "#888FBE"  "#797AE6"  "#72555B"  "#D190F5" "#1A7B25"  "#7F132D"  "#11BE9B"  "#672049"  "#03BFD5"  "#6E0E93"  "#312554" "#4169e1" "#e4001b" "#fd9c47" "#ae01c7" "#007144" "#7f3358" "#244777" "#ed4255" "#c7ae01" "#011ac7" "#fb7f71" "#9faded" "#9781b5" "#08080a" "#00dead")


cd $inputdir
num=0
c=1
PLOTMPKI=$(echo python3 $simplotdir/simplot.py -g 1 1 -o $outputdir/mpkil3_$1.pdf --size 8 5 --rect 0 0.25 1 1)

while read workload; do
	echo $workload
    fileName=$inputdir$workload"_num-ways-table.csv"
    
    if [[ $c == 1 ]]
    then
        PLOTMPKI=$PLOTMPKI" "$(echo --plot "'"{font: {size: 12}, legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.30], ncol: 4, columnspacing: 1, fancybox: True}, color: ['"'${colors[$num]}'"'], ymajorlocator: ['"'MultipleLocator'"', {base: 1}], xmin: 0, xmax: 20, kind: ml, marker: ["X"], datafile: $fileName, index: 0, cols: [3], ecols: [4], ylabel: MPKIL3, xlabel: Number of ways, labels: [$workload]}"'" )

        c=$((c+1))
    else
        PLOTMPKI=$PLOTMPKI" "$(echo --plot "'"{axnum: 0, font: {size: 12}, legend_options: {fontsize: 16, borderpad: 0.2, labelspacing: 0.1, loc: center, bbox_to_anchor: [0.5, -0.30], ncol: 4, columnspacing: 1, fancybox: True}, color: ['"'${colors[$num]}'"'], ymin: 0, ymax: $2, ymajorlocator: ['"'MultipleLocator'"', {base: 1}], xmin: 0, xmax: 20, kind: ml, marker: ["X"], datafile: $fileName, index: 0, cols: [3], ecols: [4], ylabel: MPKIL3, xlabel: Number of ways, labels: [$workload]}"'" )
    fi

    num=$((num+1))

done <$workloadsFile

touch commands.out
echo $PLOTMPKI
echo $PLOTMPKI >./commands.out
bash ./commands.out
rm -f ./commands.out








