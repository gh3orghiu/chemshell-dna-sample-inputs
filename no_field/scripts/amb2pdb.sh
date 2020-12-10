#!/bin/bash

# Type filename as first argument to script

# Will use a matching .prmtop and .incprd to generate an AMBER read-able .pdb in directory

ambpdb -p $1.prmtop < $1.inpcrd > $1.pdb

echo "File $1.pdb written"
