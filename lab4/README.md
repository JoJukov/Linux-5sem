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
