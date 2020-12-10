## Will save a list of atoms within X Angstroms about a particular residue
## in a readable form for ChemShell 'active atoms' during optimisation procedures
 
# REMEMBER residue numbers start at 0 in VMD

proc select {outfile mol} {
set listfile [open $outfile w]
set var1 [atomselect top "same residue as resname WAT and within 16 of index 681"]
set var2 [atomselect top "same residue as resname 'Na+' and within 15 of index 681"]
set var3 [atomselect top "same residue as nucleic and within 15 of index 681"]

#nucleic first, water, na+
puts $listfile "set active { [$var3 get serial] [$var1 get serial] [$var2 get serial] }"
close $listfile
}

select active_3.mol mol
