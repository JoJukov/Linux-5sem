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

# 9

```shell
wget https://www.nano-editor.org/dist/v5/nano-5.4.tar.xz
tar -xvf nano-5.4.tar.xz
cd nano-5.4
./configure --prefix=/usr/ --program=new
make
makeinstall
```

# Задание на защиту

написать скрипт который раз в 10 минут выводит пользователю какое то сообщение, упаковать его в пакет, показать конфигурацию пакета

## Решение:
Install tools
```shell
yum install rpmdevtools rpmlint
```

Create package structure
```shell
rpmdev-setuptree
```

Create script
```shell
cd ~/rpmbuild
mkdir amogus-0.0.1 && cd amogus-0.0.1
nano amogus.sh
```
Create package
```shell
cd ../
tar -cf amogus-0.0.1.tar.gz amogus-0.0.1
mv amogus-0.0.1.tar.gz SOURCES/

cd SPECS
rpmdev-newspec amogus
```
Edit `.spec` file
```diff
2c2
< Version:        0.0.1
---
> Version:        
4,5c4
< Summary:        Amogus Amogus
< BuildArch:	noarch
---
> Summary:        
7,8c6,8
< License:        GPL
< Source0:        %{name}-%{version}.tar.gz
---
> License:        
> URL:            
> Source0:        
10c10,11
< Requires:       bash
---
> BuildRequires:  
> Requires:       
13c14
< Amogus Amogus Amogus
---
> 
16c17,23
< %setup -q
---
> %autosetup
> 
> 
> %build
> %configure
> %make_build
> 
20,21c27
< mkdir -p $RPM_BUILD_ROOT/%{_bindir}
< cp %{name}.sh $RPM_BUILD_ROOT/%{_bindir}
---
> %make_install
23,24d28
< %clean
< rm -rf $RPM_BUILD_ROOT
27c31,33
< %{_bindir}/%{name}.sh
---
> %license add-license-file-here
> %doc add-docs-here
> 
32c38
< - Aamoogus 
---
> - 
```

Build package
```shell
rpmbuild -bb ~/rpmbuild/SPECS/amogus.spec
```

Install and run package
```shell
yum install ~/rpmbuild/RPMS/noarch/amogus-0.0.1-1.el8.noarch.rpm
amogus.sh
```

Package info
```shell
rpm -qi amogus
```
```
Name        : amogus
Version     : 0.0.1
Release     : 1.el8
Architecture: noarch
Install Date: Sun 14 Nov 2021 09:31:27 AM MSK
Group       : Unspecified
Size        : 74
License     : GPL
Signature   : (none)
Source RPM  : amogus-0.0.1-1.el8.src.rpm
Build Date  : Sun 14 Nov 2021 09:30:05 AM MSK
Build Host  : localhost
Relocations : (not relocatable)
Summary     : Amogus Amogus
Description :
Amogus Amogus Amogus
```
