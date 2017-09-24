#!/bin/bash

ESP_PARTITION="/boot"
GRUB_BOOTLOADER_ID="GRUB"

echo " >>> Purging GRUB . . ."
rm -rf "$ESP_PARTITION/grub"
rm -rf "$ESP_PARTITION/$GRUB_BOOTLOADER_ID"

if [ ! -e "$ESP_PARTITION/initramfs-linux.img" ]; then
    echo " >>> Building the Linux initramfs . . ."
    mkinitcpio -p linux
fi

echo " >>> Installing GRUB . . ."
grub-install --target=x86_64-efi --efi-directory="$ESP_PARTITION" --bootloader-id="$GRUB_BOOTLOADER_ID"

echo " >>> Updating GRUB . . ."
update-grub
