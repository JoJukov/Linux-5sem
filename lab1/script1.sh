#!/usr/bin/env sh

#1
test="$HOME/test"
mkdir $test 2> /dev/null

#2
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

#3
echo "$dirs $files" >> "$list"

#4
links="$test/links"
mkdir $links 2> /dev/null

#5
rm $links/list_hlink 2> /dev/null
ln -P $list "$links/list_hlink" 2> /dev/null

#6
rm $links/list_slink 2> /dev/null
ln -s $list "$links/list_slink" 2> /dev/null

#7
echo "hard links in $links/list_hlink - $(stat -c %h $links/list_hlink)"
echo "hard links in $list - $(stat -c %h $list)"
echo "hard links in $links/list_slink - $(stat -c %h $links/list_slink)"

#8
cat $list | wc -l >> $links/list_hlink

#9
if cmp -s $list $links/list_hlink; then
	echo "9. YES"
else
	echo "9. NO"
fi

#10
mv $list ${list}1

#11
if cmp -s $links/list_slink $links/list_hlink; then
	echo "11. YES"
else
	echo "11. NO"
fi

#12
rm $HOME/list1 2> /dev/null
ln -P $links/list_hlink $HOME/list1 2> /dev/null

#13
find /etc -type f -iname "*.conf" > $HOME/list_conf

#14
find /etc -type d -iname "*.d" > $HOME/list_d

#15
cat $HOME/list_conf $HOME/list_d > $HOME/list_conf_d

#16
mkdir $test/.sub 2> /dev/null

#17
cp $HOME/list_conf_d $test/.sub 2> /dev/null

#18
cp --backup=t $HOME/list_conf_d $test/.sub

#19
ls -laAr $test

#20
man man > $HOME/man.txt

#21
split -b 1k $HOME/man.txt $test/splited_man-

#22
mkdir $test/man.dir 2> /dev/null

#23
mv $test/splited_man-* $test/man.dir

#24
cat $test/man.dir/splited_man-* > $test/man.dir/man.txt

#25
if cmp -s $test/man.dir/man.txt $HOME/man.txt; then
	echo "25. YES"
else
	echo "25. NO"
fi

#26
echo "$RANDOM\n$(cat $HOME/man.txt)$RANDOM\n" > $HOME/man.txt

#27
diff -u $HOME/man.txt $test/man.dir/man.txt > $HOME/man.diff

#28
mv $HOME/man.diff $test/man.dir

#29
patch -R  $test/man.dir/man.txt $test/man.dir/man.diff

#30
if cmp -s $HOME/man.txt $test/man.dir/man.txt; then
	echo "30. YES"
else
	echo "30. NO"
fi

