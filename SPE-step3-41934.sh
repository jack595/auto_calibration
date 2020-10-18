#!/bin/bash
#source /cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v1r0-Pre2/setup.sh
#source /cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v2r0-Pre0/setup.sh

#pushd /afs/ihep.ac.cn/users/l/luoxj/reconstrution/wave_reconstruction 
#source /junofs/users/zhangxt/github/calibRec_juno/PMTCalib/cmt/setup.sh


#(time python $TUTORIALROOT/share/tut_elec2calib.py --evtmax -1 --input /junofs/users/huangx/production/J20v1r0-Pre0/ACU/AmC/AmC_0_0_0000/elecsim//elecsim-41934.root --output calib-41934.root --user-output user-calib-41934.root) >& caliblog-41934.txt
#(time python $TUTORIALROOT/share/tut_elec2calib.py --evtmax 10 --Calib 1 --CalibFile /afs/ihep.ac.cn/users/l/luoxj/junofs_500G/Deconvolution_Sim/J20v2r0-Pre0/get_averageWaveform/SPE.root  --input /afs/ihep.ac.cn/users/v/valprod0/J20v2r0-Pre0/ACU+CLS/Ge68/Ge68_0_0_0/elecsim/root/elecsim-70001.root --output calib-41934.root --user-output user-calib-41934.root)
cd /afs/ihep.ac.cn/users/l/luoxj/junofs_500G/J20v2Pre0/offline/Reconstruction/Deconvolution/cmt
cmt make
cd -
(time python $TUTORIALROOT/share/tut_elec2calib.py --evtmax 10 --Calib 1 --CalibFile /afs/ihep.ac.cn/users/l/luoxj/junofs_500G/Deconvolution_Sim/J20v2r0-Pre0/get_averageWaveform/SPE.root  --input /afs/ihep.ac.cn/users/v/valprod0/J20v2r0-Pre0/ACU+CLS/Ge68/Ge68_0_0_0/elecsim/root/elecsim-70001.root --output calib-41934.root --user-output user-calib-41934.root) >& caliblog-41934.txt

#popd
