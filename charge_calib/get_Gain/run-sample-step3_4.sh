#!/bin/bash
source /cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v2r0-Pre0/setup.sh 

#pushd /afs/ihep.ac.cn/users/l/luoxj/reconstrution/wave_reconstruction 
#source /junofs/users/zhangxt/github/calibRec_juno/PMTCalib/cmt/setup.sh

#(time python $TUTORIALROOT/share/tut_elec2calib.py --evtmax -1 --input DIR/elecsim-RUN.root --output calib-RUN.root --user-output user-calib-RUN.root) >& caliblog-RUN.txt
(time python $TUTORIALROOT/share/tut_elec2calib.py --evtmax -1 --Calib 1 --CalibFile /afs/ihep.ac.cn/users/l/luoxj/Deconvolution_Sim/J20v2r0-Pre0/get_averageWaveform/SPE.root --Filter /afs/ihep.ac.cn/users/l/luoxj/Deconvolution_Sim/J20v2r0-Pre0/get_filter/filter3_m.root  --input STEP3_DIR/elecsim-RUN.root --output calib-RUN.root --user-output user-calib-RUN.root) >& caliblog-RUN.txt && (time python $JUNOTOP/offline/Calibration/PMTCalibAlg/share/run.py --evtmax -1 --SPE 1 --input STEP4_DIR/calib-RUN.root --user-output ./step4/user_calibCorr_RUN.root) >& ./step4/calibCorr-log-RUN.txt
