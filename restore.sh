#!/bin/bash

source config.sh


function VeryfyingServerStatus() {
	for (( a=0; a<=$numberoflines-1; a++ ))
	do
		qm status ${idarray[$a]}; >> $logdir/qmstatus${idarray[$b]}.log
		
		if grep "status: started" $logdir/qmstatus${idarray[$b]}.log
		then
			rm $logdir/qmstatus${idarray[$b]}.log
			exit 0;
		else
			RealisingBackup;
		fi
	done
}

function RealisingBackup() {
	cd $backupdir;

	qmrestore vzdump-*-${idarray[$a]}*.vma  1${idarray[$a]} >> $logdir/vzrestore${idarray[$a]}.log
	qm start 1${idarray[$a]};
	
	if grep "rescan volumes..." $logdir/vzrestore${idarray[$a]}.log
	then
		local message="@here Virtual machine ID ${idarray[$a]} is down! Backup restored as machine ID 1${idarray[$a]}";
		SendMessage;
		rm -r $logdir/vzrestore${idarray[$a]}.log;
	else
		local message="@here Virtual machine ID ${idarray[$a]} is down! Backup failed!";
		SendMessage;
	fi

}

ListAllServerIDS;
VeryfyingServerStatus;

