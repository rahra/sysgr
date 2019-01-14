# gather 5 min cpu load
RRDDATA=load:$(uptime | perl -ne 'if(/:.*, (.*),/){print $1;}')
RRDVLABEL=Load
RRDOPTIONS="-u 1"
