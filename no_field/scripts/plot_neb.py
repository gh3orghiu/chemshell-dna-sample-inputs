import pandas as pd
import numpy as np
import glob
import os
import matplotlib as mpl
import matplotlib.pyplot as plt
from matplotlib import cm

df = pd.read_csv('kcalnebinfo', header=None, delim_whitespace=True, names=['Rxn Coord', 'Energy'])

rxn = df['Rxn Coord'].tolist()
energy = df['Energy'].tolist()

a=np.arange(len(rxn))

plt.plot(rxn, energy)

for j in np.arange(len(rxn)):
        value=str(round(float(a[j]), 2))
        plt.text(rxn[j],energy[j], j)

plt.xlabel('Reaction Coordinate')
plt.ylabel('Energy kcal/mol')
plt.savefig('neb_graph.png')
