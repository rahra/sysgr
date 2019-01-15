# monitor RTT to several destinations

iplist="www.google.com"

RRDDATA=

for ip in $iplist
do
   rtts=$(ping -c 1 $ip | grep from)
   if test -n "$rtts" ; then
      rtt=$(echo ${rtts##*time=} | cut -d \  -f 1)
      RRDDATA="$RRDDATA $ip:$rtt"
   fi
done

