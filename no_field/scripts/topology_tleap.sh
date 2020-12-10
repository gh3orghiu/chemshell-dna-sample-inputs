#!/bin/bash
# This script needs 1 argument:
#   1. DNA pdb input file

echo "#############################################################################"
echo "The script help to build a leap.in file and run the tleap for the complex."
echo "First Parameter is the DNA file name"
echo "This script will generate topology files"
# echo -n "Enter anything to continue....."
# read
echo "#############################################################################"

if [ -z ${AMBERHOME} ]; then
echo "ERROR:The AMBERHOME var is not set! Check it!"
echo "ERROR:Be sure the tleap could be run!"
exit

# If no define AMBERHOME, source the ambertools
source activate ambertools
fi

profile=$1
if [ -z $1 ];then
profile="protein.pdb"
echo "Set protein file name to default: protein.pdb"
fi

echo "source leaprc.DNA.bsc1
source leaprc.water.tip3p
dna1= loadpdb "$1.pdb"
saveamberparm dna1 $1.prmtop $1.inpcrd
quit" > leap.in

include prmtop if needed
saveamberparm dna1 $1.prmtop $1.inpcrd


tleap -s -f leap.in

echo "###############################################################################"
echo "Note: Finish!"
