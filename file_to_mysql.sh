#!/bin/bash

## Executes multiple queries from a file to mysql

echo -ne 'Enter the mysql user: '
read user
echo -ne 'Enter the mysql user'\''s password: '
read -s pass
echo
echo -ne 'Enter the database name: '
read db
echo -ne 'Enter the sql file path: '
read inputfile

while read in
do
  echo "$in" |  mysql -u$user -p$pass $db
done < $inputfile
