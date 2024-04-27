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
echo "
╭━━━┳╮╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭━━━┳╮
┃╭━╮┃┃╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱┃╭━╮┃┃
┃┃╱┃┃┃╭╮╱╭┳━━┳━━┳━━┳━╮╱┃┃╱╰┫┃╭━━┳╮╱╭┳━━┳━━┳━╮
┃╰━╯┃┃┃┃╱┃┃━━┫━━┫╭╮┃╭╮╮┃┃╭━┫┃┃┃━┫┃╱┃┃━━┫╭╮┃╭╮╮
┃╭━╮┃╰┫╰━╯┣━━┣━━┃╰╯┃┃┃┃┃╰┻━┃╰┫┃━┫╰━╯┣━━┃╰╯┃┃┃┃
╰╯╱╰┻━┻━╮╭┻━━┻━━┻━━┻╯╰╯╰━━━┻━┻━━┻━╮╭┻━━┻━━┻╯╰╯
╱╱╱╱╱╱╭━╯┃╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭━╯┃
╱╱╱╱╱╱╰━━╯╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╰━━╯
Finished script" && date