#!/usr/bin/env sh

max_depth=`find /root -depth -type f -printf '%d\n' | sort -g -r | head -n1`
find /root -depth -mindepth $max_depth -type f >> README.md

