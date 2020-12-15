## Select frame from neb to save as initial transition state estimate

## USEAGE:
# Open nebpath.xyz in vmd, then type the following command in terminal
# source save_frame.tcl

[atomselect top all frame 13] writexyz ts1.xyz
[atomselect top all frame 15] writexyz int.xyz
[atomselect top all frame 17] writexyz ts2.xyz

# To save initial TS estimate
