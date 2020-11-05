## $1, $2, $3 are the first three command line arguments
## $1 is the optimized pdb, with the correct co-ordinates
## $2 is the pdb with corrected format
## $3 is the output file name.

#!/bin/bash

##To merge PDBS generated from VMD to the original PDB from Tleap
awk '($1=="ATOM") {printf"%s\n",substr($0,31,24)}' $1.pdb > tmp1
awk '($1=="ATOM") {printf"%s\n",substr($0,0,30)}' $2.pdb > tmp2
awk '($1=="ATOM") {printf"%s\n",substr($0,55)}' $2.pdb > tmp3
paste -d "\0" tmp2 tmp1 tmp3 > $3.pdb
echo "END" > tmp4
cat tmp4 >> $3.pdb
rm tmp*

