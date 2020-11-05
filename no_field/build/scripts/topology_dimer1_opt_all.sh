#!/bin/bash

## Script converts pdb from vmd, modifies pdb to be readable by tleap, generates tleap topology, then overwrites a new pdb

source activate ambertools

cd ..
# Should be in build directory here

# Dimer array 
arr=( 03 06 08 10 12 14 17 19 24 33 )
#arr=( 03 ) #06 08 10 12 14 17 19 24 33 )

# Setting up the folders
for (( i=0;i<10;++i ))
do

rep_name=rep${arr[i]}

# Change to dimer TS 1  directory
cd $rep_name/dimer/ts1

cp ../../../../opt/$rep_name/dimer/ts1/ts1_dimer.xyz .

# Convert xyz to pdb using obabel
obabel ts1_dimer.xyz -opdb -m >/dev/null

# Change HETATM  to ATOM, so readable by pdbmerger
sed -i 's/HETATM/ATOM  /g' ts1_dimer.pdb

# Merge pdb to original dna_r.pdb
pdbmerger.sh ts1_dimer ../../../$rep_name/reactant/dna_r_re ts1_dimer_re

# Get topology from new readable PDB
topology_tleap.sh ts1_dimer_re >/dev/null

# Convert to amber PDB

amb2pdb.sh ts1_dimer_re >/dev/null

echo " $rep_name TS1 was optimised and done "

cd - >/dev/null 
done
