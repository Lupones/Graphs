# !/bin/bash

inputdir=/home/lupones/XPL3/outputCSVfiles/intervalgraphs/
simplotdir=/home/lupones/simplot/


function join_by { local IFS="$1"; shift; echo "$*"; }

cd $inputdir
#for experiment in Total Interval; do
for experiment in Interval; do
		dir=$experiment
		echo $dir
		outputdir=$inputdir"/"$dir"/graphs/"	
		pwd
                cd $dir
		pwd

		# loop over all the directories of workloads 
		for d in */ ; do
			cd $d
			echo $d
			DATADIR=$(pwd)
			touch commands.out
			apps=$(echo $d | tr -d '/')

			# IPC graph command
			IPC=$(echo python3 $simplotdir/simplot.py -g 2 2 -g 2 2 -o $outputdir/IPC-$apps.pdf --title '"'IPC graph for $apps'"' --title '"'IPC graph for $apps'"' )
			# Hits L3 graph command
			HITSL3=$(echo python3 $simplotdir/simplot.py -g 2 2 -g 2 2 -o $outputdir/HITSL3-$apps.pdf --title '"'HitsL3 graph for $apps'"' --title '"'HitsL3 graph for $apps'"')
			# Hits per occup. L3 graph command
			HITSPEROCCUPL3=$(echo python3 $simplotdir/simplot.py -g 2 2 -g 2 2 -o $outputdir/HITSOCCUPL3-$apps.pdf --title '"'HitsPerOccupL3 graph for $apps'"' --title '"'HitsPerOccupL3 graph for $apps'"')
	

			COUNTER=0	
			#loop each app of the workload
			for i in $(echo $d | tr "-" "\n")
			do
  				app=$(echo $i | tr -d '/')
				for j in *$app*; do
					echo $j
					if [[ $j == *"_hitsL3hg."* ]];then
						#create graph hits L3
						HITSL3=$HITSL3" "$(echo --plot "'"{kind: line, datafile: $DATADIR/$j, index: 0, cols: [1], ylabel: Hits L3, xlabel: interval, labels: [$app"-hg"]}"'")
					fi
					if [[ $j == *"_hitsperOccupL3hg."* ]];then
                                        	#create graph hits per occup. L3
						HITSPEROCCUPL3=$HITSPEROCCUPL3" "$(echo --plot "'"{kind: line, datafile: $DATADIR/$j, index: 0, cols: [1], ylabel: Hits/Occup L3, xlabel: interval, labels: [$app"-hg"]}"'" )

                                	fi
					if [[ $j == *"_IPChg."* ]];then
                                       		#create graph IPC
						IPC=$IPC" "$(echo --plot "'"{kind: line, datafile: $DATADIR/$j, index: 0, cols: [1], ylabel: IPC, xlabel: interval, labels: [$app"-hg"]}"'")
                               		fi

					if [[ $j == *"_hitsL3np."* ]];then
                                                #create graph hits L3
                                                HITSL3=$HITSL3" "$(echo --plot "'"{axnum: $((COUNTER)), kind: line, datafile: $DATADIR/$j, index: 0, cols: [1], ylabel: Hits L3, xlabel: interval, labels: [$app"-np"]}"'")
					fi
                                        if [[ $j == *"_hitsperOccupL3np."* ]];then
                                                #create graph hits per occup. L3
                                                HITSPEROCCUPL3=$HITSPEROCCUPL3" "$(echo --plot "'"{axnum: $((COUNTER)), kind: line, datafile: $DATADIR/$j, index: 0, cols: [1], ylabel: Hits/Occup L3, xlabel: interval, labels: [$app"-np"]}"'" )
                                        fi
                                        if [[ $j == *"_IPCnp."* ]];then
                                                #create graph IPC
                                                IPC=$IPC" "$(echo --plot "'"{axnum: $((COUNTER)), kind: line, datafile: $DATADIR/$j, index: 0, cols: [1], ylabel: IPC, xlabel: interval, labels: [$app"-np"]}"'")
					fi


				
				done
				COUNTER=$((COUNTER+1))		
 			done

			HITSL3=$HITSL3" "$(echo --equal-xaxes)
			HITSPEROCCUPL3=$HITSPEROCCUPL3" "$(echo --equal-xaxes)
			IPC=$IPC" "$(echo --equal-xaxes)
			for((i=0;i<$COUNTER;i++));do
				HITSL3=$HITSL3" "$(echo $i)
				HITSPEROCCUPL3=$HITSPEROCCUPL3" "$(echo $i)
                        	IPC=$IPC" "$(echo $i)
			done


			HITSL3=$HITSL3" "$(echo --equal-yaxes)
                        HITSPEROCCUPL3=$HITSPEROCCUPL3" "$(echo --equal-yaxes)
                        IPC=$IPC" "$(echo --equal-yaxes)
                        for((i=0;i<$COUNTER;i++));do
                                HITSL3=$HITSL3" "$(echo $i)
                                HITSPEROCCUPL3=$HITSPEROCCUPL3" "$(echo $i)
                                IPC=$IPC" "$(echo $i)
                        done

			echo $IPC
			echo $HITSL3
			echo $HITSPEROCCUPL3
			echo $IPC >>./commands.out
			echo $HITSL3 >>./commands.out
			echo $HITSPEROCCUPL3 >>./commands.out
			bash ./commands.out
			rm -f ./commands.out
			cd ..
			if [[ $apps == *"xalancbmk-sphinx3-soplex-sp.C-dealII-gamess-zeusmp-bt.B"* ]]; then
				break;
			fi
		
		done
		cd
done 
exit


# EJEMPLO
# cd /home/lupones/XPL3/experiments/hgTotal/outputCSVInterval/astar-gobmk-h264ref-leslie3d-namd-tonto-zeusmp-bt.C
# python3 /home/lupones/XPL3/simplot.py -g 1 1 -o ./IPC-astar-gobmk-h264ref-leslie3d-namd-tonto-zeusmp-bt.C.pdf --plot {kind: line, datafile: 00_astar_base_IPC.csv, index: 0, cols: [1], ylabel: IPC, xlabel: interval}






