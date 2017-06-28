# !/bin/bash

inputdir=/home/lupones/XPL3/outputCSVfiles/numWaysDataGraphs/npIndivTotal/


DIR=$(echo $inputdir"*")

touch indiv-workloads.out

for f in $DIR
do
          if [[ $f == *interval* ]]
          then
                workload=$(echo $f | cut -d'-' -f 1)
		workload=$(echo $workload | cut -d'/' -f 8)
                echo $workload >>indiv-workloads.out
          fi
done
