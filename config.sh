#!/bin/bash

#----------------------------------------------------------------------------------------------------
#                                             VARIABLES                                             # 
#----------------------------------------------------------------------------------------------------

backupdir="/var/lib/vz/dump"

slack_webhook_link="paste_your_slack_link"
discord_webhook_link="paste_your_discord_link";
teams_webhook_link="paste_your_teams_link"
mattermost_webhook_link="paste_your_mattermost_link"

logdir="/var/log/backup_system";


#----------------------------------------------------------------------------------------------------
#                                             COMMUNICATOR SWITCHER                                 # 
#----------------------------------------------------------------------------------------------------

#Switching a communicator is in variable $communicator_switcher;
	#1 Slack
	#2 Discord
	#3 Teams
	#4 Mattermost

communicator_switcher="3";

#----------------------------------------------------------------------------------------------------
#                                             BASE FUNCTIONS                                        # 
#----------------------------------------------------------------------------------------------------


function ListAllServerIDS() {
	ids=$(cat /etc/pve/.vmlist | grep node | cut -d '"' -f2 | sort -n | paste -sd' ');

	command=$(cat /etc/pve/.vmlist | grep node | wc -l);

	idarray=($ids);

	numberoflines=$command;
}

function SendMessage() {

	if [[ $communicator_switcher == "1" ]]
	then
		curl -X POST -d "{\"text\": \"$message\"}" -H "Content-Type: application/json" "$slack_webhook_link";
	elif [[ $communicator_switcher == "2" ]]
	then
		curl -d "{\"content\": \"$message\"}" -H "Content-Type: application/json" "$discord_webhook_link";
	elif [[ $communicator_switcher == "3" ]]
	then
		curl -d "{\"text\": \"$message\"}" -H "Content-Type: application/json" "$teams_webhook_link";
	elif [[ $communicator_switcher == "4" ]]
	then
		curl -i -X POST -d "{\"text\": \"$message\"}" -H "Content-Type: application/json" "$mattermost_webhook_link";
	else
		exit 0;
	fi	
	
	
}
