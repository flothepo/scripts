#!/bin/sh

backup_uuid="6e50ba8d-b5aa-46aa-9a49-a31da1ff1195"
backup_label="backup"
mount_POINT="/run/media/root/$backup_label"
mount_cmd="udisksctl mount -b /dev/disk/by-uuid/$backup_uuid"
unmount_cmd="udisksctl unmount -b /dev/disk/by-uuid/$backup_uuid"

subvolumes="root home"

if [[ $EUID -ne 0 ]]; then
    printf "error: you cannot perform this operation unless you are root\n" 2>&1
else
    notify-send "Backup" "starting backup of subvolumes: $subvolumes"
    $mount_cmd
    for v in $subvolumes; do
        snap-sync -n -c $v -u $backup_uuid
    done
    $unmount_cmd
    notify-send "Backup" "backup done"
fi



