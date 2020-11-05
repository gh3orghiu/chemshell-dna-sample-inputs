import parmed as pmd

dna = pmd.load_file('reac_opt.prmtop', 'reac_opt.inpcrd')

## Co-ordinates start from 0 i.e same number as VMD

#NHN Origial Co-ords
N1 = dna.coordinates[680]
H1 = dna.coordinates[681]
N3 = dna.coordinates[82]

#OHN Original Co-ords
O6 = dna.coordinates[679]
H41 = dna.coordinates[80]
N4 = dna.coordinates[79]

#Calculate Estimate 
NHN= N4 - H41 + O6
OHN= N1 - H1 + N3

#Update Atom Positions
## H41 number
dna.atoms[80].xx = NHN[0]
dna.atoms[80].xy = NHN[1]
dna.atoms[80].xz = NHN[2]

## H1 number
dna.atoms[681].xx = OHN[0]
dna.atoms[681].xy = OHN[1]
dna.atoms[681].xz = OHN[2]

dna.save('../initial_struc/prod.inpcrd', overwrite=True)
dna.save('../initial_struc/prod.prmtop', overwrite=True)
dna.save('../initial_struc/prod.pdb', overwrite=True)


