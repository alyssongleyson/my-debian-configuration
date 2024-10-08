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
# Installing Brave Browser
flatpak install flathub com.brave.Browser -y
###################################################################
# Installing CopyQ
apt install copyq -y
###################################################################
# Installing Dev Toolbox
flatpak install flathub me.iepure.devtoolbox -y
###################################################################
# Installing Dropbox
wget https://linux.dropboxstatic.com/debian/pool/main/dropbox_2024.04.17_amd64.deb
apt install "$PWD/dropbox_2024.04.17_amd64.deb" -y
rm dropbox_2024.04.17_amd64.deb
###################################################################
# Installing Figlet
apt install figlet -y
###################################################################
# Installing Firefox Developer
wget "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=pt-BR" -O firefox-developer.tar.bz2
sudo tar -jxvf  firefox-developer.tar.bz2 -C /opt/
mv /opt/firefox*/ /opt/firefox-developer
ln -sf /opt/firefox-developer/firefox /usr/bin/firefox-developer
echo -e '[Desktop Entry]\n Encoding=UTF-8\n Name=Firefox Developer\n Comment=Navegador Web\n Exec=/opt/firefox-developer/firefox\n Icon=/opt/firefox-developer/browser/chrome/icons/default/default128.png\n Type=Application\n Categories=Network' | sudo tee /usr/share/applications/firefox-developer.desktop
chmod +x /usr/share/applications/firefox-developer.desktop
rm firefox-developer.tar.bz2
###################################################################
# Installing Flameshot
apt install flameshot -y
###################################################################
# Installing Google Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo tee /etc/apt/trusted.gpg.d/google.asc >/dev/null
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor |sudo tee /etc/apt/trusted.gpg.d/google.gpg >/dev/null
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
apt update -y
apt install google-chrome-stable -y
###################################################################
# Installing Klavaro
apt install klavaro -y
###################################################################
# Installing Mega Sync
wget https://mega.nz/linux/repo/Debian_12/amd64/megasync-Debian_12_amd64.deb 
apt install "$PWD/megasync-Debian_12_amd64.deb" -y
rm megasync-Debian_12_amd64.deb
###################################################################
# Installing Microsoft Edge
flatpak install flathub com.microsoft.Edge -y
###################################################################
# Installing Obsidian
flatpak install flathub md.obsidian.Obsidian -y
###################################################################
# Installing Simplenote
flatpak install flathub com.simplenote.Simplenote -y
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
# Installing Virtualbox
apt install binutils build-essential dkms linux-headers-$(uname -r) make -y
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bookworm contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
apt update -y
apt install virtualbox-7.0 -y
# Fixing virtualbox error kernel drive not installed
apt install build-essential module-assistant -y
m-a prepare -y
sudo /sbin/vboxconfig
###################################################################
# Installing Visual Studio Code
wget https://packages.microsoft.com/repos/code/pool/main/c/code/code_1.88.1-1712771838_amd64.deb
apt install "$PWD/code_1.88.1-1712771838_amd64.deb" -y
rm code_1.88.1-1712771838_amd64.deb
###################################################################
# Finalizing the script
figlet $'Alysson\nGleyson'
echo "Finished script" && date
