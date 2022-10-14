Clear-Host
Set-Location $home
set-executionpolicy -executionpolicy unrestricted -force
Set-Alias -Name p -Value powershell
Set-Alias -Name c -Value code
Set-Alias -Name n -Value node
$global:mods = "C:\Program Files\windowspowershell\modules"
#profile == $profile
#home == $home
