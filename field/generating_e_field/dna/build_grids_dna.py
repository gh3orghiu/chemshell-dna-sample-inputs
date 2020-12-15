import parmed as pmd
import numpy as np
# Needed to add an atom
import copy # To create a dummy atom
from parmed.amber import AmberParm
from parmed.tools import addLJType
from itertools import product
import os
import glob as glob

# This entire script is used to generate an electric field around a DNA that have been oriented around the xy-axis and centred at the origin.
# The oritented DNA is given in ../../align_dna_to_axis/rep_101/reac_o{.prmtop,.inpcrd,.pdb}.

# This function places a non-interacting dummy atom at the x,y,z coordinates (a,b,c)
# The charge on the Dummy atom is given by 'd'

print('This script will take several minutes to run per electric field built')

def build_field(a, b, c, d):
    dna.add_atom(copy.copy(dna.atoms[-1]), 'DU', dna.residues[-1].number + 1)
    # Now set various attributes of the atom to make it look different
    dummy = dna.atoms[-1]
    dummy.atomic_number = 2
    dummy.type = 'He'
    dummy.mass = 0
    dummy.charge = d
    dummy.name = 'DU'
    dummy.xx, dummy.xy, dummy.xz = a, b, c
    dna.remake_parm() # Needed to update the data that actually gets written to the prmtop file
    # Give the dummy atom 0 Lennard-Jones
    pmd.tools.addLJType(dna, '@DU', radius=1, epsilon=0.0).execute()
    pmd.tools.addExclusions(dna, '@DU', ':1').execute()

# Set grid coordinates for where the point charges will be placed.
# The following setting is for 'pos x', in this case, charges are placed in the postive and negative x-axis.
# ymax and ymin determine the hight of the grids in the y-axis
ymin, ymax, num_grid_point = -50, 50, 10
grid_point = np.linspace(ymin, ymax, num_grid_point)
# Place one grid in the positive x-axis, and one in the negative x-axis
pos_pts = np.array(list(product([50], grid_point, grid_point)))
neg_pts = np.array(list(product([-50], grid_point, grid_point)))

# Build an array of different charges to apply on the dummy atom.
# These values have been tested before to ensure that the electric field at the center of the box
# equal 10^4 V/m, 10^5 V/m, 10^6 V/m, 10^7 V/m, 10^8 V/m, and 10^9 V/m.
power_min, power_max, split = -5, 0, 6
powers = np.linspace(power_min, power_max, split)
charges = 10**powers
charges
# After measuring field str of the initial guess, we divide charges by 5.472 (calculated before-hand)
new_charges= charges/5.472
new_charges


#print('These dummy atoms will contain the following charge magnitudes: \n', new_charges)
print('These dummy atoms will contain the following charge magnitudes: \n', new_charges[-1])

# Set directory names for different electric fields strengths, 10^4 V/m, 10^5 V/m, etc.
field_dir_names = ['4', '5', '6', '7', '8', '9']

# Now add charges to the oriented dna system.
# This example just tests 10^9 V/m
# Comment this block ut and ammend the script if you would like to generate all the electric field strengths and uncomment the loop at the bottom.
# Example script, not including a loop.
q = new_charges[-1]
dna = AmberParm('../../align_dna_to_axis/rep_101/a_reac/reac_o.prmtop', '../../align_dna_to_axis/rep_101/a_reac/reac_o.inpcrd')
_ = [build_field(*coords, q ) for coords in pos_pts]
print('Done positive charges ... 99 % complete')
_ = [build_field(*coords, -q ) for coords in neg_pts]
print('Done negative charges ... 99 % complete')
dna.save('../../pos_x_9/rep_101/initial_struc/reac.prmtop', overwrite=True)
dna.save('../../pos_x_9/rep_101/initial_struc/reac.inpcrd', overwrite=True)
dna.save('../../pos_x_9/rep_101/initial_struc/reac.pdb', overwrite=True)
print('Made DNA with field strength: ' + field_dir_names[-1])


# Now add charges to the oriented dna system.
# Use me if chose to loop.
#for i in np.arange(len(new_charges)):
#    q = float(new_charges[i])
#    dna = AmberParm('../../align_dna_to_axis/rep_101/a_reac/reac_o.prmtop', '../../align_dna_to_axis/rep_101/a_reac/reac_o.inpcrd')
#    _ = [build_field(*coords, q ) for coords in pos_pts]
#    _ = [build_field(*coords, -q ) for coords in neg_pts]
#    dna.save('../../pos_x_9/rep_101/initial_struc/reac.prmtop', overwrite=True)
#    dna.save('../../pos_x_9/rep_101/initial_struc/reac.inpcrd', overwrite=True)
#    dna.save('../../pos_x_9/rep_101/initial_struc/reac.pdb', overwrite=True)
#    print('Made DNA with field strength: ' + field_dir_names[i])


