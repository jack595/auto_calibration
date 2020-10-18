#!/bin/bash
cd timeoffset_calib
. ../charge_calib/get_Gain/gen_elec_list.sh /afs/ihep.ac.cn/users/v/valprod0/J20v2r0-Pre0/Laser/266nm/photon_22000/266nm_0_0_0/elecsim/root/ 
sed -e "s#DIR_ROOT#`pwd`/#g" channel_roofit_sample.C > channel_roofit.C
hep_sub ./TimeOffset.sh 
cd -

