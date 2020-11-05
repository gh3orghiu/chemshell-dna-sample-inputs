#!/bin/bash
# This script takes in a PDB snapshot from a DCD trajectory that was saved using VMD
# Copy this script to folder with the scapshot and run

##! This script isn't so necessary in the aug, since we are repaeting 1bna_3, with 6-311++g**

source activate ambertools

# Make sure argument is given
if [[ $# -eq 0 ]] ; then
	echo 'No arg given: Pass pdb filename'
	exit 0
fi

# Back up initial pdb
cp $1.pdb $1_bak.pdb

# Take topology of initial pdb and convert back to nice pdb format
topology_tleap.sh $1
amb2pdb.sh $1

# Cut a shell around nucleic 
## Not recquired since already cut ##
#vmd -dispdev text $1.pdb < ../scripts/water_shell_cutting.tcl

# Back up sph pdb and convert back to nice pdb format
#cp dna_sph.pdb dna_sph_bak.pdb

topology_tleap.sh dna_sph
amb2pdb dna_sph

# Orientate the nucleic so that GC base pair is on XY plane
## Not recquired since already orientate b4 ##
# vmd -dispdev text dna_sph.pdb < ../scripts/orient.tcl

# Back up rot pdb and convert to nice pdb format
cp dna_rot.pdb dna_$1.pdb
topology_tleap.sh dna_$1

amb2pdb.sh dna_$1

# Read in nice rot pdb and select the residues (saved as active_x.mol)
# vmd -dispdev text dna_r.pdb < ../scripts/selec_resid_3.tcl

