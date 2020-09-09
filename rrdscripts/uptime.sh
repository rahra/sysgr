# script to monitor system uptime
# this immediately let's you detect a system reboot

tm=$(uptime | tr -s \  | cut -d \  -f 4)
ts=$(uptime | tr -s \  | cut -d \  -f 5)
td=$(uptime | tr -s \  | cut -d \  -f 3)

if test "$ts" = "min," ; then
   which bc >/dev/null
   if test $? -eq 0 ; then
      tm=$(echo "scale=3;$tm/1440" | bc)
   else
      tm=0
   fi
elif test "$tm" = "days," ; then
   tm=$td
else
   # in case it is neither 'days' nor 'min' but 'hh:mm'
   tm=$(echo $tm | cut -d : -f 1)
   tm=$(echo "scale=3;$tm/24" | bc)
fi

RRDDATA="uptime:$tm"
RRDVLABEL="Uptime [days]"

