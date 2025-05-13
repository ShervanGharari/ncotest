#!/bin/bash

# Remove existing file
rm -rf *.cdl *.nc

# Create Input1.cdl
cat > InputTest1.cdl <<EOF
netcdf Input1 {
dimensions:
    time = 3 ;
    ID = 2 ;
variables:
    double time(time) ;
        time:units = "days since 2000-01-01 00:00:00" ;
        time:calendar = "standard" ;
    float precipitation(ID, time) ;
    int ID(ID) ;

data:
    time = 0, 1, 2 ;
    ID = 2, 1 ;
    precipitation =
         1.0, 1.1, 1.2,
         2.0, 2.1, 2.2 ;
}
EOF

# Create Input2.cdl
cat > InputTest2.cdl <<EOF
netcdf Input2 {
dimensions:
    time = 3 ;
    ID = 3 ;
variables:
    double time(time) ;
        time:units = "days since 2000-01-01 00:00:00" ;
        time:calendar = "standard" ;
    float precipitation(ID, time) ;
    int ID(ID) ;

data:
    time = 0, 1, 2 ;
    ID = 3, 4, 5 ;
    precipitation =
         3.0, 3.1, 3.2,
         4.0, 4.1, 4.2,
         5.0, 5.1, 5.2 ;
}
EOF

# Convert CDL to NetCDF
ncgen -o InputTest1.nc InputTest1.cdl
ncgen -o InputTest2.nc InputTest2.cdl

# Concatenate along ID using NCO
for fl in `ls InputTest*.nc`; do # Loop over input files
    # Leave station as the only record dimension
    ncks -O --fix_rec_dmn time $fl $fl
    ncks -O --mk_rec_dmn ID $fl $fl
done
ncrcat -O InputTest*.nc OutputTest.nc # Concatenate along the ID dimension
