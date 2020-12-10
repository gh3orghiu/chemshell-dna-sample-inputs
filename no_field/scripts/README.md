# Scripts

1. In the 'initial\_struc' directory containing a .pdb snapshot of solvated DNA from a molecular dynamics trajectory, run the 'set\_up\_struc.sh' script. The should create 'dna\_r.pdb', which will be the initial configuration of the reactant for the QM/MM optimisation.</br>
2. In 'a\_reac', run the 'reac\_opt.chm' input using ChemShell. This will output a log file (not included due to size limit), but a summary of the log file (\*txt), made using 'summarise\_chemsh.sh' and graphic visual 'convergence-summary.png' using 'plot\_chemsh\_summary.gp', is included. Upon completion, a QM/MM opitmised geometry given as 'dna\_r\_opt.xyz' will be obtained.</br>
3. The 'dna\_r\_opt.xyz' file does not contain any relevent information about the connectivity of the system that is given in the AMBER .prmtop, .inpcrd, and .pdb files. To start the correct conversion process, run 'sort\_pdbs\_out.sh' in the 'a\_reac'directory. From there, run the python script 'save\_reac\_opt\_pdb\_prmtop\_inpcrd.py' to generate the AMBER ready prmtop, .inpcrd, and .pdb files in the 'optimised\_struc' folder.</br>



The scripts listed in this folder 


## To summarise optimisation output logs, including NEB and dimer calculations
Although there are no ChemShell logs included in this example (they are too large) a summary of the logs (the \*txt files) are created using 'summarise\_chemsh.sh' and graphically visualised using 'plot\_chemsh\_summary.gp'
