# 1
```shell
sudo fdisk /dev/sda | tee -a README.md
```

<details>
<summary>Console output</summary>

```shell
Welcome to fdisk (util-linux 2.32.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): Partition type
   p   primary (2 primary, 0 extended, 2 free)
   e   extended (container for logical partitions)
Select (default p): 
Using default response p.
Partition number (3,4, default 3):
First sector (14551040-16777215, default 14551040):
Last sector, +sectors or +size{K,M,G,T,P} (14551040-16777215, default 16777215): +300M
Created a new partition 3 of type 'Linux' and of size 300 MiB.

Command (m for help): The partition table has been altered.
Syncing disks.
```
</details>

# 2
```shell
blkid -s UUID -o value \dev\sda3
```

# 3
```shell
mkfs -t ext4 -b 4096 /dev/sda3
```

<details>
<summary>
blkid -s TYPE /dev/sda3
</summary>
   
```shell
/dev/sda3: TYPE="ext4"
```
</details>

# 4
```shell
dumpe2fs -h /dev/sda3
```
<details>
<summary>
Console output
</summary>
 
```shell
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          46038062-225f-41ba-8189-ea99f4d1cd91
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype extent 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize metadata_csum
Filesystem flags:         signed_directory_hash 
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              76800
Block count:              76800
Reserved block count:     3840
Free blocks:              70214
Free inodes:              76789
First block:              0
Block size:               4096
Fragment size:            4096
Group descriptor size:    64
Reserved GDT blocks:      37
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         25600
Inode blocks per group:   800
Flex block group size:    16
Filesystem created:       Wed Oct 20 02:04:10 2021
Last mount time:          n/a
Last write time:          Wed Oct 20 02:04:10 2021
Mount count:              0
Maximum mount count:      -1
Last checked:             Wed Oct 20 02:04:10 2021
Check interval:           0 (<none>)
Lifetime writes:          173 kB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:	          128
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      3d4ce888-06a1-482f-a301-d3297fb2bd81
Journal backup:           inode blocks
Checksum type:            crc32c
Checksum:                 0xaca78bf3
Journal features:         (none)
Journal size:             16M
Journal length:           4096
Journal sequence:         0x00000001
Journal start:            0
```
</details>

# 5
```shell
tune2fs -c 2 -i 2m /dev/sda3
```

<details>
<summary>Console output</summary>

```shell
tune2fs 1.45.6 (20-Mar-2020)
Setting maximal mount count to 2
Setting interval between checks to 5184000 seconds
```
</details>

# 6
```shell
mkdir /mnt/newdisk
mount /dev/sda3 /mnt/newdisk
```

<details>
<summary>mount -t ext4</summary>

```shell
/dev/mapper/cl-root on / type ext4 (rw,relatime,seclabel)
/dev/sda1 on /boot type ext4 (rw,relatime,seclabel)
/dev/sda3 on /mnt/newdisk type ext4 (rw,relatime,seclabel)
```
</details>

# 7
```shell
ln -s /mnt/newdisk $HOME/newfslink
```

# 8
```shell
mkdir $HOME/newfslink/aboba
```
# 9
```shell
nano /etc/fstab
```
:arrow_down:

```shell
/dev/sda3 /mnt/newdisk ext4 noexec,noatime 0 0 
```

:arrow_down:

```shell
reboot
```

# 10
<details>
<summary>
<strong>Before:</strong> df -h /dev/sda3
</summary>

```shell
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda3       275M  328K  254M   1% /mnt/newdisk
```
</details>

```shell
umount /dev/sda3
fdisk /dev/sda
```
 
In console:

```shell
Welcome to fdisk (util-linux 2.32.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): d
Partition number (1-3, default 3): 
Partition 3 has been deleted.

Command (m for help):
Partition type
   p   primary (2 primary, 0 extended, 2 free)
   e   extended (container for logical partitions)
Select (default p): 

Using default response p.
Partition number (3,4, default 3): 
First sector (14551040-16777215, default 14551040): 
Last sector, +sectors or +size{K,M,G,T,P} (14551040-16777215, default 16777215): +350M
 
Created a new partition 3 of type 'Linux' and of size 350 MiB.

Do you want to remove the signature? [Y]es/[N]o: N
Command (m for help): w
The partition table has been altered.
Syncing disks.
```

```shell
e2fsck -f /dev/sda3
resize2fs /dev/sda3
```

<details>
<summary>
<strong>After:</strong> df -h /dev/sda3
</summary>

```shell
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda3       325M  328K  300M   1% /mnt/newdisk
```
</details>

# 11

```shell
fsck -N /dev/sda3
```

<details>
<summary>Console output</summary>

```shell
fsck from util-linux 2.32.1
Warning!  /dev/sda3 is mounted.
Warning: skipping journal recovery because doing a read-only filesystem check.
/dev/sda3 has been mounted 2 times without being checked, check forced.
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
/dev/sda3: 12/76800 files (0.0% non-contiguous), 6588/89600 blocks
```
</details>

# 12

```shell
fdisk /dev/sda
```

<details>
<summary>Console output</summary>

```shell
Welcome to fdisk (util-linux 2.32.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): Partition type
   p   primary (3 primary, 0 extended, 1 free)
   e   extended (container for logical partitions)
Select (default e): p 
Selected partition 4
First sector (15267840-16777215, default 15267840): 
Last sector, +sectors or +size{K,M,G,T,P} (15267840-16777215, default 16777215): +12M

Created a new partition 4 of type 'Linux' and of size 12 MiB.

Command (m for help): w
The partition table has been altered.
Syncing disks.
```
</details>

