import parmed as pmd
import numpy as np
# Needed to add an atom
import copy # To create a dummy atom
from parmed.amber import AmberParm
from parmed.tools import addLJType
from itertools import product
import os
import glob as glob

def pick_set(x,exclude):
    # Scans list x, returns a list without strings in pick
    check = [i for i in x if not any([e for e in exclude if e in i])]
    return check

def pick_include_set(x,include):
    # Scans list x, returns a list with strings in pick
    check = [i for i in x if any([e for e in include if e in i])]
    return check

# Creat a list with everything available
opt_geoms = sorted((glob.glob('rep_103/a_reac/reac_opt.pdb')))
prmtops   = sorted((glob.glob('rep_103/initial_struc/reac.prmtop')))

print(len(opt_geoms), len(prmtops))

# Create a list where opt geoms are present
inc_list=[]
for i in np.arange(len(opt_geoms)):
	inc_list.append(opt_geoms[i][:7])

# Create a list with only opt geoms
opt_geoms = sorted(pick_include_set(glob.glob('rep_103/a_reac/reac_opt.pdb'), inc_list))
prmtops   = sorted(pick_include_set(glob.glob('rep_103/initial_struc/reac.prmtop'), inc_list))

print(len(opt_geoms), len(prmtops))

if len(opt_geoms)==len(prmtops):
	print('All is well')	
else:
	print('The two directories do not match sizes')

for i in np.arange(len(prmtops)):
    rep_string = prmtops[i][:7]
    dna = pmd.load_file(prmtops[i], opt_geoms[i])
    
    dna.save(f'{rep_string}/optimised_struc/reac_opt.pdb', overwrite=True)
    dna.save(f'{rep_string}/optimised_struc/reac_opt.prmtop', overwrite=True)
    dna.save(f'{rep_string}/optimised_struc/reac_opt.inpcrd', overwrite=True)
   
    print(rep_string)
