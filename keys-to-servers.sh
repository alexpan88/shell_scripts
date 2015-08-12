#!/bin/bash
#This script appends an rsa key to authorized_keys remotely
servers=( server1 server2 server3 )

echo -ne 'Enter the system user to add the key: '
read user
echo -ne 'Enter the key'\''s owner name: '
read name
echo -ne 'Enter the key: '
read key

for server in "${servers[@]}"
do
echo "Copying to key ${server}..."
echo '#' $name | ssh root@${server} "cat >> /home/$user/.ssh/authorized_keys"
echo -n $key | ssh root@${server} "cat >> /home/$user/.ssh/authorized_keys"
done
