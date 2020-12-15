# Building the electric field around DNA

The python script 'build\_grids\_dna.py' will use the Parmed package to edit the forcefield of DNA system (make sure you are using a correctly oriented one see: 'align\_dna\_to\_axis).

The script provided here is an example for creating a positive-x direction electric field at 10^9 V/m.
Feel free to uncomment out/edit to use the script to loop over multiple replicas.

The python script will generate new structures and AMBER forcefield files that will be ready for subsequent QM/MM optimisation. To run these simulations, head over to 'field/pos\_x\_9/rep\_101'. The DNA electric field forcefield files will be in 'initial\_struc'.
