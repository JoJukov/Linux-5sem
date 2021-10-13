# 1
```shell
test="$HOME/test"
mkdir $test 2> /dev/null
```

# 2
```shell
list="$test/list"
dirs=0
files=0
touch $list 2> /dev/null
echo > $list
for file in $(ls -aA /etc); do
	if [ -d "/etc/$file" ]; then
		echo "directory: $file" >> "$list"
		let dirs++
	elif [ -f "/etc/$file" ]; then
		echo "file: $file" >> "$list"
		let files++
	fi
done
```

# 3
```shell
echo "$dirs $files" >> "$list"
```

# 4
```shell
links="$test/links"
mkdir $links 2> /dev/null
```

# 5
```shell
rm $links/list_hlink 2> /dev/null
ln -P $list "$links/list_hlink" 2> /dev/null
```

# 6
```shell
rm $links/list_slink 2> /dev/null
ln -s $list "$links/list_slink" 2> /dev/null
```

# 7
```shell
echo "hard links in $links/list_hlink - $(stat -c %h $links/list_hlink)"
echo "hard links in $list - $(stat -c %h $list)"
echo "hard links in $links/list_slink - $(stat -c %h $links/list_slink)"
```

# 8
```shell
cat $list | wc -l >> $links/list_hlink
```

# 9
```shell
if cmp -s $list $links/list_hlink; then
	echo "9. YES"
else
	echo "9. NO"
fi
```

# 10
```shell
mv $list ${list}1
```

# 11
```shell
if cmp -s $links/list_slink $links/list_hlink; then
	echo "11. YES"
else
	echo "11. NO"
fi
```

# 12
```shell
rm $HOME/list1 2> /dev/null
ln -P $links/list_hlink $HOME/list1 2> /dev/null
```

# 13
```shell
find /etc -type f -iname "*.conf" > $HOME/list_conf
```

# 14
```shell
find /etc -type d -iname "*.d" > $HOME/list_d
```

# 15
```shell
cat $HOME/list_conf $HOME/list_d > $HOME/list_conf_d
```

# 16
```shell
mkdir $test/.sub 2> /dev/null
```

# 17
```shell
cp $HOME/list_conf_d $test/.sub 2> /dev/null
```

# 18
```shell
cp --backup=t $HOME/list_conf_d $test/.sub
```

# 19
```shell
ls -laAR $test
```

# 20
```shell
man man > $HOME/man.txt
```

# 21
```shell
split -b 1k $HOME/man.txt $test/splited_man-
```

# 22
```shell
mkdir $test/man.dir 2> /dev/null
```

# 23
```shell
mv $test/splited_man-* $test/man.dir
```

# 24
```shell
cat $test/man.dir/splited_man-* > $test/man.dir/man.txt
```

# 25
```shell
if cmp -s $test/man.dir/man.txt $HOME/man.txt; then
	echo "25. YES"
else
	echo "25. NO"
fi
```

# 26
```shell
echo "$RANDOM\n$(cat $HOME/man.txt)$RANDOM\n" > $HOME/man.txt
```

# 27
```shell
diff -u $HOME/man.txt $test/man.dir/man.txt > $HOME/man.diff
```

# 28
```shell
mv $HOME/man.diff $test/man.dir
```

# 29
```shell
patch -R  $test/man.dir/man.txt $test/man.dir/man.diff
```

# 30
```shell
if cmp -s $HOME/man.txt $test/man.dir/man.txt; then
	echo "30. YES"
else
	echo "30. NO"
fi
```
# script1.sh output
```
hard links in /root/test/links/list_hlink - 2
hard links in /root/test/list - 2
hard links in /root/test/links/list_slink - 1
9. YES
11. NO
total 16
drwxr-xr-x. 2 root root 4096 Oct 10 22:52 .sub
drwxr-xr-x. 2 root root 4096 Oct 10 20:57 man.dir
-rw-r--r--. 3 root root 3953 Oct 10 22:52 list1
drwxr-xr-x. 2 root root 4096 Oct 10 22:52 links
25. YES
patching file /root/test/man.dir/man.txt
30. YES
```


Защита:
Найти в системе самый самый удаленный файл, если их несколько - вывести все. переделать луп в строчку
