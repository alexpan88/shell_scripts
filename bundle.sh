#!/bin/bash

# as app user
# in every project in /var/www/rails runs in current bundle
# if you want to exclude project -- ls /var/www/rails/ --hide=name_of_project

echo "###################################################################################"
echo "Bundle is started"
echo "###################################################################################"

for D in $(ls /var/www/rails/)
do
    echo "Running bundle for {$D}"
    if [ -d $D/current ]
    then
       cd $D/current && bundle && cd ../..
       echo "Bundle is finished for the $D project"
    fi
done

echo "###################################################################################"
echo "Bundle is finished"
echo "###################################################################################"
