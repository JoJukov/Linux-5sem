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
