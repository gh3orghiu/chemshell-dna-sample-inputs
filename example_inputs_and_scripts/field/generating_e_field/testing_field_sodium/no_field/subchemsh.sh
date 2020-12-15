#!/bin/bash -l

# Batch script to run a ChemShell job on GRACE.

# 1. Force bash as the executing shell.
#$ -S /bin/bash

# 2. Request thirty minutes of wallclock time (format hours:minutes:seconds).
#$ -l h_rt=00:03:00

# 3. Request 1 gigabyte of RAM per core.
#$ -l mem=1G

# 4. Set the name of the job.
#$ -N sodium

# 5. Select the MPI parallel environment and 16 processors.
#$ -pe mpi 32

# 7. Set the working directory to somewhere in your scratch space. This 
# is a necessary step as compute nodes cannot write to $HOME. 
# This directory must exist.
#$ -wd /home/uccaagh/Scratch/chemshell/nwchem-link/electric_field_strength/sodium 

#This python module is needed for NWChem
module load python/2.7.9
module load gcc-libs/4.9.2
#This is required for Chemshell
module load tcl/8.6.8
module load compilers/intel/2018/update3
module load mpi/intel/2018/update3/intel

ROOT=/home/uccaagh/chemsh-3.7.0-nwchem
export TCLLIBPATH=${ROOT}/tcl
export TCL_LIBRARY=$TCLROOT/lib/tcl8.6
#export TCL_LIBRARY=/home/uccaagh/tcl/tcl8.5.11/lib/tcl8.5
export PATH=${PATH}:${ROOT}/scripts
export OMP_NUM_THREAD=1

# 8. Now we need to set up and run our job. 
mpirun -np 32 $ROOT/bin/chemsh.x chemsh.chm > chemsh.log
