#!/bin/bash

#################################################
#     Name: Cesar Leon C.
#     E-mail: leoncesaralejandro@gmail.com
#     Type: Shell Script
#     Date: August, the 8th/ 2021
#     Description: INSTALL VARIETY OF PROGRAMS
#################################################

# Actualizar los mirrors
sudo rm -rf /etc/pacman.d/mirrorlist
sudo curl -o /etc/pacman.d/mirrorlist https://archlinux.org/mirrorlist/all/
sudo sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist

# Install emacs
sudo pacman -S --noconfirm fd emacs ripgrep

# Install doom emacs
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# Install accesories
sudo pacman -S --noconfirm zsh wget obs-studio \
          vifm vlc virtualbox
# Change default user shell to zsh
sudo usermod -s /bin/zsh cesar
