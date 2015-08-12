#!/bin/bash

# run it inside the host you want to check
########## carefull: this is only for security testing ########

echo -ne 'Enter the host to check: '
read host

for port in {1..65535}
do
    echo "" > /dev/tcp/$host/$port && echo "Port $port is open"
done 2>/dev/null

