#!/bin/bash
if [[ $ALREADY_MOUNTED != "true" ]]; then
export ALREADY_MOUNTED="false"
fi
echo "************************"
echo "*    CHROOT-DISTRO     *"
echo "*                      *"
echo "*        v1.0          *"
echo "*                      *"
echo "************************"

if [[ $1 == "install" ]] 
then
	./tools/install_distro.sh
elif [[ $1 == "backup" ]]; then
	./tools/backup_distro.sh $2 $3

elif [[ $1 == "setup" ]]; then
	./tools/setup.sh $2 $3

elif [[ $1 == "help" ]]; then
	cat config/login
fi
