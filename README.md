# Multiscale DNA Proton transfer sample inputs: Molecular Dynamics and QM/MM 

This repository contains the scripts and information needed to replicate a QM/MM study using ChemShell3.7/NWChem6.6/DL-POLY to investigate the proton transfer between a GC base pair in DNA.</br>
The DNA system is first equilibrated and sampled using all-atom molecular dynamics with NAMD 2.12.
Sample simulation inputs and outputs are given in 'md\_trajectory'</p>

The QM/MM part, to study proton transfer, is split into two main folders:</br>
i)  In the instance of no extneral electric field 'no\_field'. </br>
ii) In the presence of an external electric field 'field', in this case one external electric field direction and strength is demonstrated. This folders covers how an electric field is built and tested 'generating\_e\_field', as well as how the DNA is aligned to the corrected axis in the field 'align\_dna\_to\_axis'</p>


## Requirements
Tcl-ChemShell 3.7 coupled to NWChem 6.6 (this exact combination)</br>
NAMD 2.12 or above</br>
Ambertools</br>
anaconda</br>
Python 3.X (numpy, pandas, parmed)</br>
VMD 1.9 or above</br>
gnuplot</br>



