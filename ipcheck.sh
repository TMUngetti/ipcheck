#!/bin/bash

if [ $# -eq 0 ]; then
	echo "ERROR: command needs an argument"
	exit 1
fi

# COLORS
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

case $1 in

	"-s")
		ip_var=$(curl -s ifconfig.me)
		country_code=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".countryCode")
		loc=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".city")
		zip=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".zip")
		proxy=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".proxy")
		status=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".status")

		if [ $status="success" ]; then
			echo -e "$GREEN[$status]$NC : $ip_var : $loc, $zip, $country_code : $CYAN$proxy$NC"
		else
			echo -e "[ $status ] : Something went wrong, check syntax"
		fi
		;;

	"-h")
		hostname=$2

		if [ $# -lt 2 ]; then
			echo "ERROR: no hostname defined"
			exit 1
		fi

		ip_var=$(dig +short $hostname)
		country_code=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".countryCode")
		loc=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".city")
		zip=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".zip")
		proxy=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".proxy")
		status=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".status")

		if [ $status="success" ]; then
			echo -e "$GREEN[$status]$NC : $ip_var : $loc, $zip, $country_code : $CYAN$proxy$NC"
		else
			echo -e "[ $status ] : Something went wrong, check syntax"
		fi
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
	
		
