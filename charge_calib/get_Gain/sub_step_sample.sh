#!/bin/bash
#这个脚本是为了实现电荷重建与反卷积算法的合并而写的，因为六种刻度源数据，所以必须写一个脚本来批量处理，对应的是张玄同师兄教程的电荷重建的step1和step4中需要批量运行反卷积代码的部分，这个脚本可以把$TUTORIALROOT/share/tut_elec2calib.py批量运行。第一次运行时是以Calib=1运行的，即刻度模式，这一步是为了得到Gain，即运行完这个脚本还需要继续x运行师兄的接下来两步$JUNOTOP/offline/Calibration/PMTCalibAlg/share/run.py，得到MeanGain；得到MeanGain以后修改PMTCalibSvc再运行一次这个脚本，以Calib=0运行，这个再走一次流程，我们就可以得到暗噪声与相对探测效率
#source /cvmfs/juno.ihep.ac.cn/centos7_amd64_gcc830/Pre-Release/J20v1r0-Pre2/setup.sh

original_path=`pwd`
JUNOPath=/afs/ihep.ac.cn/users/v/valprod0/J20v2r0-Pre0
list_name_source=""
i=0

if [ ! -f dir_0_0_0.list ]; then
    ./gen_0_0_0_dir.sh $JUNOPath `pwd`
fi
 while read dir_source
do
    name_source=${dir_source%/*}
    name_source=${name_source##*/}
    name_dir_calib1=${name_source}_calibCALIBNUM
    list_name_source=${list_name_source}"\" , \""${name_source}
    i=$(($i+1))
    echo $i
    echo $list_name_source
#    #echo $name_source,`pwd`
#    #if [ ! -d $name_dir_calib1 ]; then
#    #    mkdir $name_dir_calib1
#    #fi
#    cd $name_dir_calib1
#    if [ $1 = 3 ]; then
#        ./sub.sh
#    elif [ $1 = 4 ]; then 
#        cd step4
#        cp ../../hadd_step4.sh .
#        chmod 755 hadd_step4.sh
#
#        #rm calibCorr-log-*.txt
#        #./sub.sh
#
#        #./sub.sh
#		for i in `seq  1 100`
#		do
#			n_not_success=0
#		    echo -e  $(ls calibCorr-log-*.txt)|tr ' ' '\n'>log.list
#			cat log.list | while read name_log
#			do
#				tail -n 10 ${name_log} | grep -wq "SNiPER::Context Terminated Successfully"  && n_not_success=$(($n_not_success+1)) || n_not_success=$(($n_not_success+1))
#			done
#		    if [ $n_not_success = 0 ]; then
#		    	echo "`pwd` logs show all step4 jobs terminated successfully!"
#                cp ../../script3.C . && cp ../../hep_script3.sh .
#                chmod 755 hep_script3.sh
#                hep_sub ./hep_script3.sh 
#		    	#nohup ./hadd_step4.sh &
#                #cp ${original_path}/check_hadd_rl_script.sh .
#                #chmod 755 check_hadd_rl_script.sh
#                # ./check_hadd_rl_script.sh
#
#		    	break
#		    fi  
#            sleep 600
#		done
#       
#
#
#    else
#        echo "one parameter are supposed to be input,3 or 4. for example, ./sub_step4.sh 3"
#        exit 1
#    fi
#    
#
    cd $original_path    
done < dir_0_0_0.list 

list_name_source=${list_name_source#*,}
list_name_source="{"$list_name_source"\" , \"Averaged\" }"
nn_str="const int nn = $(($i+1));"
file_TString="TString fname[nn] = ${list_name_source};"
legend_TString="TString fname2[nn] = ${list_name_source};"
sed_template=$nn_str"\n"$file_TString"\n"$legend_TString
sed -e "s#SED_TEMPLATE#$sed_template#g" calib_gain_sample.C >calib_gain.C 
chmod 755 check_script_rl.sh
nohup ./check_script_rl.sh &

#for j in `seq 1 $i`;
#do
#    echo $list_name_source|cut -d "/" -f $i
#done

#cat dir_0_0_0.list | while read dir_source
#do
#    name_source=${dir_source%/*}
#    name_source=${name_source##*/}
#    name_dir_calib1=${name_source}_calibCALIBNUM
#    if [ $1 = 4 ]; then 
#        cd ./${name_dir_calib1}/step4/
#        cp ${original_path}/check_hadd_rl_script.sh .
#        chmod 755 check_hadd_rl_script.sh
#        ./check_hadd_rl_script.sh
#        cd -
#    fi
#done
 
#list=(ACU/AmC/AmC_0_0_0000/elecsim ACU/Co60/Co60_0_0_0000/elecsim ACU/Cs137/Cs137_0_0_0000/elecsim ACU/Ge68/Ge68_0_0_0000/elecsim Laser/266nm/photon_110000/elecsim Laser/266nm/photon_2200/elecsim)
#if [ $1 -eq 1 ];then
#   v_source=(AmC Cs137 Ge68 Co60 photon_2200 photon_110000)
#elif [ $1 -eq 0 ];then
#    v_source=(AmC_Calib0 Cs137_Calib0 Ge68_Calib0 Co60_Calib0 photon_2200_Calib0 photon_110000_Calib0)
#else
#        echo "The first parameter should be 0 or 1,relating with the parameter --Calib in file run-sample-step3.sh"
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
#    cp ../run-sample-step3.sh .
#    if [ $1 -eq 1 ]; then
#        echo "Calibration mode is ongoing, parameter Calib=1,using Svc in JUNOTOP"
#        #read -s -n1 -p "按任意键继续 ... "
#    elif [ $1 -eq 0 ];then
#        echo "Calibration mode is off, assuming we have got the parameter--MeanGain, parameter Calib=0,using Svc in WORKTOP"
#        sed -i "s#--Calib 1#--Calib 0#g" ./run-sample-step3.sh
#        sed -i '3i source /afs/ihep.ac.cn/users/l/luoxj/besfs_50G/juno-dev/offline/Calibration/PMTCalib/cmt/setup.sh' ./run-sample-step3.sh
#    else
#        echo "The first parameter should be 0 or 1,relating with the parameter --Calib in file run-sample-step3.sh"
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
