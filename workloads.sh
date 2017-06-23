# !/bin/bash

inputdir=/home/lupones/XPL3/outputCSVfiles/workloadsGraphs/


DIR=$(echo $inputdir"*")

touch workloads.out

for f in $DIR
do
          workload=$(echo $f | cut -d'_' -f 2)
	  echo $workload
          echo $workload >>workloads.out
done
