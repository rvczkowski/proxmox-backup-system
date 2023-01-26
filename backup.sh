#!/bin/bash

source config.sh


function PreparingToBackup() {
	for (( a=0; a<=$numberoflines-1; a++ ))
	do
		local message="Inicjalizacja procesu tworzenia kopii zapasowej serwera ${idarray[$a]}";
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
		local message="Kopia zapasowa serwera ${idarray[$a]} z dnia $DATA została utworzona pomyślnie!";
		SendMessage;
		rm -r $logdir/vzlog${idarray[$b]}.log;
	else
		local message="@here UWAGA! Kopia zapasowa serwera ${idarray[$a]} z dnia $DATA zakończyła się niepowodzeniem!";
		SendMessage;
	fi

}

ListAllServerIDS;
PreparingToBackup;
