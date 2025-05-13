#!/bin/bash

# Remove existing file
rm -rf *.cdl *.nc

# Copy files from source folder
cp ./source/input1.nc input1.nc
cp ./source/input2.nc input2.nc

# Concatenate along ID using NCO
for fl in `ls input*.nc`; do # Loop over input files
    # Leave station as the only record dimension
    ncks -O --fix_rec_dmn time $fl $fl
    ncks -O --mk_rec_dmn seg $fl $fl
done
ncrcat -O input*.nc output.nc # Concatenate along the ID dimension

# Print values
echo "A sample of variable: DWroutedRunoff | File: input1.nc"
ncdump -v DWroutedRunoff input1.nc | sed -n '/DWroutedRunoff =/,/;/p' | sed '1d;$d' | head -n 10
echo "A sample of variable: DWroutedRunoff | File: output.nc"
ncdump -v DWroutedRunoff output.nc | sed -n '/DWroutedRunoff =/,/;/p' | sed '1d;$d' | head -n 10
