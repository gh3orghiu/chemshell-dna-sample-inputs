#!/bin/bash --login
# Suibmit script for ChemShell linked with NWChem

#PBS -N dimer1_rep01  

#PBS -l select=8

#PBS -l walltime=10:00:00

#PBS -A e283-gheorghiu

# Move to directory that script was submitted from
export PBS_O_WORKDIR=$(readlink -f $PBS_O_WORKDIR)
cd $PBS_O_WORKDIR

##Modules
module swap PrgEnv-cray PrgEnv-intel/5.1.29
module swap intel intel/15.0.2.164
module swap cray-mpich/7.5.5 cray-mpich/7.2.6
module unload cray-libsci
module unload craype-ivybridge
module load openssl
module load git
module load wget
module load autotools

##ChemShell
root=/work/e283/e283/gheorgha/chemsh-3.7.0-nwchem/
export TCLLIBPATH=$root/tcl
export TCL_LIBRARY=/work/e283/e283/gheorgha/tcl/tcl8.4.19/lib/tcl8.4

##NWChem
export NWCHEM_BASIS_LIBRARY=/work/e283/e283/gheorgha/Scratch/nwchem/libraries/
export NWCHEM_TOP=/work/e283/e283/gheorgha/nwchem-6.6/nwchem-6.6/
export NWCHEM_TARGET=LINUX64

aprun -n 192 $root/bin/chemsh.x dimer.chm > dimer.log
