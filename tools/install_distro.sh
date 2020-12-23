#any tools
path=$(realpath ..)
current_path=$(pwd)

done_chroot="false"
load() {
	
	if [ -d $1-$2 ]
	then
	printf "are you wanna load done-chroot?(y/n): "
	read load
	if [[ load == 'y' ]]
	then
		done_chroot="false"
		echo "Ok, reloading to $1-install interface"
	else
	done_chroot="true"
	echo "load to $1-$2"
	fi
	fi

}


#main
start(){
clear
echo "installing packages..."
#for any distributives like-ARM_arch
pkg install wget -y
#for Ubuntu, debian, kali etc.
pkg install debootstrap -y
#for configurations and friendly interface
pkg install dialog -y
echo "all done!"
clear
echo "---Chroot-distro termux beta---"
echo "--avalible distro: --"
printf "\t Debian \n"
printf "\t -codename : debian \n"
printf "choose distro: "
}


install_distro() {
read distro
if ![ -d ../config/$distro ]; then
mkdir ../config/$distro
elif ![ -d ../backups/$distro ]; then
mkdir ../backups/$distro
else
echo "all already created"
fi


if [[ $distro == "debian" || $distro == "Debian" ]]
then
	debootstrap_version="stable"
	clear
	echo "go to ../linux"
	cd ../linux

	if [ -f ./debian ]
	then
		echo "directory exists"
	else
		mkdir debian
        fi
	cd debian

	echo "*--------------------*"
	echo "*it can take a while *"
	echo "*Grab a coffee or tea!*"
	echo "---------------------*"
	echo ""
	echo "installing debootstrap..."
	printf "version of debian(ENTER if dont know): "

	dialog --clear --title "install_distro:sub" \
	    --default-item "Debian-stable" \
	    --menu "Select version:" \
	    20 51 7 \
	   "stable"  "Debian-Stable" \
	    "jessie " "Debian-Jessie" \
	    "squeeze" "Debian-Squeeze" 2>out.tmp
	clear
	debootstrap_version=$(cat out.tmp)
	rm -rf out.tmp
	if ![ -d ../config/$distro/$debootstrap_version ]; then
		mkdir ../config/$distro/$debootstrap_version
	elif ![ -d ../backups/$distro ]; then
		mkdir ../backups/$distro/$debootstrap_version
	else
		echo "all already created"
	fi

	load "debian" $debootstrap_version
	if [[ $debootstrap_version == "stable" && $done_chroot != "true" ]]
	then
		echo "*$HOSTTYPE*"
		echo "*Stable-Debian*"
		echo "*download     *"
		debootstrap stable ./debian/ http://deb.debian.org/debian/
	elif [[ $debootstrap_version == "jessie" && $done_chroot != "true" ]]
	then
		echo "*$HOSTTYPE   *"
                echo "*Jesse-Debian*"
                echo "*download... *"
		debootstrap jessie ./debian/ http://deb.debian.org/debian/
	elif [[ $debootstrap_version == "squeeze" && $done_chroot != "true" ]]
	then
		echo "*$HOSTTYPE     *"
                echo "*Squeeze-Debian*"
                echo "*download..  . *"
		debootstrap squeeze ./debian/ http://deb.debian.org/debian/
	fi
cd $current_path
#bash ./help_distro.sh
fi
}
start
install_distro
