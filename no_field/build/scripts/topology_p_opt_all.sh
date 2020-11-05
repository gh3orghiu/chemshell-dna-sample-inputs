#!/bin/bash

## Script converts xyz from chemshell to pdb, modifies pdb to be reable by tleap,  generates tleap topology, then overwrites a new pdb

# Got to replicas folder, tar up xyz files
cd ../../opt/
tar -czf prod_opt.tar  rep*/prod*/dna_p_opt.xyz

# Move xyz files to build
mv prod_opt.tar ../build/
cd ../build
tar -xvf prod_opt.tar
rm prod_opt.tar


# Should be in build directory here

# Iterate through replicas in build directory
arr=( 01 04 05 07 09 21 23 25 27 29 )
# Setting up the folders

for (( i=0;i<10;++i ))
do

rep_name=rep${arr[i]}

# Change to reactant directory
cd $rep_name/product

# Check for opt pdb
files=$(ls dna_p_opt.xyz* 2> /dev/null | wc -l)
# If the opt xyz is there ...
if [ "$files" != "0" ]
then
# Convert xyz to pdb using obabel
obabel *.xyz -opdb -m  >/dev/null

# Change HETATM  to ATOM, so readable by pdbmerger
sed -i 's/HETATM/ATOM  /g' dna_p_opt.pdb

# Merge pdb to original dna_r.pdb
pdbmerger.sh dna_p_opt ../dna_r dna_p_re

# Get topology from new readable PDB
topology_tleap.sh dna_p_re >/dev/null

# Convert to amber PDB

amb2pdb.sh dna_p_re >/dev/null

echo " $rep_name was optimised and done "

# Otherwise,
else
    echo " $rep_name not complete  "
fi
cd - >/dev/null

done
