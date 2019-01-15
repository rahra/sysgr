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

