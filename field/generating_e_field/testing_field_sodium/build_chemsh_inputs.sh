#!/bin/bash
## Set-up folders ##

## Build directories: ##
## The example wil only test the electric field strength at 10^9 V/m
mkdir -p 9/{x,y,z}/{neg,pos}/{00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20}

## Use the command below if testing all electric field strengths 
#mkdir -p {4,5,6,7,8,9}/{x,y,z}/{neg,pos}/{00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20}


# The electric field testing is in the positive x direction
# Keep this the same #
field_dir=pos_x

# Make sure argument is given
#if [[ $# -eq 0 ]] ; then
if [[ $# -ne 2 ]] ; then
	echo 'No args given:'
	echo 'Argument 1 should be field strength, e.g., 8, 9'
	echo 'Argument 2 should be direction to move sodium ion, either, x, y, or z'
	echo 'Please try:'
	echo './build_inputs.sh 9 x'
	exit 0
fi

# Change me to create inputs manually
# Field strength, e.g. 8, 9
field_str=$1
# Direction to move sodium, x, y, or z.
move_dir=$2

# Keep this the same.
arr=( 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 )


direction=pos
for (( i=0;i<21;++i ))
do
dist=${arr[i]}


echo '### Built using Alex input generator '$(date +%Y-%-m-%d)'
# QM.MM simulation (hybrid) with electrostaic embedding - Energy Calculation

# Set variables

set init_c sodium.c
set inpd ../../../../build/sodium_'$field_dir'_'$field_str'_'$direction''$move_dir'_'$dist'.inpcrd
set pmtp ../../../../build/sodium_'$field_dir'_'$field_str'_00.prmtop 

# Load in the AMBER ff (make sure they are not periodic)
load_amber_coords inpcrd=$inpd prmtop=$pmtp coords=$init_c

# Calculate MM energy to return list_amber_atom_charges
energy energy=e coords=$init_c theory=dl_poly  : [ list \
        amber_prmtop_file=$pmtp \
        scale14 = [ list [ expr 1 / 1.2 ] 0.5  ] \
        save_dl_poly_files = yes \
        list_option=none ]

set atom_charges [ list_amber_atom_charges ]

# Set QM atoms
## VMD starts from 0, chemsh starts from 1 ##
set qm_atoms { 1 }
set qm_atoms [ expand_range $qm_atoms ]

# Set args for the hybrid theory
set args [ list coupling=shift \
        atom_charges= $atom_charges \
        qm_region= $qm_atoms \
        list_option=full \
        mm_theory=dl_poly :  [ list \
        amber_prmtop_file=$pmtp \
        scale14 = [ list [ expr 1 / 1.2 ] 0.5  ] \
        conn= $init_c \
        save_dl_poly_files = yes \
        list_option=none ] \
        qm_theory=nwchem :  [ list hamiltonian=b3lyp \
        basis= 6-31+g* charge=1 ] ]

# Build a matrix 'e' to update with energy
matrix e
eandg energy=e coords=$init_c gradient=g.gradient theory= hybrid : [ list $args ] list_option=full
delete_object e' > input.chm

mv input.chm $field_str/$move_dir/$direction/$dist

echo 'Made: '$field_str' '$move_dir' '$direction' '$dist' input.chm'

done

for (( i=0;i<21;++i ))
do
dist=${arr[i]}

direction=neg
echo '### Built using Alex input generator '$(date +%Y-%-m-%d)'
# QM.MM simulation (hybrid) with electrostaic embedding - Energy Calculation

# Set variables

set init_c sodium.c
set inpd ../../../../build/sodium_'$field_dir'_'$field_str'_'$direction''$move_dir'_'$dist'.inpcrd
set pmtp ../../../../build/sodium_'$field_dir'_'$field_str'_00.prmtop 

# Load in the AMBER ff (make sure they are not periodic)
load_amber_coords inpcrd=$inpd prmtop=$pmtp coords=$init_c

# Calculate MM energy to return list_amber_atom_charges
energy energy=e coords=$init_c theory=dl_poly  : [ list \
        amber_prmtop_file=$pmtp \
        scale14 = [ list [ expr 1 / 1.2 ] 0.5  ] \
        save_dl_poly_files = yes \
        list_option=none ]

set atom_charges [ list_amber_atom_charges ]

# Set QM atoms
## VMD starts from 0, chemsh starts from 1 ##
set qm_atoms { 1 }
set qm_atoms [ expand_range $qm_atoms ]

# Set args for the hybrid theory
set args [ list coupling=shift \
        atom_charges= $atom_charges \
        qm_region= $qm_atoms \
        list_option=full \
        mm_theory=dl_poly :  [ list \
        amber_prmtop_file=$pmtp \
        scale14 = [ list [ expr 1 / 1.2 ] 0.5  ] \
        conn= $init_c \
        save_dl_poly_files = yes \
        list_option=none ] \
        qm_theory=nwchem :  [ list hamiltonian=b3lyp \
        basis= 6-31+g* charge=1 ] ]

# Build a matrix 'e' to update with energy
matrix e
eandg energy=e coords=$init_c gradient=g.gradient theory= hybrid : [ list $args ] list_option=full
delete_object e' > input.chm

mv input.chm $field_str/$move_dir/$direction/$dist

echo 'Made: '$field_str' '$move_dir' '$direction' '$dist' input.chm'

done




