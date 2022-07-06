function code_module {
    get-content "C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1"
    $profile_content = get-content "C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1"
    write-host `n
    $modname = read-host "Enter module name"
    foreach ($line in $profile_content) {
        if ($line -match $modname) {
            $modpath = "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\" + $modname + "\" + $modname + ".psm1"
            c $modpath
            return
        }
    }
    write-host "The module entered cannot be found."
    write-host "Exiting program..."
}

function module_functions {
    write-host `n
    write-host 'create_module' `n
    write-host 'remove_module' `n
    write-host 'shield_module' `n
    write-host 'unshield_module' `n
    write-host 'code_module' `n
    write-host 'rename_module' `n
}

function check_name($str) {
    $flag = 0
    $profile_content = get-content "C:\windows\system32\windowspowershell\v1.0\profile.ps1"
    foreach ($line in $profile_content) {
        if ($line -match $str) {
            $flag = 1
            return $flag
        }
    }
    return $flag
}


function create_new_module {   
    $modname = read-host "Enter your new module name"
       $checkmod = check_module($modname)
   if (-not $checkmod) {
       return
   }
   $modname = add_hs($modname)
   write-host "Module name: $modname."
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

function remake_module  {
    param (
        [string]
        $str1,

        [string]
        $str2
    )


   $new_moddir = "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\" + $str1 
   new-item $new_moddir -itemtype directory
   $new_modfile = "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\" + $str1 + "\" + $str1 + ".psm1"
   $old_modfile = "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\" + $str2 + "\" + $str2 + ".psm1"
   $old_moddir = "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\" + $str2
   copy-item $old_modfile $new_modfile
   remove-item  $old_modfile
   remove-item $old_moddir
}




function rename_module {
    $old_modname = read-host 'Enter the module you wish to rename'
    $modflag = check_name($old_modname)
    if ($modflag -eq 0) {
        write-host "module cannot be found. exiting program."
        return
    }
    $shieldflag = check_shields($old_modname) 
    if ($shieldflag -eq 1) {
        write-host "module is shielded and cannot be changed. exiting program."
        return
    }

    $new_modname = read-host "Enter your new module name"
       $checkmod = check_module($new_modname)
   if (-not $checkmod) {
       return
   }
   $new_modname = add_hs($new_modname)
   write-host "Module name: $new_modname."
   $ans = read-host "Would you like to proceed with your module name(Enter [Y] for Yes or [N] for No)?"
   if ($ans -match 'y|yes|yeah|yup') {
      #chill out.
   }
   elseif ($ans -match 'n|no|nope') {
       $ans2 = read-host "press '1' to re-enter module name or any other key to exit."
       if ($ans2 -eq 1) 
       {rename_module
           return 
           }
           return
       }
   else {
       write-host " Exiting program..."
       return
   }
   $remake_parameters = @{
    str1 = $new_modname
    str2 = $old_modname
}

    remake_module @remake_parameters
    remove_from_profile($old_modname)
    add_module_to_profile($new_modname)

}

