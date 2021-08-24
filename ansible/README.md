# Cluster Maintenance

The following commands can be used to bootstrap and maintain a node in the
homelab cluster.

## Bootstrap

### Install Manjaro
Nodes in this cluster can be bootstrapped with the Manjaro image included in
the adjacent images directory.

If you use this iamge then it'll be all set to join the home network and the
user `paul` is already setup:

```bash
ssh paul@<ip-address>
```

You'll need to configure the node's hostname and expand the rootfs via the
following commands:

```console
$ sudo hostnamectl set-hostname pi-leader-1
$ sudo parted /dev/mmcblk0
GNU Parted 3.4
Using /dev/mmcblk0
Welcome to GNU Parted! Type 'help' to view a list of commands.

(parted) unit chs

(parted) print
Model: SD GE4S5 (sd/mmc)
Disk /dev/mmcblk0: 981754,249,1
Sector size (logical/physical): 512B/512B
BIOS cylinder,head,sector geometry: 981754,255,2.  Each cylinder is 261kB.
Partition Table: msdos
Disk Flags:

Number  Start      End          Type     File system  Flags
 1      122,140,0  980,100,0    primary  fat16        lba
 2      980,100,1  18532,240,1  primary  ext4

(parted) rm 2
Warning: Partition /dev/mmcblk0p2 is being used. Are you sure you want to continue?
Yes/No? y
Error: Partition(s) 2 on /dev/mmcblk0 have been written, but we have been unable to inform the kernel of the change, probably because it/they are in use.  As a
result, the old partition(s) will remain in use.  You should reboot now before making further changes.
Ignore/Cancel? i

(parted) print
Model: SD GE4S5 (sd/mmc)
Disk /dev/mmcblk0: 981754,249,1
Sector size (logical/physical): 512B/512B
BIOS cylinder,head,sector geometry: 981754,255,2.  Each cylinder is 261kB.
Partition Table: msdos
Disk Flags:

Number  Start      End        Type     File system  Flags
 1      122,140,0  980,100,0  primary  fat16        lba

(parted) mkpart primary 980,100,1 981754,249,1
Warning: The resulting partition is not properly aligned for best performance: 500001s % 2048s != 0s
Ignore/Cancel? i

(parted) print
Model: SD GE4S5 (sd/mmc)
Disk /dev/mmcblk0: 981754,249,1
Sector size (logical/physical): 512B/512B
BIOS cylinder,head,sector geometry: 981754,255,2.  Each cylinder is 261kB.
Partition Table: msdos
Disk Flags:

Number  Start      End           Type     File system  Flags
 1      122,140,0  980,100,0     primary  fat16        lba
 2      980,100,1  981754,249,1  primary               lba

(parted) quit
Information: You may need to update /etc/fstab.

$ sudo reboot
Connection to 192.168.7.201 closed by remote host.
Connection to 192.168.7.201 closed.

$ sudo resize2fs /dev/mmcblk0p2
resize2fs 1.46.2 (28-Feb-2021)
Filesystem at /dev/mmcblk0p2 is mounted on /; on-line resizing required
old_desc_blocks = 1, new_desc_blocks = 15
The filesystem on /dev/mmcblk0p2 is now 62524379 (4k) blocks long.
```

### Setting up public key authentication

If you're not using the Manjaro base image we'll have to install the SSH key
used to administer the cluster via:

```bash
ssh-copy-id -i secrets/pi_cluster.key paul@<ip-address>
```

Repeat this step for all your RaspberryPis. Ansible should now be able to login
to your RaspberryPis by ssh without a password.

### Setup Node

#### Install Ansible

```console
$ pyenv activate homelab
$ pip install ansible
```

#### Bootstrap the cluster
If everything is configured you should be able to bootstrap the cluster by
executing the following command:

```console
$ ./bootstrap.sh
```

## Upgrade the cluster

### Upgrading Manjaro system packages

```bash
$ ./upgrade.sh
```

### Deploying applications

This will be handled by Flux as outlined in the root of this repo.
