
if test $(uname -o) != "FreeBSD" ; then
   exit 0
fi

i=0
for e in $(top |grep -Em2 '^(Mem|Swap):' | tr -d ,K | perl -pe 's/M/000/g')
do
   eval e_$i=$e
   i=$(( $i + 1 ))
done

RRDDATA="active:$e_1 inactive:$e_3 laundry:$e_5 wired:$e_7 buf:$e_9 free:$e_11 swap_used:$e_16 swap_free:$e_18"
RRDVLABEL="memory"
RRDOPTIONS=

