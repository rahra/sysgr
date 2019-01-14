# gather network statistics (in/out bytes)

# find ethernet interface(s)
if test $(uname -o) = FreeBSD ; then
   iflist=$(netstat -i -n | grep -E ^e | cut -d \  -f 1 | uniq)
else
   iflist=$(ls /sys/class/net | grep -E ^e)
fi

RRDVLABEL="Netstats"
RRDVTYPE=COUNTER
RRDDATA=

# loop over all interfaces (listed in iflist)
for if in $iflist
do
   if test $(uname -o) = FreeBSD ; then

      # on FreeBSD do:
      tr4=$(netstat -I $if -n -b -4 | grep $if | grep -v fe80 | tr -s \  )
      tr6=$(netstat -I $if -n -b -6 | grep $if | grep -v fe80 | tr -s \  )

      RRDDATA="$RRDDATA ${if}_in4:$(echo "$tr4" | cut -d \  -f 8) ${if}_out4:$(echo "$tr4" | cut -d \  -f 11) ${if}_in6:$(echo "$tr6" | cut -d \  -f 8) ${if}_out6:$(echo "$tr6" | cut -d \  -f 11)"

   else

      # on other OSes (like Linux) do:
      RRDDATA="$RRDDATA ${if}_in:$(cat /sys/class/net/$if/statistics/rx_bytes) ${if}_out:$(cat /sys/class/net/$if/statistics/tx_bytes)"
   fi
done

