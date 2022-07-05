Clear-Host
set-location $HOME
new-alias -name c -value "C:\Users\hslater\AppData\Local\Programs\Microsoft VS Code\bin\code.cmd"
new-alias -name anki -value "C:\users\hslater\anki.lnk"
new-alias -name slack -value c:\users\hslater\slack.lnk
set-alias -name p -value powershell
set-executionpolicy -executionpolicy unrestricted
function prof { set-location "c:\windows\system32\windowspowershell\v1.0\profile.ps1"}
function mods {set-location "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules"}
