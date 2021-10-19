#!/bin/bash

while [ "$#" -gt 0 ]; do
	case "$1" in
		-s|--skip-local) SKIP=true; shift $#;;
		-l|--local-only) LOCAL=true; shift $#;;
	esac
done

d=$(date +'%m_%d_%Y')
touch /media/isaac/Large_External/Backup/last_backup_date.txt
echo $d > /media/isaac/Large_External/Backup/last_backup_date.txt

src_1=/media/isaac/Data/
src_2=/media/isaac/Data/UbuntuImageBackup
dst=/media/isaac/Large_External/Backup/

if [[ ! $SKIP ]]; then
	echo "Backing up files to /media/isaac/Data/UbuntuImageBackup..."
	sudo rsync -aAX / --update --cvs-exclude --exclude-from="/home/isaac/scripts/random-scripts/backup/exclude-backup.txt" /media/isaac/Data/UbuntuImageBackup/
	echo "Finished backing up files to /media/isaac/Data/UbuntuImageBackup"
	echo "Sleeping for 3 seconds"
else
	echo "Skipping local backup..."
fi

# https://serverfault.com/a/901858
isMounted() {
	findmnt -rno UUID | grep "32DC-CAD0" >/dev/null;
}

mountHDD() {
	sudo mount -U 32DC-CAD0 /media/isaac/Large_External/ -o dmask=022,fmask=133,uid=1000,gid=1000
}

if [[ $LOCAL ]]; then
	echo "Skipping backup to external HDD..."
	exit 0
fi

echo "Checking if large external HDD is mounted"
retry_count=0
while ! isMounted && [[ $retry_count -lt 3 ]]; do
	echo "Large External HDD not mounted..."
	echo "Mounting now."
	mountHDD
	if [ $? -eq 0 ]; then
		echo "Successfully mounted HDD!"
		break
	else
		echo "Failed to mount HDD..."
		retry_count=$((retry_count+1))
		echo "Retrying in 3 seconds"
		sleep 3
		continue
	fi
done

if [[ $retry_count -eq 3 ]]; then
	echo "Failed to mount HDD after retries. Exiting."
	exit 1
fi

echo "Starting backup of ${src_1} to ${dst}..."
rsync -a --update --no-specials --no-devices --no-links --cvs-exclude --exclude={"UbuntuImageBackup","Shows","Movies",".git/*",".vscode/*","node_modules/*"} $src_1 $dst
echo "Finished backing up ${src_1} to ${dst}"
echo "Sleeping for 5 seconds"
sleep 5
echo "Starting backup of ${src_2} to ${dst}..."
rsync -a --update --no-specials --no-devices --no-links --cvs-exclude --exclude={"UbuntuImageBackup/home/isaac/Documents","UbuntuImageBackup/home/isaac/Music","UbuntuImageBackup/home/isaac/Pictures",".git/*",".vscode/*","node_modules/*","UbuntuImageBackup/lib/modules","UbuntuImageBackup/var/lib/dpkg","UbuntuImageBackup/lib/firmware"} $src_2 $dst
echo "Finished backing up ${src_2} to ${dst}"

