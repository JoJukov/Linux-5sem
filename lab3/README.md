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
