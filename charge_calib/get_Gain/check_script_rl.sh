#!/bin/bash
        for i in `seq  1 100`
		do
            if [ -f "step4_status.txt" ]
            then
                n_line_done=`cat step4_status.txt | grep  "/step4/script3.C done"|wc -l`
                n_line_dir=`cat dir_0_0_0.list |wc -l`
                if [ $n_line_done = $n_line_dir ];then
                    root -l -q  calib_gain.C
                    echo " calib_gain.C done"
                    break
                fi
            fi
            sleep 300
        done

