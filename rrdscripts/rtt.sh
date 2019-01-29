# monitor RTT to several destinations

iplist="www.google.com"

which netstat >/dev/null
res_netstat=$?
which ip >/dev/null
res_ip=$?

gw4=
if test $res_netstat -eq 0 ; then
   gw4=$(netstat -nr4 | grep -E "^default|^0.0.0.0" | tr -s \  | cut -d \  -f 2)
#   gw6=$( netstat -nr6 | grep -E "^default|^::/0" | grep UG  | grep -v fe80 | tr -s \  | cut -d \  -f 2)
elif test $res_ip -eq 0 ; then
   gw4=$(ip route | grep -E ^default | cut -d \  -f 3)
fi

iplist="$gw4 $iplist"

RRDDATA=

for ip in $iplist
do
   rtts=$(ping -c 1 $ip | grep from)
   if test -n "$rtts" ; then
      rtt=$(echo ${rtts##*time=} | cut -d \  -f 1)
      RRDDATA="$RRDDATA $ip:$rtt"
   fi
done

