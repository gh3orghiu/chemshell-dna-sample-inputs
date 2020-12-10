package require Orient
namespace import Orient::orient

mol load pdb dna_sph.pdb
# Will orient a certain residue about the xy-axis
set all [atomselect top "all"]
set sel [atomselect top "index 73 to 84 673 to 687"]
set I [draw principalaxes $sel]
set A [orient $sel [lindex $I 2] {1 0 0}]
$all move $A
set I [draw principalaxes $sel]
set A [orient $sel [lindex $I 1] {0 1 0}]
$all move $A
set I [draw principalaxes $sel]

#Center molecule
set minus_com [vecsub {0.0 0.0 0.0} [measure center $all]]
$all moveby $minus_com

$all writepdb dna_rot.pdb
