function Enable-PSChocolateySource
{
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $False, HelpMessage = "Name - the name of the source. Required with actions other than list. Defaults to empty.")]
		[System.String] $Name,

		[Parameter(Mandatory = $False, HelpMessage = "Source - The source. This can be a folder/file share or an http location. If it is a url, it will be a location you can go to in a browser and it returns OData with something that says Packages in the browser, similar to what you see when you go to https://chocolatey.org/api/v2/. Required with add action. Defaults to empty.")]
		[System.String] $Source,

		[Parameter(Mandatory = $False, HelpMessage = "User - used with authenticated feeds. Defaults to empty.")]
		[System.String] $User,

		[Parameter(Mandatory = $False, HelpMessage = "Password - the user's password to the source. Encrypted in chocolatey.config file.")]
		[System.String] $Password,

		[Parameter(Mandatory = $False, HelpMessage = "Client certificate - PFX pathname for an x509 authenticated feeds. Defaults to empty. Available in 0.9.10+.")]
		[System.String] $Cert,

		[Parameter(Mandatory = $False, HelpMessage = "Certificate Password - the client certificate's password to the source. Defaults to empty. Available in 0.9.10+.")]
		[System.String] $Certpassword,

		[Parameter(Mandatory = $False, HelpMessage = "Priority - The priority order of this source as compared to other sources, lower is better. Defaults to 0 (no priority). All priorities above 0 will be evaluated first, then zero-based values will be evaluated in config file order. Available in 0.9.9.9+.")]
		[System.String] $Priority,

		[Parameter(Mandatory = $False, HelpMessage = "Bypass Proxy - Should this source explicitly bypass any explicitly or system configured proxies? Defaults to false. Available in 0.10.4+.")]
		[Switch] $BypassProxy,

		[Parameter(Mandatory = $False, HelpMessage = "Allow Self-Service - Should this source be allowed to be used with self-service? Requires business edition (v1.10.0+) with feature 'useBackgroundServiceWithSelfServiceSourcesOnly' turned on. Defaults to false. Available in 0.10.4+.")]
		[Switch] $AllowSelfService,

		[Parameter(Mandatory = $False, HelpMessage = "Visible to Administrators Only - Should this source be visible to non-administrators? Requires business edition (v1.12.2+). Defaults to false. Available in 0.10.8+.")]
		[Switch] $AdminOnly
	)

   $Command = $Script:Chocolatey.Commands["Source"]
   $OptionSet = [chocolatey.infrastructure.commandline.OptionSet]::new()
   $Config = [chocolatey.infrastructure.app.configuration.ChocolateyConfiguration]::new()
   $Config.SourceCommand.Command = [chocolatey.infrastructure.app.domain.SourceCommandType]::Enable
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
