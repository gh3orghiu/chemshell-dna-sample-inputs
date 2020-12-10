#!/bin/bash
# This script takes in a PDB snapshot saved using VMD.
# The PDB snapshot may come from a MD trajectory containing DNA, solvent and counter-ions

# Copy this script to folder with the snapshot and run, using the snapshots filename as first argument

# Make sure argument is given
if [[ $# -eq 0 ]] ; then
	echo 'No arg given: Pass pdb filename'
	exit 0
fi

# Back up initial pdb
cp $1.pdb $1_bak.pdb

## Take topology of initial pdb and convert back to an AMBER-readable pdb format
# First generate the .prmtop and .inpcrd files
topology_tleap.sh $1
# Create an AMBER-readable .pdb from the .prmtop and .inpcrd files
amb2pdb.sh $1

## Remove the periodicity of the .pdb so it is readable by ChemShell and save as dna_sph.pdb
# Use the vmd script water_shell_cutting.tcl to select how large the solvaiton sphere around nucleic should be.
vmd -dispdev text $1.pdb < water_shell_cutting.tcl
# Back-up dna_sph.pdb and convert back to an AMBER-readable pdb format
cp dna_sph.pdb dna_sph_bak.pdb
topology_tleap.sh dna_sph
amb2pdb dna_sph

## OPTIONAL
# Orientate the nucleic so that GC base pair is on the xy- plane
vmd -dispdev text dna_sph.pdb < orient.tcl
# Back-up dna_rot.pdb and convert back to an AMBER-readable pdb format
cp dna_rot.pdb dna_r.pdb
topology_tleap.sh dna_r
amb2pdb.sh dna_r

# We now have a configuration of DNA (dna_r.prmtop, dna_r.inpcrd and dna_r.pdb)
# ready for ChemShell optimisation proceedures.
# (In this case, the '_r' stands for 'reactant')

## It is sensible to fix most atoms in place, and only allow some to move during optimisation
# Use the selec_resid_3.tcl script to to create a list of all residues within 15 Angstroms of residue 3 from dna_r.pdb
vmd -dispdev text dna_r.pdb < ../scripts/selec_resid_3.tcl
# The list of atoms free to move are saved as 'active_3.mol' in a format readable by ChemShell

