# gather number of running processes
RRDDATA=nprocs:$(ps uax | wc -l | tr -d \ )
RRDVLABEL="nprocs"

