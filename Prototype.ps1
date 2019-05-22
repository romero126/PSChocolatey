
#ls $PSScriptRoot\Module\PSChocolatey\bin\x86\
Add-Type -path $PSScriptRoot\Module\PSChocolatey\bin\x86\PSChocolatey.dll
Add-Type -path $PSScriptRoot\Module\PSChocolatey\bin\x86\Chocolatey.dll

[PSChoco.Interfaces.Helper].DeclaredMethods | ft
[PSChoco.Interfaces.Helper]::temp_call()
return
#[PSChoco.Interfaces.Helper]::temp_call();
#
#[ChocolateyInstallCommand]
#[PSChoco.Interfaces.Action]::Install()
#[chocolatey.infrastructure.app.commands.ChocolateyInstallCommand]
#ls Source\Interfaces\Template.cs

#$ASM = [chocolatey.Lets].Assembly
#$asm.GetExportedTypes() | ? FullName -Like "chocolatey.infrastructure.app.commands*" | % { 
#    #write-host $_.Name.Replace("Chocolatey", "")
#    Copy-Item Source\Interfaces\Template.cs ("Source\Interfaces\I{0}.cs" -f $_.Name.Replace("Chocolatey", ""))
#
#}
#[chocolatey.infrastructure.app.commands]

#return
$CommandName = [chocolatey.infrastructure.app.commands.ChocolateyVersionCommand]

$commands = [PSChoco.Interfaces.Helper]::temp_getcommand($CommandName);
. {
    "public class {0}Configuration : CommandConfiguration" -f $CommandName.Name.Replace("Chocolatey", "")
    "{"
    foreach ($command in $commands) {
        $Prototype = $command.Prototype.Split("|").Replace("=", "")
        $typeface =
            if ($Command.Prototype.Contains("=")) {
                "string"
            }
            else 
            {
                "boolean"
            }

        "`t[CommandAlias(`"{0}`")]" -f ($Prototype -Join '", "' )
        "`t[CommandHelp(`"{0}`")]" -f $command.Description.Replace('"', '\"');
        "`tpublic {0} {1};" -f $typeface, (Get-Culture).TextInfo.ToTitleCase(([string[]]$ProtoType)[-1]).Replace("-", "") 
        ""

    }
    "}"
} | clip






#[PSChoco.Interfaces.InstallCommandConfiguration].GetMembers()



return


return

$Result = [PSChoco.Interfaces.Choco]::Initialize()


$Result.GetType().FullName

$Result[0].ToString()
return
$Script:Chocolatey = @{
    Chocolatey = [PSChoco.Interfaces.Choco]::Chocolatey
    Commands = @{}
}
$Script:Chocolatey.Container = $Chocolatey.Chocolatey.Container()
$TypeSearch = $Script:Chocolatey.Container.GetCurrentRegistrations().ServiceType | Where-Object FullName -like "*IEnumerable*ICommand*"
$TypeSearch.FullName
$Script:Chocolatey.CommandList = $Chocolatey.Container.GetInstance($TypeSearch)

$Commands = $Chocolatey.Container.GetInstance($TypeSearch)
foreach ($Command in $Commands)
{
    $CommandName = $Command.ToString().Split(".")[-1].Replace("Chocolatey", "").Replace("Command", "")
    $Script:Chocolatey.Commands[$CommandName] = $Command
}


return
#$Container = [PSChoco.Interfaces.Choco]::Chocolatey.Container()
#$Container

