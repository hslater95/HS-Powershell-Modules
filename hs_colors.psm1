$host.privatedata.ErrorForegroundColor="Green"
$host.PrivateData.debugforegroundcolor = 'white'
$host.PrivateData.verboseforegroundcolor = 'white'
$host.PrivateData.progressforegroundcolor = 'white'
$host.PrivateData.warningforegroundcolor = 'white'
Set-PSReadlineOption -Colors @{
    Type = "white"
    Member = "white"
    String = "blue"
    Number = "white"
    Comment = "DarkGreen"
    Command = "white"
    Keyword = "magenta"
    Operator = "magenta"
    Variable = "Magenta"
    Parameter = "white"
}
