#!/bin/bash

# This script will convert an .xyz file to .pdb using obabel.
# Follow up with the respective save_???_pdb_prmtop_inpcrd.py to create the relevant AMBER files

cd ..
direc=$PWD

if [ -z $1 ];then
echo "Please add the following as an argument: reac prod neb ts1_init ts2_init int_init ts1 ts2 int"
exit
fi

profile=$1

# Uncomment for more replicas
#arr=( 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 )

arr=( 101 )
len=${#arr[@]}

if [ "$profile" = 'reac' ]; then
for (( i=0;i<$len;++i ))
do
rep_name=rep_${arr[i]}
cd $rep_name/a_reac
FILE=reac_opt.xyz
if test -f "$FILE"; then
    obabel reac_opt.xyz -opdb -m >/dev/null 
else 
    echo "!!!!!!!!!! $rep_name $FILE DOES NOT EXIST !!!!!!!!!!!!!" 
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
FILE=prod_opt.xyz
if test -f "$FILE"; then
    obabel prod_opt.xyz -opdb -m >/dev/null 
else 
    echo "!!!!!!!!!! $rep_name $FILE DOES NOT EXIST !!!!!!!!!!!!!" 
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


if [ "$profile" = 'ts2_init' ]; then
for (( i=0;i<$len;++i ))
do
rep_name=rep_${arr[i]}
cd $rep_name/neb
FILE=ts2.xyz
if test -f "$FILE"; then
    obabel ts2.xyz -opdb -m >/dev/null 
else 
    echo "!!!!!!!!!! $rep_name $FILE DOES NOT EXIST !!!!!!!!!!!!!"
fi
cd $direc
done
exit
fi


if [ "$profile" = 'int_init' ]; then
for (( i=0;i<$len;++i ))
do
rep_name=rep_${arr[i]}
cd $rep_name/neb
FILE=int.xyz
if test -f "$FILE"; then
    obabel int.xyz -opdb -m >/dev/null 
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


if [ "$profile" = 'ts2' ]; then
for (( i=0;i<$len;++i ))
do
rep_name=rep_${arr[i]}
cd $rep_name/d_ts2
FILE=ts2_dimer.xyz
if test -f "$FILE"; then
    obabel ts2_dimer.xyz -opdb -m >/dev/null 
else 
    echo "!!!!!!!!!! $rep_name $FILE DOES NOT EXIST !!!!!!!!!!!!!"
fi
cd $direc
done
exit
fi


if [ "$profile" = 'int' ]; then
for (( i=0;i<$len;++i ))
do
rep_name=rep_${arr[i]}
cd $rep_name/c_int
FILE=int_opt.xyz
if test -f "$FILE"; then
    obabel int_opt.xyz -opdb -m >/dev/null 
else 
    echo "!!!!!!!!!! $rep_name $FILE DOES NOT EXIST !!!!!!!!!!!!!"
fi
cd $direc
done
exit
fi
