#!/bin/bash

###################################################################
# Script Name	:my-debian-configuration.sh
# Description	:My post-installation configuration of Debian
# Args			:bash my-debian-configuration.sh
# Author		:Álysson Gleyson da Silva
# Email			:
###################################################################

# Installing flatpak and enabling flathub

apt install gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
