#!/bin/bash

## Script converts xyz from chemshell to pdb, modifies pdb to be reable by tleap,  generates tleap topology, then overwrites a new pdb

cd ..
direc=$PWD

if [ -z $1 ];then
echo "Please add the following as an argument: reac prod ts1 ts1_init"
exit
fi

profile=$1
# An array if multiple replicas
arr=( 101 )


len=${#arr[@]}
if [ "$profile" = 'reac' ]; then
for (( i=0;i<$len;++i ))
do
rep_name=rep_${arr[i]}
cd $rep_name/a_reac
FILE=dna_r_opt.xyz
if test -f "$FILE"; then
    obabel $FILE -opdb -m >/dev/null
else
    echo "!!!!!!!!!! $rep_name $FILE !!!!!!!!!!!!!"
fi
cd $direc
done
exit
fi

if [ "$profile" = 'prod' ]; then
for (( i=0;i<$len;++i ))
do
rep_name=rep_${arr[i]}
cd $rep_name/e_product
FILE=dna_p_opt.xyz
if test -f "$FILE"; then
    obabel $FILE -opdb -m >/dev/null
else
    echo "!!!!!!!!!! $rep_name $FILE !!!!!!!!!!!!!"
fi
cd $direc
done
exit
fi

if [ "$profile" = 'ts1_init' ]; then
for (( i=0;i<$len;++i ))
do
rep_name=rep_${arr[i]}
cd $rep_name/neb
FILE=ts1.xyz
if test -f "$FILE"; then
    obabel ts1.xyz -opdb -m >/dev/null
else
    echo "!!!!!!!!!! $rep_name $FILE DOES NOT EXIST !!!!!!!!!!!!!"
fi
cd $direc
done
exit
fi

if [ "$profile" = 'ts1' ]; then
for (( i=0;i<$len;++i ))
do
rep_name=rep_${arr[i]}
cd $rep_name/b_ts1
FILE=ts1_dimer.xyz
if test -f "$FILE"; then
    obabel ts1_dimer.xyz -opdb -m >/dev/null
else
    echo "!!!!!!!!!! $rep_name $FILE DOES NOT EXIST !!!!!!!!!!!!!"
fi
cd $direc
done
exit
fi

