#!/bin/bash

## Script converts xyz from vmd (made with gen_ts_xyz.tcl) , modifies pdb to be readable by tleap, generates tleap topology, then overwrites a new pdb

source activate ambertools

cd ..
# Should be in build directory here

#################### TS1 #####################

arr=( 01 04 05 07 09 15 16 21 23 25 27 29 )

# Setting up the folders
for (( i=0;i<12;++i ))
do

rep_name=rep${arr[i]}

# Change to dimer TS 1  directory
cd $rep_name/dimer/ts1

cp ../../../../opt/$rep_name/neb/ts1.xyz .

# Convert xyz to pdb using obabel
obabel ts1.xyz -opdb -m >/dev/null

# Change HETATM  to ATOM, so readable by pdbmerger
sed -i 's/HETATM/ATOM  /g' ts1.pdb

# Merge pdb to original dna_r.pdb
pdbmerger.sh ts1 ../../../$rep_name/reactant/dna_r_re ts1_re

# Get topology from new readable PDB
topology_tleap.sh ts1_re >/dev/null

# Convert to amber PDB

amb2pdb.sh ts1_re >/dev/null

echo " $rep_name TS1 was optimised and done "

cd - >/dev/null 
done

#################### TS2 #####################

## Setting up the folders
#for (( i=0;i<10;++i ))
#do
#
#rep_name=rep${arr[i]}
#
## Change to dimer TS 2 directory
#cd $rep_name/dimer/ts2
#
#cp ../../../../opt/$rep_name/neb/ts2.xyz .
#
## Convert xyz to pdb using obabel
#obabel ts2.xyz -opdb -m >/dev/null
#
## Change HETATM  to ATOM, so readable by pdbmerger
#sed -i 's/HETATM/ATOM  /g' ts2.pdb
#
## Merge pdb to original dna_r.pdb
#pdbmerger.sh ts2 ../../../$rep_name/reactant/dna_r_re ts2_re
#
## Get topology from new readable PDB
#topology_tleap.sh ts2_re >/dev/null
#
## Convert to amber PDB
#
#amb2pdb.sh ts2_re >/dev/null
#
#echo " $rep_name TS2 was optimised and done "
#
#cd - >/dev/null
#
#done

