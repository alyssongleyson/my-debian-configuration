#!/bin/bash

###################################################################
# Script Name:	my-debian-configuration.sh
# Description:	My post-installation configuration of Debian
# Args:		bash my-debian-configuration.sh
# Author:	Álysson Gleyson da Silva
# Email:
###################################################################

# Editing sources.list
echo "# deb cdrom:[Debian GNU/Linux 12.5.0 _Bookworm_ - Official amd64 DVD Binary-1 with firmware 20240210-11:28]/ bookworm contrib main non-free-firmware

deb http://deb.debian.org/debian/ bookworm main non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm main non-free-firmware

deb http://security.debian.org/debian-security bookworm-security main non-free-firmware
deb-src http://security.debian.org/debian-security bookworm-security main non-free-firmware

# bookworm-updates, to get updates before a point release is made;
# see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
deb http://deb.debian.org/debian/ bookworm-updates main non-free-firmware
deb-src http://deb.debian.org/debian/ bookworm-updates main non-free-firmware" > /etc/apt/sources.list

apt update -y
apt upgrade -y
###################################################################
# Fixing time delay in dual boot
timedatectl set-local-rtc 1 --adjust-system-clock
###################################################################
# Installing flatpak and enabling flathub
apt install flatpak -y
apt install gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
###################################################################
# Removing unnecessary software
apt remove gnome-games gnome-keyring hexchat imagemagick zutty pidgin -y
apt autoremove -y
###################################################################
# Installing Bitwarden
flatpak install flathub com.bitwarden.desktop -y
###################################################################
# Installing Simplenote
flatpak install flathub com.simplenote.Simplenote -y
###################################################################
# Installing Obsidian
flatpak install flathub md.obsidian.Obsidian -y
###################################################################
# Installing Brave Browser
flatpak install flathub com.brave.Browser -y
###################################################################
# Installing Microsoft Edge
flatpak install flathub com.microsoft.Edge -y
###################################################################
# Installing Mega Sync
wget https://mega.nz/linux/repo/Debian_12/amd64/megasync-Debian_12_amd64.deb 
sudo apt install "$PWD/megasync-Debian_12_amd64.deb" -y
rm megasync-Debian_12_amd64.deb
###################################################################
# Installing Visual Studio Code
wget https://packages.microsoft.com/repos/code/pool/main/c/code/code_1.88.1-1712771838_amd64.deb
sudo apt install "$PWD/code_1.88.1-1712771838_amd64.deb" -y
rm code_1.88.1-1712771838_amd64.deb
###################################################################
# Installing Google Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/google.asc >/dev/null
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor |sudo tee /etc/apt/trusted.gpg.d/google.gpg >/dev/null
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
apt update -y
sudo apt install google-chrome-stable -y
###################################################################
# Installing Dropbox
wget https://linux.dropboxstatic.com/debian/pool/main/dropbox_2024.04.17_amd64.deb
sudo apt install "$PWD/dropbox_2024.04.17_amd64.deb" -y
rm dropbox_2024.04.17_amd64.deb
###################################################################
# Installing Virtualbox
sudo apt install binutils build-essential dkms linux-headers-$(uname -r) make -y
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bookworm contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
apt update -y
apt install virtualbox-7.0 -y
# Fixing virtualbox error kernel drive not installed
sudo apt install build-essential module-assistant -y
sudo m-a prepare -y
sudo /sbin/vboxconfig
###################################################################
# Installing Sublime Text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt update -y
apt install sublime-text -y
###################################################################
# Installing Synapse
apt install synapse -y
###################################################################
# Installing Terminator
apt install terminator -y
###################################################################
# Installing Dev Toolbox
flatpak install flathub me.iepure.devtoolbox -y
###################################################################
# Installing Figlet and finalizing the script
apt install figlet -y
figlet $'Alysson\nGleyson'
echo "Finished script" && date
