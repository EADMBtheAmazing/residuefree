#!/bin/sh

# Copyright: Bernd Schubert <bernd.schubert@fastmail.fm>
# BSD license, see LICENSE file for details

#last line currently works


FUSE_OPT="-o allow_other,use_ino,suid,dev,nonempty"
CHROOT_PATH="/tmp/unionfs"
UNION_OPT="-ocow,chroot=$CHROOT_PATH,max_files=32768"

UBIN=/usr/bin/unionfs-fuse

mount -t proc proc /proc
mount -t tmpfs tmpfs /tmp

mkdir -p $CHROOT_PATH/root
mkdir -p $CHROOT_PATH/rw
mkdir -p /tmp/union

mount --bind / $CHROOT_PATH/root

$UBIN $FUSE_OPT $UNION_OPT /rw=RW:/root=RO /tmp/union

mount -t proc proc /tmp/union/proc

cd /tmp/union
mkdir oldroot
pivot_root . oldroot

init q

./unionfs -o allow_other,use_ino,suid,dev,nonempty-ocow,chroot=/Volumes/ResidueFreeRamdisk,max_files=32768 / /Volumes/testVolume 
fuse: unknown option `nonempty-ocow'

./unionfs -o allow_other,use_ino,suid,dev,nonempty-ocow,chroot=/Volumes/ResidueFreeRamdisk,max_files=32768 /top=RW:/bottom=RO /Volumes/testVolume
./unionfs -ocow ~/testRead=RO:testWrite=RW ~/unionTest 

diskutil erasevolume HFS+ "ResidueFreeRamDisk" `hdiutil attach -nomount ram://2097152`
./unionfs -ocow /Volumes/ResidueFreeRamDisk=RW:testRead=RO ~/unionTest
diskutil unmount ResidueFreeRamDisk


./unionfs -ocow /System/Volumes/ResidueFreeRamDisk=RW:/Users=RO /System/Volumes/UnionDisk

./unionfs -ocow /System/Volumes/ResidueFreeRamDisk=RW:/Users=RO /System/Volumes/UnionDisk
./unionfs -ocow /Volumes/ResidueFreeRamDisk=RW:/Users=RO /Volumes/UnionDisk
sudo chroot ~/unionTest


./unionfs -ocow,chroot=/Users/AlexMatta/unionTest inTestRead=RW:inTestWrite=RO combo

