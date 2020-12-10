#!/bin/bash

## A script to summarise large ChemShell optimisation log outputs
# Use name output file as the first argument of this script.

if [ -z $1 ];then
echo "Please add name of ChemShell log file without suffix extension"
exit
fi


# Will prepare six text files: energy, max step, rms-step, rms-grad, and time-step (for ChemShell/NWChem Calcs)

grep '  Energy' $1.log > tmp1
grep 'Max step ' $1.log > tmp2
grep 'RMS step' $1.log > tmp3
grep 'RMS grad' $1.log > tmp4

awk '($1=="Energy") {printf"%s\n",substr($0,13,10)}' tmp1 > tmp5
awk '($1=="Energy") {printf"%s\n",substr($0,32,10)}' tmp1 > tmp6
paste -d " " tmp5 tmp6 > tmp7
echo "Energy     Target" > tmp8
cat tmp7 >> tmp8
cp tmp8 energy.txt

awk '($1=="Max") {printf"%s\n",substr($0,13,10)}' tmp2 > tmp5
awk '($1=="Max") {printf"%s\n",substr($0,32,10)}' tmp2 > tmp6
paste -d " " tmp5 tmp6 > tmp7
echo "Max Step   Target" > tmp8
cat tmp7 >> tmp8
cp tmp8 max-step.txt

awk '($1=="RMS") {printf"%s\n",substr($0,13,10)}' tmp3 > tmp5
awk '($1=="RMS") {printf"%s\n",substr($0,32,10)}' tmp3 > tmp6
paste -d " " tmp5 tmp6 > tmp7
echo "RMS Step   Target" > tmp8
cat tmp7 >> tmp8
cp tmp8 rms-step.txt

awk '($1=="RMS") {printf"%s\n",substr($0,13,10)}' tmp4 > tmp5
awk '($1=="RMS") {printf"%s\n",substr($0,32,10)}' tmp4 > tmp6
paste -d " " tmp5 tmp6 > tmp7
echo "RMS Grad   Target" > tmp8
cat tmp7 >> tmp8
cp tmp8 rms-grad.txt

grep '...hybrid.calc/dl_poly.eandg/==================== Tstep:' $1.log > tmp9
awk '{print $3}' tmp9 > tmp10      
mv tmp10 time-step.txt

##summary
grep 'converge' $1.log > $1_sum.txt

rm tmp*

##Final time in hours
#if grep -q 'Timing report' $1.log; then
if grep -q 'load_amber_coords/write_xyz/' $1.log; then
    awk '{s+=$1} END {print s}' time-step.txt > tmpa
    ttot=$(awk '{print $1}' tmpa)
    echo $((${ttot%.*}/3600)) > tmpc
    echo 'Time to completion / hours' > tmpd
    thrs=$(awk '{print $1}' tmpc)
    cat tmpd tmpc > tmpe
    cat $1_sum.txt tmpe >> $1_sum.txt > /dev/null
    a=$(cat rms-step.txt | wc -l )
    echo Calculation Complete in: $thrs hrs: $a steps
    rm tmp*
else
    echo !!!!!!!!!!!!!!!! Calculation incomplete - please wait !!!!!!!!!!!!!!
    echo | tail -n 6 $1_sum.txt
fi

