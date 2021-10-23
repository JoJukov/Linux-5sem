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
