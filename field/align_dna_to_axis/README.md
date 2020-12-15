# Aligning DNA

The iPython notebook in this folder shows how the QM/MM optimised DNA structures in the 'no\_field' folder can be oriented and aligned using MDAnalysis.

Run the 'align\_dna\_to\_axis\_example.ipynb' script, to create the relevant oriented DNA configurations 'reac\_opt.pdb, ts1\_opt.pdb, prod\_opt.pdb'.

Then run the tleap script using 'tleap -s -f leap.in' in the respective 'a\_reac', 'b\_ts1', and 'e\_prod' directories to generate the appropriate AMBER .inpcrd and .prmtop files.

The geometries obtained here will then have an electric field built around them in 'field/generating\_e\_field/dna'.
