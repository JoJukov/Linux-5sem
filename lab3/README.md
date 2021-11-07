# 1

```shell
cat /etc/passwd | awk -F: '{printf("user %s has if %s\n", $1, $3)}' > work3.log
```
# 2

```shell
passwd -S root | tail -n1 | awk '{print $3}' >> work3.log
```
# 3 
```shell
cat /etc/group | awk -F: '{printf ("%s, ", $1)}' >> work3.log
```

# 4
```shell
echo "Be careful!" > /etc/skel/readme.txt
```

# 5
```shell
useradd u1 -p 12345678
```

# 6
```shell
groupadd g1
```

# 7
```shell
usermod -G g1 u1
```

# 8 
```shell
id u1 >> work3.log
```

# 9
```shell
usermod -G g1 user
```

# 10
```shell
cat /etc/group | grep "^g1:*" | awk -F: '{print $4}' >> work3.log
```
# 11
```shell
usermod -s /usr/bin/mc u1
```
# 12
```shell
useradd u2 -p 87654321
```

# 13
```shell
mkdir /home/test13
cp work3.log /home/test13/work3-1.log
cp work3.log /home/test13/work3-2.log
```

# 14
```shell
chown -R u1:u2 /home/test13
chmod -R 640 /home/test13
```

<details>
<summary>ls -l /home/test13</summary>

```shell
total 8
-rw-r-----. 1 u1 u2 1257 Nov  7 04:22 work3-1.log
-rw-r-----. 1 u1 u2 1257 Nov  7 04:23 work3-2.log
```

</details>

# 15

```shell
mkdir /home/test14
chown u1:g1 -R /home/test14
chmod +t /home/test14
chmod 222 /home/test14
```

# 16

```shell
cp /usr/bin/nano /home/test14
chown u1 /home/test14/nano
chmod u+s /home/test14/nano
```


