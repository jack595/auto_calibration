#!/bin/bash
original_path=`pwd`
root_path=$1
cd $root_path
echo -e  $(ls *.root | sed "s:^:`pwd`/: ")|tr ' ' '\n'>${original_path}/elec.list
cd -

