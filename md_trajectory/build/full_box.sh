#!/bin/bash

## Run this script to find box-coordinates to put in NAMD input

./get_min_max.sh $1 > tmpa

python box.py > tmpb 
python box_centre.py > tmpc

cat tmpb tmpc > box_coords.txt

rm tmp*
