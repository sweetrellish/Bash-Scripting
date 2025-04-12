#!/bin/bash

#===============================================================
# Directory Brute-Forcer
# Author : Ryan Ellis (sweetrellish)
# Description : Uses a wordlist to brute-force directories
#               on a target URL and checks for 200/403 codes.
#===============================================================

# Prompt the user to enter the target URL
read -p "Enter target URL (e.g., http://example.com): " url 

# Prompt the user to enter the path to the wordlist
read -p "Enter wordlist path: " wordlist

# Notify the user that the brute-force process is starting
echo "[*] Starting directory brute-force..."

# Read each word from the wordlist and attempt to access the corresponding URL
while read word; do 
    # Use curl to send a request to the URL and capture the HTTP status code
    code=$(curl -s -o /dev/null -w "%{http_code}" "$url/$word/")
    
    # Check if the HTTP status code is 200 (OK) or 403 (Forbidden)
    if [ "$code" == "200" ] || [ "$code" == "403" ]; then
        # If a valid directory is found, print the URL and status code
        echo "[+] Found: $url/$word/ ($code)"
    fi
done < "$wordlist"  # Read words from the provided wordlist file