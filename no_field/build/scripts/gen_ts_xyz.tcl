# Run in NEB directory
# vmd -dispdev text nebpath.xyz < ../../../build/scripts/gen_ts_xyz.tcl

[atomselect top all frame 13] writexyz ts1.xyz
[atomselect top all frame 20] writexyz ts2.xyz   
[atomselect top all frame 16] writexyz int.xyz   
