# monitor RTT to several destinations

iplist="www.google.com www.microsoft.com www.facebook.com k.root-servers.net www.twitter.com"

which netstat >/dev/null
res_netstat=$?
which ip >/dev/null
res_ip=$?

gw4=
gw6=
if test $res_netstat -eq 0 ; then
   gw4=$(netstat -nr4 | grep -E "^default|^0.0.0.0" | tr -s \  | cut -d \  -f 2)
#   gw6=$( netstat -nr6 | grep -E "^default|^::/0" | grep UG  | grep -v fe80 | tr -s \  | cut -d \  -f 2)
elif test $res_ip -eq 0 ; then
   gw4=$(ip route | grep -E ^default | cut -d \  -f 3)
   gw6=$(ip -6 route | grep -E ^default | cut -d \  -f 3)
fi

ping -4 -c 1 127.0.0.1 >/dev/null 2>/dev/null
if test $? -ne 0 ; then
   PING4=ping
   PING6=ping6
else
   PING4="ping -4"
   PING6="ping -6"
fi

iplist="$gw4 $gw6 $iplist"
res=/tmp/ping.result

RRDDATA=
for ip in $iplist
do
   $PING4 -c 2 $ip >$res 2>/dev/null
   if test $? -eq 0 ; then
      rtts=$(grep from $res | tail -1)
      if test -n "$rtts" ; then
         rtt=$(echo ${rtts##*time=} | cut -d \  -f 1)
         RRDDATA="$RRDDATA IP4-$ip:$rtt"
      fi
   fi

   $PING6 -c 2 $ip >$res 2>/dev/null
   if test $? -eq 0 ; then
      rtts=$(grep from $res | tail -1)
      if test -n "$rtts" ; then
         rtt=$(echo ${rtts##*time=} | cut -d \  -f 1)
         RRDDATA="$RRDDATA IP6-$ip:$rtt"
      fi
   fi
done

