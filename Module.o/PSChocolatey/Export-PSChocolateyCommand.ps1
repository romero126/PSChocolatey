function Export-PSChocolateyCommand {

    param(
        [String]$Name,
        [ValidateSet("Get", "Add", "Remove", "Enable", "Disable", "Install", "Update", "Uninstall")]
        [String]$Verb
    )

    if (-not $Script:Chocolatey.Commands.ContainsKey($Name) )
    {
        Write-Warning "Could not find Name $Name"
    }

    #$Script:Chocolatey.Commands[$Name]
    $Command = $Script:Chocolatey.Commands[$Name]
    $Options = [chocolatey.infrastructure.commandline.OptionSet]::new()
    $Config = [chocolatey.infrastructure.app.configuration.ChocolateyConfiguration]::new()

    $Command.configure_argument_parser($Options, $Config)

    "function {0}-PSChocolatey{1}" -f $Verb, $Name
    "{"
    "`t[CmdletBinding()]"
    "`tparam("
    $Parameters = foreach ($Option in $Options)
    {
        #$Mandatory = if ($option.OptionValueType -eq "Required") { "True" } else { "False" }
        $Mandatory = "False"
        #$PropertyName = $Option.ProtoType.Replace("=", "").Split("|") | Where-Object { $_ -NotMatch "-" } | Sort Count | Select -First 1
        #$PropertyName = $Option.ProtoType.Replace("=", "").Split("|") | Sort Count | Select -First 1
        $PropertyName = (Get-Culture).TextInfo.ToTitleCase($Option.ProtoType.Replace("=", "").Split("|")[-1]).Replace("-", "")
        $PropertyTagName = $Option.ProtoType.Split("|")[-1].Replace("=", "")
        $Type = if ($Option.ProtoType.Contains("=")) { "System.String"} else { "Switch" }
        
        "`t`t[Parameter(Mandatory = `${0}, HelpMessage = `"{1}`")]" -f $Mandatory, $Option.Description.Replace('"', '`"')
        #"`t`t[Reflection.AssemblyMetaDataAttribute(`"Tag`",`"{0}`")]" -f $PropertyTagName
        "`t`t[{0}] `${1}," -f $Type, $PropertyName
        ""
    }
    $Parameters = $Parameters -join "`n"
    $Parameters.Substring(0,$Parameters.Length-2)
    "`t)"
    ""

    $SourceCommandType = switch ($Verb) {
        "Get" { "List" }
        "Install" { "Unknown" }
        "Uninstall" { "Unknown" }
        "Upgrade" { "Unknown" }
        default { $_ }
    }
    '   $Command = $Script:Chocolatey.Commands["{0}"]' -f $Name
    '   $OptionSet = [chocolatey.infrastructure.commandline.OptionSet]::new()'
    '   $Config = [chocolatey.infrastructure.app.configuration.ChocolateyConfiguration]::new()'
    '   $Config.SourceCommand.Command = [chocolatey.infrastructure.app.domain.SourceCommandType]::{0}' -f $SourceCommandType
    '   $Command.configure_argument_parser($OptionSet, $Config)'
    '   $Options = $OptionSet | ForEach-Object { [PSCustomObject]@{ Option = $_; Name = $_.ProtoType.Split("|")[-1]; Value = $_.ProtoType.Split("|")[-1].Replace("-","").Replace("=", "") } }'
    '   foreach ($param in $PSBoundParameters.GetEnumerator())'
    '   {'
    '       $ParamMapping = $Options | Where-Object Value -eq $Param.Key'
    '       if ($ParamMapping)'
    '       {'
    '           $OptionContext = [chocolatey.infrastructure.commandline.OptionContext]::new( $OptionSet )'
    '           $OptionContext.OptionName = $ParamMapping.Name'
    '           $OptionContext.Option = $ParamMapping.Option'
    '           $OptionContext.OptionValues.Add($Param.Value)'
    '           $ParamMapping.Option.Invoke($OptionContext)'
    '       }'
    '   }'
    '   $Config.QuietOutput = $true'
    $Action = if ($Verb -eq "Get") { "List" } else { "Run" }
    "   `$Command.{0}(`$Config)" -f ($Action)


    "}"



}