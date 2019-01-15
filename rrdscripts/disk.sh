# gather usage percentage of all mounted disks
RRDDATA=$(df | grep -E '^/' | tr -s \  | cut -d \  -f 1,5 | tr -d :% | tr \  :)
RRDVLABEL="diskusage"
RRDOPTIONS="-u 100"

