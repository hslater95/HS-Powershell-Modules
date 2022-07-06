Clear-Host
set-location $HOME
new-alias -name c -value "C:\Users\hslater\AppData\Local\Programs\Microsoft VS Code\bin\code.cmd"
new-alias -name anki -value "C:\users\hslater\anki.lnk"
new-alias -name slack -value c:\users\hslater\slack.lnk
set-alias -name p -value powershell
set-executionpolicy -executionpolicy unrestricted -force
function prof { set-location "c:\windows\system32\windowspowershell\v1.0"}
function mods {set-location "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules"}
function contains_improper_characters($str) {
function profile_path {return " C:\windows\system32\windowspowershell\v1.0\profile.ps1"}    

    if ($str -like "*'*") {
        $x = ($str -like "*'*")
        return $x 
    }
    $improper_chars = [regex]::new('["!@#\$%\^&\*()\+=`~\?<>\.]')
    $match = $improper_chars.match($str)
    return $match.Success
}

function add_hs($str) {
        $new_str = $null;
        


       
    if ($str -match '^\s*_+') {
        $new_str = $str -replace '^\s*_+', 'hs_'
        $new_str = remove_whitespace($new_str)
       return $new_str 
    }
    if ($str -match '^hs_') {
       $new_str = $str -replace '^hs_', 'hs_'
       $new_str = remove_whitespace($new_str)
       return $new_str 
    }
    if ($str -match '^\s*hs_') {
        $new_str = $str -replace '^\s*hs_', 'hs_'
        $new_str = remove_whitespace($new_str)
       return $new_str   
    }
    if ($str -match 'hs\w') {
        $new_str = $str -replace 'hs', 'hs_'
        $new_str = remove_whitespace($new_str)
       return $new_str 
    }
    if ($str -notmatch '^hs_') {
        $new_str = $str.trimstart()
        $new_str = "hs_" + $new_str
        $new_str = remove_whitespace($new_str)
       return $new_str 
    }
    
    
}

function remove_whitespace($str) {
    $new_str = $null
    $new_str = $str.trim()
    $new_str = $new_str -replace '\s+', '_'
    return $new_str  

}