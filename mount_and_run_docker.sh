#!/bin/bash

shareaccount=$1
sharekey=$2

mkdir -p /mnt/gtlog
mkdir -p /mnt/gtdependencies 
echo "//jaicustsa01.file.core.windows.net/gtlog /mnt/gtlog cifs vers=3.0,username=${shareaccount},password=${sharekey},dir_mode=0777,file_mode=0777" >> /etc/fstab
echo "//jaicustsa01.file.core.windows.net/gtdependencies /mnt/gtdependencies cifs vers=3.0,username=${shareaccount},password=${sharekey},dir_mode=0777,file_mode=0777" >> /etc/fstab
sleep 3
mount -a
sleep 10

if [ -z "$(df | grep /mnt/gtlog)" ]; then
    echo "Failed to mount gtlog"
    exit 113
fi

if [ -z "$(df | grep /mnt/gtdependencies)" ]; then
    echo "Failed to mount gtdependencies"
    exit 113
fi

mkdir -p /mnt/gtlog/$(hostname)
mkdir -p /mnt/gtdependencies/$(hostname)
