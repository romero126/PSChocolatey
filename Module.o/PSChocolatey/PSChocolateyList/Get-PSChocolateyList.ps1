function Get-PSChocolateyList
{
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $False, HelpMessage = "Source - Source location for install. Can use special 'webpi' or 'windowsfeatures' sources. Defaults to sources.")]
		[System.String] $Source,

		[Parameter(Mandatory = $False, HelpMessage = "LocalOnly - Only search against local machine items.")]
		[Switch] $LocalOnly,

		[Parameter(Mandatory = $False, HelpMessage = "Id Only - Only return Package Ids in the list results. Available in 0.10.6+.")]
		[Switch] $IdOnly,

		[Parameter(Mandatory = $False, HelpMessage = "Prerelease - Include Prereleases? Defaults to false.")]
		[Switch] $Prerelease,

		[Parameter(Mandatory = $False, HelpMessage = "IncludePrograms - Used in conjunction with LocalOnly, filters out apps chocolatey has listed as packages and includes those in the list. Defaults to false.")]
		[Switch] $IncludePrograms,

		[Parameter(Mandatory = $False, HelpMessage = "AllVersions - include results from all versions.")]
		[Switch] $AllVersions,

		[Parameter(Mandatory = $False, HelpMessage = "Version - Specific version of a package to return.")]
		[System.String] $Version,

		[Parameter(Mandatory = $False, HelpMessage = "User - used with authenticated feeds. Defaults to empty.")]
		[System.String] $User,

		[Parameter(Mandatory = $False, HelpMessage = "Password - the user's password to the source. Defaults to empty.")]
		[System.String] $Password,

		[Parameter(Mandatory = $False, HelpMessage = "Client certificate - PFX pathname for an x509 authenticated feeds. Defaults to empty. Available in 0.9.10+.")]
		[System.String] $Cert,

		[Parameter(Mandatory = $False, HelpMessage = "Certificate Password - the client certificate's password to the source. Defaults to empty. Available in 0.9.10+.")]
		[System.String] $Certpassword,

		[Parameter(Mandatory = $False, HelpMessage = "Page - the 'page' of results to return. Defaults to return all results. Available in 0.9.10+.")]
		[System.String] $Page,

		[Parameter(Mandatory = $False, HelpMessage = "Page Size - the amount of package results to return per page. Defaults to 25. Available in 0.9.10+.")]
		[System.String] $PageSize,

		[Parameter(Mandatory = $False, HelpMessage = "Exact - Only return packages with this exact name. Available in 0.9.10+.")]
		[Switch] $Exact,

		[Parameter(Mandatory = $False, HelpMessage = "ByIdOnly - Only return packages where the id contains the search filter. Available in 0.9.10+.")]
		[Switch] $ByIdOnly,

		[Parameter(Mandatory = $False, HelpMessage = "ByTagOnly - Only return packages where the search filter matches on the tags. Available in 0.10.6+.")]
		[Switch] $ByTagsOnly,

		[Parameter(Mandatory = $False, HelpMessage = "IdStartsWith - Only return packages where the id starts with the search filter. Available in 0.9.10+.")]
		[Switch] $IdStartsWith,

		[Parameter(Mandatory = $False, HelpMessage = "OrderByPopularity - Sort by package results by popularity. Available in 0.9.10+.")]
		[Switch] $OrderByPopularity,

		[Parameter(Mandatory = $False, HelpMessage = "ApprovedOnly - Only return approved packages - this option will filter out results not from the community repository. Available in 0.9.10+.")]
		[Switch] $ApprovedOnly,

		[Parameter(Mandatory = $False, HelpMessage = "DownloadCacheAvailable - Only return packages that have a download cache available - this option will filter out results not from the community repository. Available in 0.9.10+.")]
		[Switch] $DownloadCacheOnly,

		[Parameter(Mandatory = $False, HelpMessage = "NotBroken - Only return packages that are not failing testing - this option only filters out failing results from the community feed. It will not filter against other sources. Available in 0.9.10+.")]
		[Switch] $NotBroken,

		[Parameter(Mandatory = $False, HelpMessage = "Detailed - Alias for verbose. Available in 0.9.10+.")]
		[Switch] $Detailed
	)

   $Command = $Script:Chocolatey.Commands["List"]
   $OptionSet = [chocolatey.infrastructure.commandline.OptionSet]::new()
   $Config = [chocolatey.infrastructure.app.configuration.ChocolateyConfiguration]::new()
   $Config.SourceCommand.Command = [chocolatey.infrastructure.app.domain.SourceCommandType]::List
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
   $Command.List($Config)
}
