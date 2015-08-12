#!/bin/bash

# ns lookup-scan of IP-range inside a subnet

echo -ne 'Enter start IP: '
read start
echo -ne 'Enter end IP: '
read end

first=$(echo $start | cut -d "." -f4)
last=$(echo $end | cut -d "." -f4)

IPRange="$first $last"
for addr in $(seq $IPRange); do
  echo "${addr} == `nslookup ${addr} | awk -F "=" '{ print $2 }'|sed 's/^[ t]*//' | sed '/^$/d' | sed 's/.$//'`"
done
