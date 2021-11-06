# 1
cat /etc/passwd | awk -F: '{printf("user %s has if %s\n", $1, $3}' > work3.log
