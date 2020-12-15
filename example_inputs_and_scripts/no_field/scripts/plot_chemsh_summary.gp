# Plot convergence of QM/MM simulation

set terminal png size 1000,750 enhanced font "arial,12" #fontscale 1.0 size 1000, 700
set encoding utf8

set key noautotitles

set output 'convergence-summary.png'

set format y "%2.0t{x}10^{%L}" 

set logscale y
set multiplot layout 2,2 title "DNA Optimisation Convergence: Using ChemShell B3LYP+XDM/aug-cc-pvdz/Amber: Generated using plot\\\_chemsh\\\_summary.gp"

#set xrange [3000:6000]
set key top right
set title "Convergence for energy change per opt step"
set xlabel "Geopt Step"
set ylabel "Energy / Hartree"
pl "energy.txt" u 0:1 w l title "Energy", "energy.txt" u 0:2 w l title "Tolerance"

set title "Maximum change of one co-ordinate per opt step"
set xlabel "Geopt Step"
set ylabel "Max-Step"
pl "max-step.txt" u 0:1 w l title "Max Step", "max-step.txt" u 0:2 w l title "Tolerance"

set title "RMS change of co-ordinates per opt step"
set xlabel "Geopt Step"
set ylabel "RMS-Step"
pl "rms-step.txt" u 0:1 w l title "RMS Step", "rms-step.txt" u 0:2 w l title "Tolerance"

set title "RMS gradient of co-ordinates per opt step"
set xlabel "Geopt Step"
set ylabel "RMS-Gradient"
pl "rms-grad.txt" u 0:1 w l title "RMS Gradient", "rms-grad.txt" u 0:2 w l title "Tolerance"

