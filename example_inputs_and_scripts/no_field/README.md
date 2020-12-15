# DNA QM/MM Example Using ChemShell

This folder contains all the relevant files needed to the rate coefficients of proton transfer in a DNA base pair using ChemShell.</br>
It may be advisable to add add the scripts directory to PATH using .bashrc so you do not need to copy each script into individual folders before executing them.</br>
More information detailing how to use the scripts is given in the 'scripts' folder README.</br>

The following files are available:</br>
\- The ChemShell input files '\*.chm'</br>
\- Summarised output files (given as energy.txt, rms-dist.txt etc.), complete ChemShell .log files are not included as they are too large for GitHub.</br>
\- The initial QM/MM geometries (found in 'initial\_geom' for reactant, products, transition states and intermediates (when necessary).</br>
\- The QM/MM optimised geometries (found in 'optimised\_struc' for reactant, products, transition states and intermediates (where necessary), as well as a trajectory of the geometry optimisation 'path\_active.xyz'.</br>
\- The QM/MM climbing-image nudged elastic band reaction coordinates graphically displayed in 'neb\_graph.png' using 'plot\_neb.py'</br>
\- The stripped\-down inputs/outputs of the Hessian calculations for each optimised structure in 'hess'.</br>
\- The forward (kf) and reverse (kr) rate coefficients of proton transfer calculated using the Hessian outputs in 'rate'.</br>
