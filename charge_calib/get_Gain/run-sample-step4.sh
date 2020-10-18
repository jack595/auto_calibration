#!/bin/bash
source /cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v2r0-Pre0/setup.sh 

(time python $JUNOTOP/offline/Calibration/PMTCalibAlg/share/run.py --evtmax -1 --SPE 1 --input DIR/calib-RUN.root --user-output user_calibCorr_RUN.root) >& calibCorr-log-RUN.txt
