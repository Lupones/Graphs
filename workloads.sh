# !/bin/bash

inputdir=/home/lupones/XPL3/outputCSVfiles/workloadsGraphs/


DIR=$(echo $inputdir"*")

touch workloads.out

for f in $DIR
do
          if [[ $f == *Total* ]]
          then
                workload=$(echo $f | cut -d'_' -f 2)
                echo $workload >>workloads.out
          fi
done
