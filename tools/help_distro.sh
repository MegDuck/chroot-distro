path=$(realpath ..)


backup_info() {
	echo "make <distribution_codename> <branch_or_version_name> <xz//bz2/gz - for compress"
	echo ">>>make backup of choosen distribution"
	echo ""
	echo "del <distribution_codename> <num> [-a]"
	echo ">>>delete chosen backup of rootfs"
	echo ">>if not number given, delete last backup"
	echo ">(option '-a' delete all choosen backup)"
	echo ""
	echo "install <distribution_codename> <num>"
	echo ">>>dearchive rootfs to /linux"
}

if [[ $1 == '-m' ]] 
then
less $path/config/login
elif [[ $1 == '-b' ]]
then
backup_info
else
cat $path/config/login
fi

