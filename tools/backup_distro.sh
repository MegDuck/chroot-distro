#!/bin/bash




path=$(realpath ../)
# tools
help() {
	echo "v1.0 chroot_distro:backup_distro"
	echo ""
	echo "base syntax : "
	echo "backup_distro command_of_backup distribution_name distribution_version_name archive-end"
	echo "ex. backup_distro make debian stable xz"
	echo ""
	echo "Commands: "
	echo "make - command for backup create"
	echo "make backup with suffix .tar.<xz, bz2, gz> and save in backups/distribution_name/version_name"
	echo ""
	echo "restore - command for backup restore"
	echo "restore backup with suffix .tar.<xz, bz2, gz> and save in linux/distribution_name/version_name"
	echo ""
	echo "Options: "
	echo "--delete-backup - delete backup after restore"
	echo "delete-other - Deletes files not present in the backup"
	echo "--help - show this menu"

}

if [[ $1 == "make" ]]; then
	# $2 - <distribution name>
	# $3 - <distribution_version_name>
	# $4 - archive compress
	cd ../linux
	cd $2
	pkg upgrade && pkg update && pkg install tar
	tar cpzf $2-$3.tar.$4 --one-file-system -C $2-$3 .
	mv $2-$3.tar.$4 ../../backups/$2/$


elif [[ $1 == "restore" ]]; then
	echo "If you restore a backup with the same distribution name and the same version as the current distribution, this will erase your data"
	cd ../backups/$2/$3

	if [[ $5 == '--delete-other' ]]; then
		rm -rf $path/linux/$2/$3/*
	fi
	tar xpf $2-$3.tar.$4 -C $path/linux/$2/$3/ --numeric-owner
	if [[ $5 == '--delete-backup' ]]; then
		rm -rf $2-$3.tar.$4
	fi

elif [[ $1 == "--help" ]]; then
	help
else
	echo "syntax: backup_distro.sh <command> <distrbution> <branch> <archive_end(gz, xz, bz2)>"
	printf "need more help? backup_distro --help \n"
fi
