import parmed as pmd
import numpy as np
# Needed to add an atom
import copy # To create a dummy atom
from parmed.amber import AmberParm
from parmed.tools import addLJType
from itertools import product
import os
import glob as glob

# This entire script with generate an electric field around a single Na+.
# The Na+ on its own is given in ../build/sodium{.prmtop,.inpcrd,.pdb}.
# It will then move the Na+ around the box and save new coordinates and forcefields.
# The strength of the electric field can then be calculated at different
# positions within the box by using ChemShell to calculate the gradient on the Na+ ion.

# This function places a non-interacting dummy atom at the x,y,z coordinates (a,b,c)
# The charge on the Dummy atom is given by 'd'
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

print('These dummy atoms will contain the following charge magnitudes: \n', new_charges)

# Set directory names for different electric fields strengths, 10^4 V/m, 10^5 V/m, etc.
field_dir_names = ['4', '5', '6', '7', '8', '9']

# Now add charges to the lone sodium ion.
for i in np.arange(len(new_charges)):
    q = float(new_charges[i])
    dna = AmberParm('../no_field/sodium.prmtop', '../no_field/sodium.inpcrd')
    _ = [build_field(*coords, q ) for coords in pos_pts]
    _ = [build_field(*coords, -q ) for coords in neg_pts]
    # _00 to signify the sodium is in the centre of the box
    # _pos_x signifies the field is in the positive x-direction, i.e. the positively charged points 'q' are in the 'pos_pts'
    # for electric field in the negative x-direction, switch around the positive and negative points, i.e., '-q' with 'pos_pts'.
    dna.save('sodium_pos_x_'+str(field_dir_names[i])+'_00.prmtop', overwrite=True)
    dna.save('sodium_pos_x_'+str(field_dir_names[i])+'_00.inpcrd', overwrite=True)
    dna.save('sodium_pos_x_'+str(field_dir_names[i])+'_00.pdb', overwrite=True)
    print('Made sodium with field strength: ' + field_dir_names[i])


# Set the intervals at which the sodium ion will be moved from the centre of the box in the x-direction
# (This ranges from -20, to +20)
pos_intervals = np.arange(0,21)
neg_intervals = -pos_intervals

# Function to update the coordinates of the sodium atom
def move_atoms(parm,x,y,z):
    # Sodium is the first atom in the prmtop file
    sodium = parm[0]
    sodium.xx, sodium.xy, sodium.xz = x, y, z
    parm.remake_parm()

# Set the new initial prmtop and inpcrd to include Sodium at the centre of the box with the electric field
init_parm = glob.glob('./*_?_00.prmtop')
init_inpd = glob.glob('./*_?_00.inpcrd')

print(init_parm)
print(init_inpd)

######
# Time to move the sodium
# This will generate a lot of files.
######

# Move Na+ in the positive x-direction. Save prmtop, inpcrd and pdb of each step.
for i in np.arange(len(init_parm)):
    parm = AmberParm(init_parm[i], init_inpd[i])
    for j in np.arange(len(pos_intervals)):
        move_atoms(parm, pos_intervals[j], 0, 0)
        parm.save('sodium_pos_x_' + str(i+4) + '_negx_' + "{:02d}".format((pos_intervals[j])) + '.pdb', overwrite=True)
        # It is not necessary to save the prmtop 100s of times. This will remain the same.
        #parm.save('sodium_pos_x_' + str(i+4) + '_neg_' + "{:02d}".format((pos_intervals[j])) + '.prmtop', overwrite=True)
        parm.save('sodium_pos_x_' + str(i+4) + '_negx_' + "{:02d}".format((pos_intervals[j])) + '.inpcrd', overwrite=True)
        #print(init_parm[i], pos_intervals[i])
print('Finished positive x intervals')

# Move Na+ in the negative x-direction. Save prmtop, inpcrd and pdb of each step.
for i in np.arange(len(init_parm)):
    parm = AmberParm(init_parm[i], init_inpd[i])
    for j in np.arange(len(neg_intervals)):
        # Change the intervals here to negative
        move_atoms(parm, neg_intervals[j], 0, 0)
        parm.save('sodium_pos_x_' + str(i+4) + '_posx_' + "{:02d}".format((pos_intervals[j])) + '.pdb', overwrite=True)
        # It is not necessary to save the prmtop 100s of times. This will remain the same.
        #parm.save('sodium_pos_x_' + str(i+4) + '_pos_' + "{:02d}".format((pos_intervals[j])) + '.prmtop', overwrite=True)
        parm.save('sodium_pos_x_' + str(i+4) + '_posx_' + "{:02d}".format((pos_intervals[j])) + '.inpcrd', overwrite=True)
        #print(init_parm[i], neg_intervals[i])
