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
