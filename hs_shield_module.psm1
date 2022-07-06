function shield_module {
    $filepath = 'c:\users\hslater\shielded_modules.txt'
    $modname = read-host "Enter Module to be shielded"
    $mod_flag = check_if_mod_exists($modname)
    if ($modflag -eq 0) {
        write-host "The module entered does not exist. Exiting program..."
        return
    }
    add-content $filepath $modname
}

function check_shields($str) {
        $file_flag = 0
        $filepath = 'c:\users\hslater\shielded_modules.txt'
        $file_content = get-content $filepath
        foreach ($line in $file_content) {
            if ($line -match $str) {
                $file_flag = 1;
                return $file_flag
            }
        }
        return $file_flag
}

function unshield_module {
    $filepath = 'c:\users\hslater\shielded_modules.txt'
    $file_content = get-content $filepath
    $updated_file_content = @()
    $modname = read-host "Enter Module to be unshielded"
    foreach ($line in $file_content) {
        if ($line -notmatch $modname) {
            $updated_file_content += $line
        }
    }
    set-content -path $filepath -value $updated_file_content
    write-host "module unshielded."
}