```shell
mke2fs -O journal_dev - 4096 /dev/sda4
tune2fs -j -J device=/dev/sda4
```

# 13

```shell
fdisk /dev/sdb
```

<details>
<summary>Console output</summary>

```shell
Welcome to fdisk (util-linux 2.32.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0xeec1d54c.

Command (m for help): Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): 
Partition number (1-4, default 1): 
First sector (2048-16777215, default 2048): 
Last sector, +sectors or +size{K,M,G,T,P} (2048-16777215, default 16777215): +100M
Created a new partition 1 of type 'Linux' and of size 100 MiB.

Command (m for help): Partition type
   p   primary (1 primary, 0 extended, 3 free)
   e   extended (container for logical partitions)
Select (default p): 
Partition number (2-4, default 2): 
First sector (206848-16777215, default 206848): 
Last sector, +sectors or +size{K,M,G,T,P} (206848-16777215, default 16777215): +100M 
Created a new partition 2 of type 'Linux' and of size 100 MiB.

Command (m for help): The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.
```
</details>

```shell
mkfs.ext4 /dev/sbd1
mkfs.ext4 /dev/sdb2
```

# 14
```shell
mkdir /mnt/supernewdisk
pvcreate /dev/sbd1 /dev/sdb2
```

<details>
<summary>pvscan output</summary>

```shell
 PV /dev/sda2   VG cl              lvm2 [5.93 GiB / 0    free]
 PV /dev/sdb1                      lvm2 [100.00 MiB]
 PV /dev/sdb2                      lvm2 [100.00 MiB]
 Total: 3 [<6.13 GiB] / in use: 1 [5.93 GiB] / in no VG: 2 [200.00 MiB]
```
</details>

```shell
vgcreate vol_grp1 /dev/sdb1 /dev/sdb2
```

<details>
<summary>vgdisplay output</summary>

```shell
  --- Volume group ---
  VG Name               vol_grp1
  System ID             
  Format                lvm2
  Metadata Areas        2
  Metadata Sequence No  1
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                0
  Open LV               0
  Max PV                0
  Cur PV                2
  Act PV                2
  VG Size               192.00 MiB
  PE Size               4.00 MiB
  Total PE              48
  Alloc PE / Size       0 / 0   
  Free  PE / Size       48 / 192.00 MiB
  VG UUID               yKMc8N-coAk-DlgD-I4jq-QPxa-MUNI-QGzK4F
   
  --- Volume group ---
  VG Name               cl
  System ID             
  Format                lvm2
  Metadata Areas        1
  Metadata Sequence No  4
  VG Access             read/write
  VG Status             resizable
  MAX LV                0
  Cur LV                3
  Open LV               3
  Max PV                0
  Cur PV                1
  Act PV                1
  VG Size               5.93 GiB
  PE Size               4.00 MiB
  Total PE              1519
  Alloc PE / Size       1519 / 5.93 GiB
  Free  PE / Size       0 / 0   
  VG UUID               L4T8Cd-XEPs-Vb06-d01o-sIlo-ryLl-sML1Y1
```
</details>

```shell   
lvcreate -L 192M -n logical_vol1 vol_grp1
```

<details>
<summary>lvdiplay output</summary>

```shell
  --- Logical volume ---
  LV Path                /dev/vol_grp1/logical_vol1
  LV Name                logical_vol1
  VG Name                vol_grp1
  LV UUID                cNhond-oo3L-V5i4-736F-bnPb-3ldo-UBQwLk
  LV Write Access        read/write
  LV Creation host, time localhost.localdomain, 2021-10-24 21:24:37 +0300
  LV Status              available
  # open                 0
  LV Size                192.00 MiB
  Current LE             48
  Segments               2
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:3
   
  --- Logical volume ---
  LV Path                /dev/cl/root
  LV Name                root
  VG Name                cl
  LV UUID                ONhRrF-8ckQ-rfKq-AmW4-Qnlj-3c2k-xq1cvc
  LV Write Access        read/write
  LV Creation host, time localhost, 2020-08-28 00:12:13 +0300
  LV Status              available
  # open                 1
  LV Size                <4.20 GiB
  Current LE             1075
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:0
   
  --- Logical volume ---
  LV Path                /dev/cl/swap
  LV Name                swap
  VG Name                cl
  LV UUID                CrR5n1-mSFc-kBoB-xUDE-qaQv-TGt3-eaDVy3
  LV Write Access        read/write
  LV Creation host, time localhost, 2020-08-28 00:12:14 +0300
  LV Status              available
  # open                 2
  LV Size                820.00 MiB
  Current LE             205
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:1
   
  --- Logical volume ---
  LV Path                /dev/cl/home
  LV Name                home
  VG Name                cl
  LV UUID                1Bfa7i-7Ykq-r1Sx-4q9X-4mct-YWSt-ZAQQs1
  LV Write Access        read/write
  LV Creation host, time localhost, 2020-08-28 00:12:14 +0300
  LV Status              available
  # open                 1
  LV Size                956.00 MiB
  Current LE             239
  Segments               1
  Allocation             inherit
  Read ahead sectors     auto
  - currently set to     8192
  Block device           253:2
```

</details>   

```shell
mkfs.ext4 /dev/vol_grp1/logical_vol1
mount /dev/vol_grp1/logical_vol1 /mnt/supernewdisk
```

# 15
```shell
mkdir /mnt/share
mount.cifs //192.168.43.242/FileShare /mnt/share -o vers=3.0
```

# 16

```shell
nano /etc/fstab
```

:arrow_down:

```shell
//192.168.43.242/FileShare /mnt/share cifs user,rw,password=**** 0 0
```
