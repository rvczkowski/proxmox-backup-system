#!/bin/bash

serwer=2

while [ $serwer -le 5 ]
do
	ping -c1 192.168.1.$serwer > /dev/null
	if [ $? -eq 0 ]
	then
		##Zakończenie bez wyzwalania procesu przywracania kopii zapasowej
		echo "10$serwer git"
		exit 0
	else
		##Przejście do katalogu kopii zapasowych
		cd /var/lib/vz/dump

		##Wyzwolenie procesu przywracania kopii zapasowej
		qmrestore vzdump-*-10$serwer*.vma 20$serwer >> vzbackup.log

		##Wyłączenie maszyny ID 101 i włączenie maszyny ID 201
		qm start 20$serwer
		qm stop 10$serwer

		##Weryfikacja pomyślnego zakończenia procesu tworzenia kopii zapasowej
		if grep "rescan volumes..." vzbackup.log
		then
			MESSAGE="@here UWAGA! Awaria maszyny ID 10$serwer! Przywrócono kopię zapasową jako maszyna ID 20$serwer"
			curl -d "{\"content\": \"$MESSAGE\"}" -H "Content-Type: application/json" "https://ptb.discord.com/api/webhooks/1063123397267177563/HWOJHT8c0WGwtk3OpPjvSBRlQyxD3dkjDbGzzK3_scWtvcP52-LIGkpFpZr57V-TYvKQ"
			rm -r vzbackup.log
		else
			MESSAGE="@here UWAGA! Awaria maszyny ID 10$serwer! Nie przywrócono kopii zapasowej!"
			curl -d "{\"content\": \"$MESSAGE\"}" -H "Content-Type: application/json" "https://ptb.discord.com/api/webhooks/1063123397267177563/HWOJHT8c0WGwtk3OpPjvSBRlQyxD3dkjDbGzzK3_scWtvcP52-LIGkpFpZr57V-TYvKQ"
		fi
	fi
	((serwer++))
done