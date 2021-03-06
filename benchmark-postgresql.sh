#!/bin/bash -e
host="$1"
user="$2"
passwd="$3"
benchmark="$4"
n=100

if [ $# -lt 3 ]; then echo "Usage $0 <host> <user> <password> [benchmark] [count]"; exit 2; fi
if [ -n "$5" ] ; then n=$5 ; fi

while read name sql
do
  if [[ "$name" =~ "#" ]] ; then continue ; fi
  if [[ "$benchmark" != "" && "$name" != "$benchmark" ]] ; then continue ; fi
  for i in $(seq 1 $n) ; do 
    t=$(( time -p ( PGPASSWORD=$passwd psql -h $host -p 5432 -d db-PPCIC-rsalles -U $user -a -c "$sql" ) 2>&1 ) | grep real | sed -e 's/real *//')
    echo "$name	$t"
  done
done < queries-postgresql.sql
