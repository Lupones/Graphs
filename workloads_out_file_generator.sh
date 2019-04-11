# !/bin/bash

inputdir=/home/lupones/XPL3/outputCSVfiles/$1/$2.yaml
outputdir=/home/lupones/XPL3/outputCSVfiles/$1/$2.out

touch $outputdir

while read f ; do 
    echo $f
    workload=$(echo $f | rev | cut -c 2- | rev)
    workload=$(echo $workload | cut -c 4- )
    echo $workload

    IFS=',' read -ra ADDR <<< "$workload"
    
    count=1
    for i in "${ADDR[@]}"; do
        if [ $count -lt ${#ADDR[@]} ]
        then
            echo -n $i"-" >> $outputdir
        else
            echo -n $i >> $outputdir
        fi
        (( count++ ))        
    done
    echo "" >> $outputdir
    
done < $inputdir 


