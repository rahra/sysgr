# measure DNS lookup time
testnames="www.google.com"

which dig >/dev/null
if test $? -ne 0 ; then
   echo "dig utility not found"
   exit
fi

RRDVLABEL="DNS Lookup Time [ms]"

for n in $testnames
do
   RRDDATA="$RRDDATA $n:$(dig $n | grep Query | cut -d \  -f 4)"
done

which openssl >/dev/null
if test $? -eq 0 ; then
   domains="google.com microsoft.com anlx.cloud lab.anlx.cloud"
   randhost=$(head -c 12 /dev/urandom | openssl enc -base64 | tr -d +)
   for n in $domains
   do
      RRDDATA="$RRDDATA RANDOM.$n:$(dig $randhost.$n | grep Query | cut -d \  -f 4 | tr + 1)"
   done
fi

