#!/bin/bash

## Source min and max coordinates of box containing solvated nucleic

grep "O   WAT" $1.pdb | awk '{print $6}' | sort -n | head -n 1
grep "O   WAT" $1.pdb | awk '{print $6}' | sort -n | tail -n 1

grep "O   WAT" $1.pdb | awk '{print $7}' | sort -n | head -n 1
grep "O   WAT" $1.pdb | awk '{print $7}' | sort -n | tail -n 1

grep "O   WAT" $1.pdb | awk '{print $8}' | sort -n | head -n 1
grep "O   WAT" $1.pdb | awk '{print $8}' | sort -n | tail -n 1
