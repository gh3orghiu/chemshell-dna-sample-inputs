#!/bin/bash

## Run this script to find box-coordinates to put in NAMD input

if [ -z $1 ];then
echo "Please add the name of the pdb file as an argument without the .pdb extension, i.e, 1bna_solv"
exit
fi

./get_min_max.sh $1 > tmpa

python box.py > tmpb 
python box_centre.py > tmpc

cat tmpb tmpc > box_coords.txt

rm tmp*

echo "Saved box_coords.txt"
