#!/bin/bash

serwer=102

while [ $serwer -le 105 ]
do
	server_id=$serwer
	##Przejście do katalogu kopii zapasowych
	cd /var/lib/vz/dump

	##Usunięcie poprzedniej kopii zapasowej
	rm vzdump-*-$serwer*

	MESSAGE="Inicjalizacja procesu tworzenia kopii zapasowej serwera $serwer!"
	curl -d "{\"content\": \"$MESSAGE\"}" -H "Content-Type: application/json" "https://ptb.discord.com/api/webhooks/1063123397267177563/HWOJHT8c0WGwtk3OpPjvSBRlQyxD3dkjDbGzzK3_scWtvcP52-LIGkpFpZr57V-TYvKQ"


	##Wyzwolenie procesu tworzenia kopii zapasowej
	vzdump $serwer >> /root/vzlog$serwer.log

	##Weryfikacja pomyślnego zakończenia procesu tworzenia kopii zapasowej
	if grep "INFO: Backup job finished successfully" /root/vzlog$serwer.log
	then
		DATA=`date '+%Y_%m_%d-%H_%M_%S'`
		MESSAGE="Kopia zapasowa serwera $serwer z dnia $DATA została utworzona pomyślnie!"
		curl -d "{\"content\": \"$MESSAGE\"}" -H "Content-Type: application/json" "https://ptb.discord.com/api/webhooks/1063123397267177563/HWOJHT8c0WGwtk3OpPjvSBRlQyxD3dkjDbGzzK3_scWtvcP52-LIGkpFpZr57V-TYvKQ"
		rm /root/vzlog$serwer.log
	else
		DATA=`date '+%Y_%m_%d-%H_%M_%S'`
		MESSAGE="@here UWAGA! Kopia zapasowa serwera $serwer z dnia $DATA zakończyła się niepowodzeniem!"
		curl -d "{\"content\": \"$MESSAGE\"}" -H "Content-Type: application/json" "https://ptb.discord.com/api/webhooks/1063123397267177563/HWOJHT8c0WGwtk3OpPjvSBRlQyxD3dkjDbGzzK3_scWtvcP52-LIGkpFpZr57V-TYvKQ"
	fi
	((serwer++))
done
