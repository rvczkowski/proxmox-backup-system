#!/bin/bash

source config.sh


function VeryfyingServerStatus() {
	for (( a=0; a<=$numberoflines-1; a++ ))
	do
		qm status ${idarray[$a]}; >> $logdir/qmstatus${idarray[$b]}.log
		
		if grep "status: started" $logdir/qmstatus${idarray[$b]}.log
		then
			echo "${idarray[$a]} git";
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

	if grep "rescan volumes..." $logdir/vzrestore${idarray[$a]}.log
	then
		local message="@here UWAGA! Awaria maszyny ID ${idarray[$a]}! Przywrócono kopię zapasową jako maszyna ID 1${idarray[$a]}";
		SendMessage;
		rm -r $logdir/vzrestore${idarray[$a]}.log;
	else
		local message="@here UWAGA! Awaria maszyny ID ${idarray[$a]}! Nie przywrócono kopii zapasowej!";
		SendMessage;
	fi

}

ListAllServerIDS;
VeryfyingServerStatus;

