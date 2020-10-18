#!/bin/bash

sniper_version="/cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v2r0-Pre0/setup.sh"
source $sniper_version
setup_sniper="source $sniper_version "

path_filter=`head -1 path_filter_and_averagerWaves.sh`
path_spe=`tail -1 path_filter_and_averagerWaves.sh`
    sed -e "s#FILTER_ROOT#$path_filter#g" -e "s#SPE_ROOT#$path_spe#g" run-sample-step3.sh -e "2i $setup_sniper" > ./charge_calib/get_meanGain/run-sample-step3.sh
    sed -e "2i $setup_sniper" run-sample-step4.sh > ./charge_calib/get_meanGain/run-sample-step4.sh
