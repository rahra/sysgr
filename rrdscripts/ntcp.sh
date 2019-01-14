# gather number of established TCP sessions
RRDDATA=ntcp:$(netstat -na | grep ESTA | wc -l | tr -d \ )
RRDVLABEL="ntcp"

