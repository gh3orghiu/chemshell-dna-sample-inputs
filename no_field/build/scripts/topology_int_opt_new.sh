#!/bin/bash

## Script converts pdb from vmd, modifies pdb to be readable by tleap, generates tleap topology, then overwrites a new pdb

source activate ambertools

cd ..
# Should be in build directory here

# Dimer array 
#arr=( 03 06 08 10 12 14 17 19 24 33 )
#arr=( 03 ) #06 08 10 12 14 17 19 24 33 )
arr=( 10 33 )
# Setting up the folders
for (( i=0;i<2;++i ))
do

rep_name=rep${arr[i]}

# Change to dimer int  directory
cd $rep_name/int_new_tol

cp ../../../opt/$rep_name/int_new_tol/int_opt_new.xyz .

# Convert xyz to pdb using obabel
obabel int_opt_new.xyz -opdb -m >/dev/null

# Change HETATM  to ATOM, so readable by pdbmerger
sed -i 's/HETATM/ATOM  /g' int_opt_new.pdb

# Merge pdb to original dna_r.pdb
pdbmerger.sh int_opt_new ../../$rep_name/reactant/dna_r_re int_opt_new_re

# Get topology from new readable PDB
topology_tleap.sh int_opt_new_re >/dev/null

# Convert to amber PDB

amb2pdb.sh int_opt_new_re >/dev/null

echo " $rep_name Optimised int structure is reeady for hessian calc"

cd - >/dev/null 
done
