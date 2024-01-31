#!/bin/bash

# COLORS
CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

if [[ $# -eq 0 ]]; then
	echo -e "$RED[ERROR]$NC: Command needs an argument"
	exit 1
fi

case $1 in

	"-s")
		ip_var=$(curl -s ifconfig.me)
		country_code=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".countryCode")
		loc=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".city")
		zip=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".zip")
		proxy=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".proxy")
		status=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".status")

		if [[ $status == "success" ]]; then
			echo -e "$GREEN[$status]$NC : $ip_var : $loc, $zip, $country_code : $CYAN$proxy$NC"
		elif [[ $status == "fail" ]]; then
			echo -e "$RED[$status]$NC : Something went wrong, check syntax"
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

		if [[ $status == "success" ]]; then
			echo -e "$GREEN[$status]$NC : $ip_var : $loc, $zip, $country_code : $CYAN$proxy$NC"
		elif [[ $status == "fail" ]]; then
			echo -e "$RED[$status]$NC : Something went wrong, check syntax"
		fi
		;;
	
	"-ip")
		ip_var=$2

		if [ $# -lt 2 ]; then
			echo "ERROR: no ip defined"
			exit 1
		fi

		country_code=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".countryCode")
		loc=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".city")
		zip=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".zip")
		proxy=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".proxy")
		status=$(curl -s http://ip-api.com/json/$ip_var?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,proxy,query | jq -r ".status")

		if [[ $status == "success" ]]; then
			echo -e "$GREEN[$status]$NC : $ip_var : $loc, $zip, $country_code : $CYAN$proxy$NC"
		elif [[ $status == "fail" ]]; then
			echo -e "$RED[$status]$NC : Something went wrong, check syntax"
		fi
		;;

	"--help")
		echo "ipcheck -h [HOSTNAME];	Resolve Public IP of the host and geoloc it"
		echo "ipcheck -s;		Resolve self Public IP"
		;;
	*)
		echo "ERROR: argument not recognized"
		;;
esac
	
		