print('Finished negative x intervals')

######

# Move Na+ in the positive y-direction. Save prmtop, inpcrd and pdb of each step.
for i in np.arange(len(init_parm)):
    parm = AmberParm(init_parm[i], init_inpd[i])
    for j in np.arange(len(pos_intervals)):
        move_atoms(parm, 0, pos_intervals[j], 0)
        parm.save('sodium_pos_x_' + str(i+4) + '_negy_' + "{:02d}".format((pos_intervals[j])) + '.pdb', overwrite=True)
        # It is not necessary to save the prmtop 100s of times. This will remain the same.
        #parm.save('sodium_pos_x_' + str(i+4) + '_neg_' + "{:02d}".format((pos_intervals[j])) + '.prmtop', overwrite=True)
        parm.save('sodium_pos_x_' + str(i+4) + '_negy_' + "{:02d}".format((pos_intervals[j])) + '.inpcrd', overwrite=True)
        #print(init_parm[i], pos_intervals[i])
print('Finished positive y intervals')

# Move Na+ in the negative y-direction. Save prmtop, inpcrd and pdb of each step.
for i in np.arange(len(init_parm)):
    parm = AmberParm(init_parm[i], init_inpd[i])
    for j in np.arange(len(neg_intervals)):
        # Change the intervals here to negative
        move_atoms(parm, 0, neg_intervals[j], 0)
        parm.save('sodium_pos_x_' + str(i+4) + '_posy_' + "{:02d}".format((pos_intervals[j])) + '.pdb', overwrite=True)
        # It is not necessary to save the prmtop 100s of times. This will remain the same.
        #parm.save('sodium_pos_x_' + str(i+4) + '_pos_' + "{:02d}".format((pos_intervals[j])) + '.prmtop', overwrite=True)
        parm.save('sodium_pos_x_' + str(i+4) + '_posy_' + "{:02d}".format((pos_intervals[j])) + '.inpcrd', overwrite=True)
        #print(init_parm[i], neg_intervals[i])
print('Finished negative y intervals')

######

# Move Na+ in the positive z-direction. Save prmtop, inpcrd and pdb of each step.
for i in np.arange(len(init_parm)):
    parm = AmberParm(init_parm[i], init_inpd[i])
    for j in np.arange(len(pos_intervals)):
        move_atoms(parm, 0, 0, pos_intervals[j])
        parm.save('sodium_pos_x_' + str(i+4) + '_negz_' + "{:02d}".format((pos_intervals[j])) + '.pdb', overwrite=True)
        # It is not necessary to save the prmtop 100s of times. This will remain the same.
        #parm.save('sodium_pos_x_' + str(i+4) + '_neg_' + "{:02d}".format((pos_intervals[j])) + '.prmtop', overwrite=True)
        parm.save('sodium_pos_x_' + str(i+4) + '_negz_' + "{:02d}".format((pos_intervals[j])) + '.inpcrd', overwrite=True)
        #print(init_parm[i], pos_intervals[i])
print('Finished positive z intervals')

# Move Na+ in the negative z-direction. Save prmtop, inpcrd and pdb of each step.
for i in np.arange(len(init_parm)):
    parm = AmberParm(init_parm[i], init_inpd[i])
    for j in np.arange(len(neg_intervals)):
        # Change the intervals here to negative
        move_atoms(parm, 0, 0, neg_intervals[j])
        parm.save('sodium_pos_x_' + str(i+4) + '_posz_' + "{:02d}".format((pos_intervals[j])) + '.pdb', overwrite=True)
        # It is not necessary to save the prmtop 100s of times. This will remain the same.
        #parm.save('sodium_pos_x_' + str(i+4) + '_pos_' + "{:02d}".format((pos_intervals[j])) + '.prmtop', overwrite=True)
        parm.save('sodium_pos_x_' + str(i+4) + '_posz_' + "{:02d}".format((pos_intervals[j])) + '.inpcrd', overwrite=True)
        #print(init_parm[i], neg_intervals[i])
print('Finished negative z intervals')
