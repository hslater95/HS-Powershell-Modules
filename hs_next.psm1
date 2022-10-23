function create_page() {
    param(
        [Parameter(Mandatory=$true)]
        [string]$title
    )
    $page = $PROJECT + "\pages\" + $title + ".jsx";
    $styles = $PROJECT + "\styles\" + $title + ".module.css";
    #make the title variable capitalized
    $capitalized_title = $title.Substring(0,1).ToUpper() + $title.Substring(1); 
    New-item -path $page -type file
    New-item -path $styles -type file
    $content = "import styles from '../styles/$title.module.css'" + "`n" + "`n" + "export default function $capitalized_title() {" + "`n" + "return (" + "`n" + "<div>" + "`n" +  "<h1>$capitalized_title</h1>" + "`n" + "</div>" + "`n" + ")" + "`n" + "}";
    Set-Content -Path $page -Value $content
    code $page
}
function create_component() {
    param(
        [Parameter(Mandatory=$true)]
        [string]$title
    )
    $component = $PROJECT + "\components\" + $title + ".jsx";
    $styles = $PROJECT + "\styles\" + $title + ".module.css";
    $capitalized_title = $title.Substring(0,1).ToUpper() + $title.Substring(1); 
    New-item -path $component -type file
    New-item -path $styles -type file
    $content = "import styles from '../styles/$title.module.css'" + "`n" + "`n" + "export default function $capitalized_title() {" + "`n" + "return (" + "`n" + "<div>" + "`n" + "<h1>$capitalized_title</h1>" + "`n" + "</div>" + "`n" + ")" + "`n" + "}";
    Set-Content -Path $component -Value $content
    code $component
}