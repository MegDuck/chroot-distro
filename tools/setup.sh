
#!/bin/bash
path=$(realpath .)
echo "Installing tsu package for sudo..."
apt update && apt upgrade
apt install tsu
clear
if [[ $1 == "" ]]; then
	echo "Please, choose distro!"
	exit
elif [[ $2 == "" ]]; then
	echo "Please choose version!"
	exit
fi
cd $path/linux/$1/$2
echo "remounting all"
sudo remount
sudo /system/bin/mount -o remount,rw /
echo "mounting pseudo-fs..."
sudo -E /system/bin/mount proc -t proc $PWD/proc
if [[ $ALREADY_MOUNTED == "" ]]; then
if [[ $? != 1 ]]; then
	echo "/proc mounted on ./proc succefly!"
else
	echo "ERROR 1. Can't mount /proc on ./proc..."
fi
sudo -E /system/bin/mount sys -t sysfs $PWD/sys
if [[ $? != 1 ]]; then
        echo "sysfs mounted on ./sys succefly!"
else
        echo "ERROR 1. Can't mount sysfs on ./sys..."
fi
sudo -E /system/bin/mount --bind /dev $PWD//dev
if [[ $? != 1 ]]; then
        echo "/dev mounted on ./dev succefly!"
else
        echo "ERROR 1. Can't mount /dev on ./dev"
fi
sudo -E /system/bin/mount --bind /dev/pts $PWD/dev/pts
if [[ $? != 1 ]]; then
        echo "/dev mounted on ./dev/pts succefly!"
else
        echo "ERROR 1. Can't mount /dev on ./dev"
fi
fi
ALREADY_MOUNTED="true"

echo $2 > ./etc/debian_chroot
cat >./etc/mtab <<EOF
rootfs / rootfs rw 0 0
EOF
sudo -E chroot $PWD /usr/bin/env -i HOME=/root TERM="$TERM" /bin/bash --login
