# PsWinAdmin
Various Windows tools for use by an administrator.

## Check for Pending Reboots
```
(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/tonypags/PsWinAdmin/master/Get-PendingReboot.ps1')|iex;Get-PendingReboot
```

## Review Reboot History
```
(New-Object Net.WebClient).DownloadString( 'https://raw.githubusercontent.com/tonypags/PsWinAdmin/master/Get-RebootReport.ps1' )| iex; Get-RebootReport | ft -a -wrap
```

## Check for software matching a string
```
$strAppName = '*application*name*partial*';(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/tonypags/PsWinAdmin/master/Get-InstalledSoftware.ps1')|iex;Get-InstalledSoftware | ?{$_.Name -like $strAppName}
```

## Ensure TLS v1.2 is enabled on Windows supported OSes
```
$web=(New-Object Net.WebClient);@('Confirm-RequiresAdmin','Assert-TlsVersion1.2') | %{$web.DownloadString("https://raw.githubusercontent.com/tonypags/PsWinAdmin/master/$($_).ps1")|iex; iex "$_"}
```
