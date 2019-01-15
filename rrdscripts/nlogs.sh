# count number of changed log entries in log files

logs="/var/log/messages /var/log/maillog /var/log/kern.log /var/log/syslog"
tmp="/tmp"

RRDDATA=
for l in $logs
do
   if test -e $l ; then
      b=$(basename $l)
      c=0
      if test -e $tmp/$b ; then
         c=$(diff $tmp/$b $l | wc -l | tr -d \ )
      fi
      cp $l $tmp
      RRDDATA="$RRDDATA $b:$c"
   fi
done

