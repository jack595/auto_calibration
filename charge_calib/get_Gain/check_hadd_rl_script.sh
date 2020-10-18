#!/bin/bash
        for i in `seq  1 100`
		do
            if [ -f "hadd_status.txt" ]
            then
			    tail -n 10 hadd_status.txt | grep -wq "hadd jobs finished"  && cp ../../script3.C . && cp ../../hep_script3.sh .
                chmod 755 hep_script3.sh
                hep_sub ./hep_script3.sh 
                break
            fi
            sleep 300
        done

