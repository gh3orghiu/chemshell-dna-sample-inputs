#!/bin/bash -l

# Batch script to run an MPI parallel job with the upgraded software
# stack under SGE with Intel MPI.

# 1. Force bash as the executing shell.
#$ -S /bin/bash

# 2. Request ten minutes of wallclock time (format hours:minutes:seconds).
#$ -l h_rt=24:00:0

# 3. Request 1 gigabyte of RAM per process (must be an integer)
#$ -l mem=1G

# 4. Request 15 gigabyte of TMPDIR space per node (default is 10 GB)
#$ -l tmpfs=10G

# 5. Set the name of the job.
#$ -N namd_test

# 6. Select the MPI parallel environment and 16 processes.
#$ -pe mpi 64

# 7. Set the working directory to somewhere in your scratch space.  This is
# a necessary step with the upgraded software stack as compute nodes cannot
# write to $HOME.
# Replace "<your_UCL_id>" with your UCL user ID :
#$ -wd /home/uccaagh/Scratch/namd/1bna/replicas/rep2_1fs_ts/input 

module load fftw/2.1.5/intel-2015-update2
module load namd/2.12/intel-2018-update3 

inp1=eq0
inp2=eq1
inp3=eq2
#inp4=eq3
inp5=sim1
# 8. Run our MPI job.  GERun is a wrapper that launches MPI jobs on our clusters.
gerun namd2 $inp1.conf > $inp1.log
gerun namd2 $inp2.conf > $inp2.log
gerun namd2 $inp3.conf > $inp3.log
#gerun namd2 $inp4.conf > $inp4.log
gerun namd2 $inp5.conf > $inp5.log



