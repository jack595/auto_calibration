#!/bin/bash

#pushd /afs/ihep.ac.cn/users/l/luoxj/reconstrution/wave_reconstruction 
#source /junofs/users/zhangxt/github/calibRec_juno/PMTCalib/cmt/setup.sh

#(time python $TUTORIALROOT/share/tut_elec2calib.py --evtmax -1 --input DIR/elecsim-RUN.root --output calib-RUN.root --user-output user-calib-RUN.root) >& caliblog-RUN.txt
(time python $TUTORIALROOT/share/tut_elec2calib.py --evtmax -1 --Calib 1 --CalibFile SPE_ROOT --Filter FILTER_ROOT  --input DIR/elecsim-RUN.root --output calib-RUN.root --user-output user-calib-RUN.root) >& caliblog-RUN.txt

#popd
