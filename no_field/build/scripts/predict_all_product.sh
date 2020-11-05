#!/bin/bash

# Predict the structure and topology for the GC DPT tautomer
# Requires dna_r_re .prmtop .inpcrd placed in build/repX/reactant

# First, change to reactant directory

source activate ambertools

# Go to /build
cd ..

# Iterate through replicas in build directory
# Dimer array 
arr=( 01 04 05 07 09 21 23 25 27 29 )
# Setting up the folders

for (( i=0;i<10;++i ))
do
rep_name=rep${arr[i]}

# Change to reactant directory
cd $rep_name/reactant

# Predict malfkin product !
# Check for opt pdb
files=$(ls dna_r_re.prmtop 2> /dev/null | wc -l)
# If that readable optimised prmtop file is there...
if [ "$files" != "0" ]
then
python ../../scripts/predict_product.py 

# Move to product folder
mv dna_p.* ../product/
echo " $rep_name predicted "
else 
	echo " $rep_name not complete "
fi
cd - > /dev/null
done

