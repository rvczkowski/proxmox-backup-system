#!/bin/bash

source config.sh


function PreparingToBackup() {
	for (( a=0; a<=$numberoflines-1; a++ ))
	do
		local message="Initiating the server backup process of VM ID ${idarray[$a]}";
		SendMessage;
		rm vzdump-*-${idarray[$a]}-*
		RealisingBackup
	done
}

function RealisingBackup() {
	cd $backupdir;

	vzdump ${idarray[$a]} >> $logdir/vzlog${idarray[$a]}.log;

	if grep "INFO: Backup job finished successfully" $logdir/vzlog${idarray[$a]}.log
	then
		local message="Server backup VM ID ${idarray[$a]} of $DATA has been created successfully!";
		SendMessage;
		rm -r $logdir/vzlog${idarray[$b]}.log;
	else
		local message="@here ${idarray[$a]} server backup on $DATA failed!";
		SendMessage;
	fi

}

ListAllServerIDS;
PreparingToBackup;
