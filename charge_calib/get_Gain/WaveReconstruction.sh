#!/bin/bash
#这个脚本是为了实现电荷重建与反卷积算法的合并而写的，因为六种刻度源数据，所以必须写一个脚本来批量处理，对应的是张玄同师兄教程的电荷重建的step1和step4中需要批量运行反卷积代码的部分，这个脚本可以把$TUTORIALROOT/share/tut_elec2calib.py批量运行。第一次运行时是以Calib=1运行的，即刻度模式，这一步是为了得到Gain，即运行完这个脚本还需要继续x运行师兄的接下来两步$JUNOTOP/offline/Calibration/PMTCalibAlg/share/run.py，得到MeanGain；得到MeanGain以后修改PMTCalibSvc再运行一次这个脚本，以Calib=0运行，这个再走一次流程，我们就可以得到暗噪声与相对探测效率
#source /cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v1r0-Pre2/setup.sh

original_path=`pwd`
JUNOPath=/afs/ihep.ac.cn/users/v/valprod0/J20v2r0-Pre0
if [ -f script3.txt ];then
    rm script3.txt
fi

if [ ! -f dir_0_0_0.list ]; then
    ./gen_0_0_0_dir.sh $JUNOPath `pwd`
fi
cat dir_0_0_0.list | while read dir_source
do
    name_source=${dir_source%/*}
    name_source=${name_source##*/}
    name_dir_calib1=${name_source}_calib$1
    #echo $name_source,`pwd`
    if [ ! -d $name_dir_calib1 ]; then
        mkdir $name_dir_calib1
    fi
    cd $name_dir_calib1

    source ${original_path}/gen_elec_list.sh ${JUNOPath}/${dir_source#*/}/elecsim/root/
    echo ${JUNOPath}/${dir_source#*/}/elecsim/root/
    
    cp ../gen_step3_4.sh .
    cp ../run-sample-step3_4.sh .
    if [ $1 -eq 1 ]; then
        echo "Calibration mode is ongoing, parameter Calib=1,using Svc in JUNOTOP"
        #read -s -n1 -p "按任意键继续 ... "
    elif [ $1 -eq 0 ];then
        echo "Calibration mode is off, assuming we have got the parameter--MeanGain, parameter Calib=0,using Svc in WORKTOP"
        sed -i "s#--Calib 1#--Calib 0#g" ./run-sample-step3_4.sh
        sed -i '3i source /afs/ihep.ac.cn/users/l/luoxj/besfs_50G/juno-dev/offline/Calibration/PMTCalib/cmt/setup.sh' ./run-sample-step3_4.sh
    else
        echo "The first parameter should be 0 or 1,relating with the parameter --Calib in file run-sample-step3_4.sh"
        exit 1
        #read -s -n1 -p "按任意键继续 ... "
    fi
    source gen_step3_4.sh
    #source sub.sh

    cd $original_path
    
done
sed -e "s/CALIBNUM/$1/g" ./sub_step_sample.sh >sub_step.sh
chmod 755 sub_step.sh
./sub_step.sh 4

#list=(ACU/AmC/AmC_0_0_0000/elecsim ACU/Co60/Co60_0_0_0000/elecsim ACU/Cs137/Cs137_0_0_0000/elecsim ACU/Ge68/Ge68_0_0_0000/elecsim Laser/266nm/photon_110000/elecsim Laser/266nm/photon_2200/elecsim)
#if [ $1 -eq 1 ];then
#   v_source=(AmC Cs137 Ge68 Co60 photon_2200 photon_110000)
#elif [ $1 -eq 0 ];then
#    v_source=(AmC_Calib0 Cs137_Calib0 Ge68_Calib0 Co60_Calib0 photon_2200_Calib0 photon_110000_Calib0)
#else
#        echo "The first parameter should be 0 or 1,relating with the parameter --Calib in file run-sample-step3_4.sh"
#        exit 1
#fi
#
#
#pushd /afs/ihep.ac.cn/users/l/luoxj/junofs_500G/charge_calibration/step0
##for Radsource in ${list[@]}
##for((i=0;i<6;i++));
##Execute the loop from i=0 to i=5
#for i in {4..5} 
#do
#    echo $i
#    Radsource=${v_source[$i]}
#    PathSource=${list[$i]}
#    if [ ! -d $Radsource ]; then
#        mkdir $Radsource
#    fi
#    cd $Radsource
#    echo -e  `ls -1 $JUNOPath${list[$i]}/elecsim-*.root`|tr ' ' '\n'>elec.list
#    #    cp ../elec.list .
#    #    sed -i "s#ACU/Ge68/Ge68_0_0_0000/elecsim#$PathSource#g" ./elec.list
#    cp  ../gen.sh .
#    cp ../run-sample-step3_4.sh .
#    if [ $1 -eq 1 ]; then
#        echo "Calibration mode is ongoing, parameter Calib=1,using Svc in JUNOTOP"
#        #read -s -n1 -p "按任意键继续 ... "
#    elif [ $1 -eq 0 ];then
#        echo "Calibration mode is off, assuming we have got the parameter--MeanGain, parameter Calib=0,using Svc in WORKTOP"
#        sed -i "s#--Calib 1#--Calib 0#g" ./run-sample-step3_4.sh
#        sed -i '3i source /afs/ihep.ac.cn/users/l/luoxj/besfs_50G/juno-dev/offline/Calibration/PMTCalib/cmt/setup.sh' ./run-sample-step3_4.sh
#    else
#        echo "The first parameter should be 0 or 1,relating with the parameter --Calib in file run-sample-step3_4.sh"
#        exit 1
#        #read -s -n1 -p "按任意键继续 ... "
#    fi
#    source gen.sh
#    source sub.sh
#
#    cd -
#done
#
#popd
