#!/bin/bash --login
# Suibmit script for ChemShell linked with NWChem

#PBS -N p_rep01  

#PBS -l select=8

#PBS -l walltime=18:00:00

#PBS -A d137-uccaagh

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
root=/work/d137/d137/uccaagh/chemsh-3.7.0-nwchem/
export TCLLIBPATH=$root/tcl
export TCL_LIBRARY=/work/d137/d137/uccaagh/tcl/tcl8.4.19/lib/tcl8.4

##NWChem
export NWCHEM_BASIS_LIBRARY=/work/d137/d137/uccaagh/Scratch/nwchem/libraries/
export NWCHEM_TOP=/work/d137/d137/uccaagh/nwchem-6.6/nwchem-6.6/
export NWCHEM_TARGET=LINUX64

aprun -n 192 $root/bin/chemsh.x prod_opt.chm > prod_opt.log
