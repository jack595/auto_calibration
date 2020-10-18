#!/bin/bash

source /cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v2r0-Pre0/setup.sh

Ge68_Dir="/afs/ihep.ac.cn/users/v/valprod0/J20v2r0-Pre0/ACU+CLS/Ge68/Ge68_0_0_0/elecsim/root"
raw2d_input=`ls $Ge68_Dir|head -1`
sed -e "s#Ge68_ELECSIM_DIR#$Ge68_Dir#g" main_sample_get_average.sh > ./get_averageWaveform/main_get_average.sh 
sed -e "s#RAW2D_INPUT#${Ge68_Dir}/${raw2d_input}#g" ./get_filter/sample_get_raw2D.C > ./get_filter/get_raw2D.C
cd get_averageWaveform
chmod 755 main_get_average.sh
nohup ./main_get_average.sh &
cd -
cd get_filter
root -l -q get_raw2D.C
root -l -q getFilterSetting3_m.C
cd -

echo `pwd`/get_filter/filter3_m.root > path_filter_and_averagerWaves.sh
echo `pwd`/get_averageWaveform/SPE.root >> path_filter_and_averagerWaves.sh
