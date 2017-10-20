#!/bin/sh
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi
cd /boot/efi/EFI/Microsoft/Boot/
name=bootmgfw
if [[ -e $name.efi ]] ; then
    i=0
    while [[ -e $name$i.efi ]] ; do
        let i++
    done
    name=$name$i
fi
echo "New file $name"
mv /boot/efi/EFI/Microsoft/Boot/bootmgfw.efi "$name".efi
cp /boot/efi/EFI/ubuntu/grubx64.efi /boot/efi/EFI/Boot/grubx64.efi
cp /boot/efi/EFI/ubuntu/shimx64.efi /boot/efi/EFI/Boot/bootx64.efi
cp /boot/efi/EFI/ubuntu/shimx64.efi /boot/efi/EFI/Microsoft/Boot/bootmgfw.efi
echo "Boot copied"
