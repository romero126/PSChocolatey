function Add-PSChocolateyNew
{
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $False, HelpMessage = "AutomaticPackage - Generate automatic package instead of normal. Defaults to false")]
		[Switch] $Automaticpackage,

		[Parameter(Mandatory = $False, HelpMessage = "TemplateName - Use a named template in C:\ProgramData\Chocolatey\templates\templatename instead of built-in template. Available in 0.9.9.9+. Manage templates as packages in 0.9.10+.")]
		[System.String] $TemplateName,

		[Parameter(Mandatory = $False, HelpMessage = "Name [Required]- the name of the package. Can be passed as first parameter without `"--name=`".")]
		[System.String] $Name,

		[Parameter(Mandatory = $False, HelpMessage = "Version - the version of the package. Can also be passed as the property PackageVersion=somevalue")]
		[System.String] $Version,

		[Parameter(Mandatory = $False, HelpMessage = "Maintainer - the name of the maintainer. Can also be passed as the property MaintainerName=somevalue")]
		[System.String] $Maintainer,

		[Parameter(Mandatory = $False, HelpMessage = "OutputDirectory - Specifies the directory for the created Chocolatey package file. If not specified, uses the current directory. Available in 0.9.10+.")]
		[System.String] $OutputDirectory,

		[Parameter(Mandatory = $False, HelpMessage = "BuiltInTemplate - Use the original built-in template instead of any override. Available in 0.9.10+.")]
		[Switch] $UseBuiltInTemplate
	)

   $Command = $Script:Chocolatey.Commands["New"]
   $OptionSet = [chocolatey.infrastructure.commandline.OptionSet]::new()
   $Config = [chocolatey.infrastructure.app.configuration.ChocolateyConfiguration]::new()
   $Config.SourceCommand.Command = [chocolatey.infrastructure.app.domain.SourceCommandType]::Add
   $Command.configure_argument_parser($OptionSet, $Config)
   $Options = $OptionSet | ForEach-Object { [PSCustomObject]@{ Option = $_; Name = $_.ProtoType.Split("|")[-1]; Value = $_.ProtoType.Split("|")[-1].Replace("-","").Replace("=", "") } }
   foreach ($param in $PSBoundParameters.GetEnumerator())
   {
       $ParamMapping = $Options | Where-Object Value -eq $Param.Key
       if ($ParamMapping)
       {
           $OptionContext = [chocolatey.infrastructure.commandline.OptionContext]::new( $OptionSet )
           $OptionContext.OptionName = $ParamMapping.Name
           $OptionContext.Option = $ParamMapping.Option
           $OptionContext.OptionValues.Add($Param.Value)
           $ParamMapping.Option.Invoke($OptionContext)
       }
   }
   $Config.QuietOutput = $true
   $Command.Run($Config)
}
