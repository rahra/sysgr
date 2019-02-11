# script to monitor system uptime
# this immediately let's you detect a system reboot

tm=$(uptime | tr -s \  | cut -d \  -f 4)
ts=$(uptime | tr -s \  | cut -d \  -f 5)

if test "$ts" = "min," ; then
   which bc >/dev/null
   if test $? -eq 0 ; then
      tm=$(echo "scale=3;$tm/1440" | bc)
   else
      tm=0
   fi
fi

RRDDATA="uptime:$tm"
RRDVLABEL="Uptime [days]"

