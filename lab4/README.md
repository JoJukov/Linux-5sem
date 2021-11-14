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
