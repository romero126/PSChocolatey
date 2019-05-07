$Items = Get-ChildItem "$PSScriptRoot\*.ps1" -Recurse 

foreach ($Item in $Items)
{
    . $Item
}