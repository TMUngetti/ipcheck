#!/bin/bash

if [ $# -eq 0 ]; then
	echo "ERROR: command needs an argument"
	exit 1
fi

case $1 in

	"-s")
#		ip_var=$(ip -json route get 8.8.8.8 | jq -r '.[].prefsrc')
		ip_var=$(curl -s ifconfig.me)
		loc=$(curl -s http://ip-api.com/json/$ip_var | jq -r ".city")
		echo "$ip_var, $loc"
		;;

	"-h")
		hostname=$2

		if [ $# -lt 2 ]; then
			echo "ERROR: no hostname defined"
			exit 1
		fi

		ip_var=$(dig +short $hostname)
		loc=$(curl -s http://ip-api.com/json/$ip_var | jq -r ".city")
		echo "$ip_var, $loc"
		;;
	
	"-ip")
		ip=$2

		if [ $# -lt 2 ]; then
			echo "ERROR: no ip defined"
			exit 1
		fi

		loc=$(curl -s http://ip-api.com/json/$ip | jq -r ".city")
		echo "$ip, $loc"
		;;

	"--help")
		echo "ipcheck -h [HOSTNAME];	Resolve Public IP of the host and geoloc it"
		echo "ipcheck -s;		Resolve self Public IP"
		;;
	*)
		echo "ERROR: argument not recognized"
		;;
esac
	
		
