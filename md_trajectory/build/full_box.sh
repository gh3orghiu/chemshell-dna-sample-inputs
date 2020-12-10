#!/bin/bash

./get_min_max.sh $1 > tmpa

python box.py > tmpb 
python box_centre.py > tmpc

cat tmpb tmpc > box_coords.txt

rm tmp*
