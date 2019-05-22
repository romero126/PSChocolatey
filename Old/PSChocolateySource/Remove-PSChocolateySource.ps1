function Remove-PSChocolateySource
{
	[CmdletBinding()]
	param (
		
		[Parameter( HelpMessage = "Name - the name of the source. Required with actions other than list. Defaults to empty.")]
		[String] $Name,
		
		[Parameter( HelpMessage = "Source - The source. This can be a folder/file share or an http location. If it is a url, it will be a location you can go to in a browser and it returns OData with something that says Packages in the browser, similar to what you see when you go to https://chocolatey.org/api/v2/. Required with add action. Defaults to empty.")]
		[String] $Source,
		
		[Parameter( HelpMessage = "User - used with authenticated feeds. Defaults to empty.")]
		[String] $User,
		
		[Parameter( HelpMessage = "Password - the user's password to the source. Encrypted in chocolatey.config file.")]
		[String] $Password,
		
		[Parameter( HelpMessage = "Client certificate - PFX pathname for an x509 authenticated feeds. Defaults to empty. Available in 0.9.10+.")]
		[String] $Cert,
		
		[Parameter( HelpMessage = "Certificate Password - the client certificate's password to the source. Defaults to empty. Available in 0.9.10+.")]
		[String] $Certpassword,
		
		[Parameter( HelpMessage = "Priority - The priority order of this source as compared to other sources, lower is better. Defaults to 0 (no priority). All priorities above 0 will be evaluated first, then zero-based values will be evaluated in config file order. Available in 0.9.9.9+.")]
		[String] $Priority,
		
		[Parameter( HelpMessage = "Bypass Proxy - Should this source explicitly bypass any explicitly or system configured proxies? Defaults to false. Available in 0.10.4+.")]
		[Switch] $BypassProxy,
		
		[Parameter( HelpMessage = "Allow Self-Service - Should this source be allowed to be used with self-service? Requires business edition (v1.10.0+) with feature 'useBackgroundServiceWithSelfServiceSourcesOnly' turned on. Defaults to false. Available in 0.10.4+.")]
		[Switch] $AllowSelfService,
		
		[Parameter( HelpMessage = "Visible to Administrators Only - Should this source be visible to non-administrators? Requires business edition (v1.12.2+). Defaults to false. Available in 0.10.8+.")]
		[Switch] $AdminOnly
	)

	# Configuration to pass to the object
	$config = [chocolatey.infrastructure.app.configuration.ChocolateyConfiguration]::new()

    # Force Command Type
    $Config.SourceCommand.Command = [chocolatey.infrastructure.app.domain.SourceCommandType]::Remove

    # $Name
	$Config.SourceCommand.Name = $Name

	# $Source
	$Config.Sources = $Source

	# $User
	$Config.SourceCommand.Username = $User

	# $Password
	$Config.SourceCommand.Password = $Password

	# $Cert
	$Config.SourceCommand.Certificate = $Cert

	# $Certpassword
	$Config.SourceCommand.CertificatePassword = $Certpassword

	# $Priority
	$Config.SourceCommand.Priority = $Priority

	# $BypassProxy
	$Config.SourceCommand.BypassProxy = $BypassProxy

	# $AllowSelfService
	$Config.SourceCommand.AllowSelfService = $AllowSelfService

	# $AdminOnly
    $Config.SourceCommand.VisibleToAdminsOnly = $AdminOnly
 
    $Config.QuietOutput = $false
    $Script:Chocolatey.Commands["Source"].Run($Config)
}