#!/bin/sh
cat ./backup > ~/.config/user-dirs.dirs 
xdg-user-dirs-update
xdg-user-dirs-gtk-update
sudo service lightdm restart
