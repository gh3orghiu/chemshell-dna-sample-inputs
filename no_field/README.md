# DNA QM/MM Example Using ChemShell

This folder contains all the relevent files needed to the rate coefficients of proton transfer in a DNA base pair using ChemShell.
It may be advisable to add add the scripts directory to PATH using .bashrc so you do not need to copy each script into indivdual folders befor executing them.</p>

The following files are available:
\- Input ChemShell input files '\*.chm'
\- Summarised output files (given as energy.txt, rms-dist.txt etc.), complete ChemShell .log files are not included as they are too large for GitHub
\- The initial QM/MM geometries (found in 'initial\_geom' for reactant, products, transition states and intermediates (when necessary)
\- The QM/MM optimised geometries (found in 'optimised\_struc' for reactant, products, transition states and intermediates (where necessary), as well as a trajectory of the geometry optimisation 'path\_active.xyz'.</p>
\- The QM/MM climbing-image nudged elastic band reaction coordinates graphically displayed in 'neb\_graph.png' using 'plot\_neb.py'




