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

os.chdir('..')

include= [ 'rep_101' ] 
opt_geoms = sorted(pick_include_set(glob.glob('rep_1*/neb/ts2.pdb'),include))
prmtops   = sorted(pick_include_set(glob.glob('rep_1*/initial_struc/reac.prmtop'),include))

print(len(opt_geoms), len(prmtops))

print(opt_geoms)
print(prmtops)
if len(opt_geoms)==len(prmtops):
	for i in np.arange(len(prmtops)):
	    rep_string = prmtops[i][:7]
	    dna = pmd.load_file(prmtops[i], opt_geoms[i])
    
	    dna.save(f'{rep_string}/initial_struc/ts2.pdb', overwrite=True)
	    dna.save(f'{rep_string}/initial_struc/ts2.prmtop', overwrite=True)
	    dna.save(f'{rep_string}/initial_struc/ts2.inpcrd', overwrite=True)   
	    print(rep_string)

print( 'Saved initial ts2 files for '+ rep_string)


opt_geoms = sorted(pick_include_set(glob.glob('rep_1*/neb/int.pdb'),include))
prmtops   = sorted(pick_include_set(glob.glob('rep_1*/initial_struc/reac.prmtop'),include))

print(len(opt_geoms), len(prmtops))

print(opt_geoms)
print(prmtops)
if len(opt_geoms)==len(prmtops):
	for i in np.arange(len(prmtops)):
	    rep_string = prmtops[i][:7]
	    dna = pmd.load_file(prmtops[i], opt_geoms[i])
    
	    dna.save(f'{rep_string}/initial_struc/int.pdb', overwrite=True)
	    dna.save(f'{rep_string}/initial_struc/int.prmtop', overwrite=True)
	    dna.save(f'{rep_string}/initial_struc/int.inpcrd', overwrite=True)   
	    print(rep_string)

print( 'Saved initial int files for '+ rep_string)
