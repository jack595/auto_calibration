#!/bin/bash

(time python $JUNOTOP/offline/Calibration/PMTCalibAlg/share/run.py --evtmax -1 --SPE 1 --input DIR/calib-RUN.root --user-output user_calibCorr_RUN.root) >& calibCorr-log-RUN.txt
