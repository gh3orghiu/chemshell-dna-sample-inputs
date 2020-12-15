# Will select 15 Angstroms of residues within nucleic and save as an open-boundary pdb

proc get_pdbs {mol} {

   set sel [atomselect top "nucleic or (same residue as resname WAT and within 15.0 of nucleic) or (same residue as resname 'Na+' and within 13.0 of nucleic)"]  
   
   $sel writepdb dna_sph.pdb

}

get_pdbs top
