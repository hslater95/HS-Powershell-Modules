<#
This functions creates a user module, stores it in the modules path, 
adds it to the profile file, and opens it in vs code.
#>

<#sets the location oto the module path#>
function mods {set-location "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules"
}

<#checks module to see if it contains any improper characters#>
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

<#checks the module name for length and for improper characters#>
function check_module($str) {
    if ($str.length -lt 1) {
        write-host "A module name cannot be empty. Please try again."
        return 0
    }
    if ($str.length -gt 50) {
        write-host "Your module name is too long. Please try again."
        return 0
    }
    if (contains_improper_characters($modname)) {
        write-host "$modname contains improper characters. Please try again."
        return 0
    } 
    return 1
}

<#Checks to see if this module has already been created or not#>
function validate_module($str) {
    mods
    $x = get-childitem -filter 'hs*' 
    foreach ($item in $x) {
        if ($item.name -eq $str) {
            write-host "$str is already a module."
            $ans2 = read-host "press '1' to re-enter module name or any other key to exit."
            if ($ans2 -eq 1) 
            {create_module;
            return 
            }
            return

        }
    }

}


<#Adds my initials to the beggening of the module
If you are using this file just switch out the characters 
for your own initials#>
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

<#removes whitespace from the beginning, middle, and end of a module name, and 
adds underscores where the white space in the middle should be#>
function remove_whitespace($str) {
    $new_str = $null
    $new_str = $str.trim()
    $new_str = $new_str -replace '\s+', '_'
    return $new_str  
}



<#creates the module directory and module file from within the module path #>
function make_module($str) {
    new-item $str -itemtype directory
    set-location $str
    $modfile = $str + ".psm1"
    new-item $modfile -itemtype file
}

<#Adds the module name to your profile page#>
function add_module_to_profile($str) {
$import_str = 'import-module' + " " + $str
$prof = "C:\windows\system32\windowspowershell\v1.0\profile.ps1"
add-content $prof $import_str 
}
function open_module_in_vs_code($str) {
    mods
$modpath = "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\" + $str + ".psm1" 
write-host $modpath
c $modpath
}




<#creates a module from start to finish#>
function create_module {   
     $modname = read-host "Enter your new module name"
        $checkmod = check_module($modname)
    if (-not $checkmod) {
        return
    }
    $modname = add_hs($modname)
    write-host "You entered $modname."
    $ans = read-host "Would you like to proceed with your module name(Enter [Y] for Yes or [N] for No)?"
    if ($ans -match 'y|yes|yeah|yup') {
       #chill out.
    }
    elseif ($ans -match 'n|no|nope') {
        $ans2 = read-host "press '1' to re-enter module name or any other key to exit."
        if ($ans2 -eq 1) 
        {create_module;
            return 
            }
            return
        }
    else {
        write-host " Exiting program..."
        return
    }
    validate_module($modname)
    make_module($modname) 
    add_module_to_profile($modname)
    open_module_in_vs_code($modname)
}


