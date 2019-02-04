# count number of changed log entries in log files

logs="/var/log/messages /var/log/maillog /var/log/mail.log /var/log/kern.log /var/log/syslog"
tmp="/tmp"

RRDDATA=
# loop over all logfiles
for l in $logs
do
   # test if logfile exists
   if test -e $l ; then
      b=$(basename $l)
      c=0
      # test if there is an old copy of the log file
      if test -e $tmp/$b ; then
         # compare the first line of each file to detect logrotation, i.e. it
         # was rotated if they differ.
         l1a=$(head -1 <$l)
         l1b=$(head -1 <$tmp/$b)
         if test "$l1a" = "$l1b" ; then
            c=$(diff $tmp/$b $l | wc -l | tr -d \ )
         fi
      fi
      cp $l $tmp
      RRDDATA="$RRDDATA $b:$c"
   fi
done

