#!/bin/bash

#====================================================
# Subdomain Enumerator using crt.sh + ping verificaiton
# Author : Ryan Ellis (sweetrellish)
# Description : Finds subdomains usig crt.sh, filters results,
#               and checks which ones are live via ping.
#====================================================

read -p "Enter domain (e.g., example.com): " domain

echo "[*] Gathering subdomains from crt.sh..."
#Pull subdomains in JSON from crt.sh and filter names
curl -s "https://crt.sh/?q=%25.$domain&output=json" | \
    jq -r '.[].name_value' | \
    sed 's/\*.//g' | sort -u > subs.txt

echo "[*] Probing for live subdomains..."
#Ping each subdomain to see if it's active 
while read sub; do
    ping -c 1 $sub &>/dev/null && echo "[*] Alive: $sub"
done < subs.txt