#!/usr/bin/env bash

cat /etc/passwd | awk -F: '{printf("user %s has if %s\n", $1, $3)}' > work3.log

passwd -S root | tail -n1 | awk '{print $3}' >> work3.log

cat /etc/group | awk -F: '{printf ("%s, ", $1)}' >> work3.log

echo "Be careful!" > /etc/skel/readme.txt

useradd u1 -p 12345678

groupadd g1

usermod -G g1 u1

id u1 >> work3.log

usermod -G g1 user

cat /etc/group | grep "^g1:*" | awk -F: '{print $4}' >> work3.log

usermod -s /usr/bin/mc u1

useradd u2 -p 87654321

mkdir /home/test13
cp work3.log /home/test13/work3-1.log
cp work3.log /home/test13/work3-2.log

chown -R u1:u2 /home/test13
chmod -R 640 /home/test13

mkdir /home/test14
chown u1:g1 -R /home/test14
chmod +t /home/test14
chmod 222 /home/test14

cp /usr/bin/nano /home/test14
chown u1 /home/test14/nano
chmod u+s /home/test14/nano

mkdir /home/test15
echo "ABOBA" > /home/test15/secret_file
chmod a-r /home/test15
chmod a+r /home/test15/secret_file

rm work3.log
rm -rf /home/test1*
userdel -rf u1
userdel -rf u2
groupdel g1
rm -f /etc/skel/readme.txt
