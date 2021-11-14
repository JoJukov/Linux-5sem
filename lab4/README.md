# 1

``` shell
yum group install  'Development Tools'
```

# 2

```shell
mkdir bastet
tar -xvzf bastet-0.43.tgz -C bastet
yum install boost-devel ncutses-devel
make
nano Makefile
```

<details>
<summary>меняем Makefile чтобы он стал таким: cat Makefile</summary>

```shell

SOURCES=Ui.cpp main.cpp Block.cpp Well.cpp BlockPosition.cpp Config.cpp BlockChooser.cpp BastetBlockChooser.cpp
PROGNAME=bastet
LDFLAGS+=-lncurses
#CXXFLAGS+=-ggdb -Wall
CXXFLAGS+=-DNDEBUG -Wall
#CXXFLAGS+=-pg
#LDFLAGS+=-pg

all: $(PROGNAME)

depend: *.hpp $(SOURCES)
	$(CXX) -MM $(SOURCES) > depend

include depend

$(PROGNAME): $(SOURCES:.cpp=.o)
	$(CXX) -ggdb -o $(PROGNAME) $(SOURCES:.cpp=.o) $(LDFLAGS) -lboost_program_options

clean:
	rm -f $(SOURCES:.cpp=.o) $(PROGNAME)

mrproper: clean
	rm -f *~

install:
	cp $(PROGNAME) /usr/bin
	chmod a+x /usr/bin/$(PROGNAME)
```
</details>


```shell
make install
```

# 3

```shell
yum list install > task3.log
```

# 4

```shell
yum deplist gcc | grep 'dependency' | awk '{print $2}' > task4_1.log
repoquery -q --installed -whatrequires libgcc > task4_2.log
```

# 5

```shell
mkdir $HOME/localrepo
cp checkinstall-1.6.2-3.el6.1.x86_64.rpm $HOME/localrepo
createrepo $HOME/localrepo
```

<details>
<summary>создадим и запишем в файл /etc/yum.repos.d/localrepo.repo</summary>

```shell
[localrepo]
name=localrepo
baseurl=file://root/localrepo/
enabled=1
gpgcheck=0
```

</details>

# 6

```shell
yum repolist all > task6.log
```

# 7

```shell
cd /etc/yum.repos.d
ls | xargs -i mv {} {}.aboba
mv localrepo.repo.aboba localrepo.repo
yum update
```

<details>
<summary>output</summary>

```shell
Last metadata expiration check: 0:19:13 ago on Sun 14 Nov 2021 06:29:55 AM MSK.
Dependencies resolved.
Nothing to do.
Complete!
```

</details>

```shell
yum list available
```

<details>
<summary>output</summary>

```shell
Last metadata expiration check: 0:20:43 ago on Sun 14 Nov 2021 06:29:55 AM MSK.
Available Packages
checkinstall.x86_64                   1.6.2-3.el6.1                    localrepo
```

</details>

```shell
yum install checkinstall
for f in $(ls); do mv "$f" "${f%.aboba}"; done
```
# 8

```shell
cp fortunes-ru _1.52-2_all.deb $HOME
```

<details>
<summary>поставим алиен</summary>

```shell
wget -c https://sourceforge.net/projects/alien-pkg-convert/files/release/alien_8.95.tar.xz
tar xf alient_8.95.tar.xz
dnf install perl
cd alien_8.95.tar.xz
perl Makefile.PL; make; make install
```

</details>

```shell
cd $HOME
alien --to-rpm fortunes-ru_1.52-2_all.deb
rpm -i --replacefiles fortunes-ru-1.52-3.noarch.rpm
```

<details>
<summary>ls</summary>

```shell
anaconda-ks.cfg
bastet
fortunes-ru_1.52-2_all.deb
fortunes-ru-1.52-3.noarch.rpm
Linux-5sem
localrepo
rpmbuild
```

</details>
