#!/bin/bash
##Usage, recquire prmtop and incprd in directory - Type in filename as variable

ambpdb -p $1.prmtop < $1.inpcrd > $1.pdb

echo "File $1.pdb written"
