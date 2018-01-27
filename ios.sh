#!/bin/sh
idevicepair pair
ifuse ~/usr/mnt
nautilus --no-desktop --new-window ~/usr/mnt
