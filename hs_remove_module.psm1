<#
Allows the user to remove a module at the command line.
1. prompt user to remove module.
2. check if module exists.
3. close module from the current session.
4. remove module from profile
5. go to modules path -> remove module directory and module file.
6. restart powershell session
#>





function check_if_mod_exists($str) {
    mods
    $x = get-childitem
    $flag = 0  
    foreach ($item in $x) {
        if ($item.name -eq $str) {
           $flag = 1
           return $flag
        }
    }
    return $flag

}
function remove_from_profile($str) {
    $profile_path = "c:\windows\system32\windowspowershell\v1.0\profile.ps1"
    $profile_content = get-content $profile_path
    $updated_profile_content = @()
    foreach($line in $profile_content) {
        if ($line -notmatch $str) {
            $updated_profile_content += $line        
    }
    }
    set-content -path $profile_path -value $updated_profile_content
   
}



function remove_module {
    $modname = read-host "Enter the module you wish to be removed"
    $modcheck = check_if_mod_exists($modname)
    if ($modcheck) {
        $ans = read-host "Would you like to proceed with removing $modname?(Enter [Y] for Yes or [N] for No)?" 
        if ($ans -match 'y|yes|yeah|yup') {
            #chill out.
         }
         else {
             write-host " Exiting program..."
             return
         }
        
    }
    else {
      
        write-host "The module entered does not exist. Exiting program..."
        return
    }
    <#We have confirmed that the user has entered a valid module. now we can remove it.#>
    $mod_file = "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\" + $modname + "\" + $modname + ".psm1"
    $mod_dir = "C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules\" + $modname 
    remove-item $mod_file
    remove-item $mod_dir
    remove_from_profile($modname)
}

