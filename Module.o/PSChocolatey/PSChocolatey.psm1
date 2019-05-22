$Items = Get-ChildItem "$PSScriptRoot\*.ps1" -Recurse 

class TagAttribute : Attribute { [string[]] $TagName }


foreach ($Item in $Items)
{
    . $Item
}