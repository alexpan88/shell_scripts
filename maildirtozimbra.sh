#!/bin/bash

# Maildir to Zimbra import
#
# Put the script inside the domain's Maildir folder.
#

echo -ne 'Enter the domain name: '
read domain

for user in `ls -d1 */|sed s/\\\///`
do
echo
echo "User $user"
echo
#
#
find $user -maxdepth 10 -type d -name cur | awk '{ print length($0),$0 | "sort -n"}' | while read line;
do
line=`echo $line | sed -e 's/^[0123456789]*[[:space:]]//'`
folder=`echo ${line}|cut -f3 -d"/"|sed s/\\\.//`
newfolder=$( echo $folder|sed 's/[.]/\//g')

line2=`echo ${line/%cur/new}`

echo "FOLDER $folder"
if [ "$folder" = "cur" ]
then
echo "Transferring inbox..."
/opt/zimbra/bin/zmmailbox -z -m $user@$domain addMessage Inbox $PWD/$user/Maildir/cur
/opt/zimbra/bin/zmmailbox -z -m $user@$domain addMessage Inbox $PWD/$user/Maildir/new
echo "Finished transferring inbox."
else
if [ "$folder" != "Sent" ] && [ "$folder" != "Drafts" ] && [ "$folder" != "Junk" ] && [ "$folder" != "Trash" ]
then
echo "Creating folder '/$newfolder'..."
/opt/zimbra/bin/zmmailbox -z -m $user@$domain createFolder "/$newfolder"
echo "Finished creating folder."
fi
/opt/zimbra/bin/zmmailbox -z -m $user@$domain addMessage "/$newfolder" "${PWD}/${line}"
/opt/zimbra/bin/zmmailbox -z -m $user@$domain addMessage "/$newfolder" "${PWD}/${line2}"
fi

done
done