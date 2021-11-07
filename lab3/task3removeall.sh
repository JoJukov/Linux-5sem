#!/usr/bin/env bash

rm work3.log
rm -rf /home/test1*
userdel -rf u1
userdel -rf u2
groupdel g1
rm -f /etc/skel/readme.txt

