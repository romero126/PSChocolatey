function Update-PSChocolateyUpgrade
{
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $False, HelpMessage = "Source - The source to find the package(s) to install. Special sources include: ruby, webpi, cygwin, windowsfeatures, and python. To specify more than one source, pass it with a semi-colon separating the values (e.g. `"'source1;source2'`"). Defaults to default feeds.")]
		[System.String] $Source,

		[Parameter(Mandatory = $False, HelpMessage = "Version - A specific version to install. Defaults to unspecified.")]
		[System.String] $Version,

		[Parameter(Mandatory = $False, HelpMessage = "Prerelease - Include Prereleases? Defaults to false.")]
		[Switch] $Prerelease,

		[Parameter(Mandatory = $False, HelpMessage = "ForceX86 - Force x86 (32bit) installation on 64 bit systems. Defaults to false.")]
		[Switch] $Forcex86,

		[Parameter(Mandatory = $False, HelpMessage = "InstallArguments - Install Arguments to pass to the native installer in the package. Defaults to unspecified.")]
		[System.String] $InstallArguments,

		[Parameter(Mandatory = $False, HelpMessage = "OverrideArguments - Should install arguments be used exclusively without appending to current package passed arguments? Defaults to false.")]
		[Switch] $OverrideArguments,

		[Parameter(Mandatory = $False, HelpMessage = "NotSilent - Do not install this silently. Defaults to false.")]
		[Switch] $NotSilent,

		[Parameter(Mandatory = $False, HelpMessage = "PackageParameters - Parameters to pass to the package. Defaults to unspecified.")]
		[System.String] $PackageParameters,

		[Parameter(Mandatory = $False, HelpMessage = "Apply Install Arguments To Dependencies  - Should install arguments be applied to dependent packages? Defaults to false.")]
		[Switch] $ApplyInstallArgumentsToDependencies,

		[Parameter(Mandatory = $False, HelpMessage = "Apply Package Parameters To Dependencies  - Should package parameters be applied to dependent packages? Defaults to false.")]
		[Switch] $ApplyPackageParametersToDependencies,

		[Parameter(Mandatory = $False, HelpMessage = "AllowDowngrade - Should an attempt at downgrading be allowed? Defaults to false.")]
		[Switch] $AllowDowngrade,

		[Parameter(Mandatory = $False, HelpMessage = "AllowMultipleVersions - Should multiple versions of a package be installed? Defaults to false.")]
		[Switch] $AllowMultipleVersions,

		[Parameter(Mandatory = $False, HelpMessage = "IgnoreDependencies - Ignore dependencies when upgrading package(s). Defaults to false.")]
		[Switch] $IgnoreDependencies,

		[Parameter(Mandatory = $False, HelpMessage = "Skip Powershell - Do not run chocolateyInstall.ps1. Defaults to false.")]
		[Switch] $SkipAutomationScripts,

		[Parameter(Mandatory = $False, HelpMessage = "Fail On Unfound Packages - If a package is not found in sources specified, fail instead of warn.")]
		[Switch] $FailOnUnfound,

		[Parameter(Mandatory = $False, HelpMessage = "Ignore Unfound Packages - Ignore packages that are not found on the sources used (or the defaults). Overrides the default feature 'ignoreUnfoundPackagesOnUpgradeOutdated' set to 'False'. Available in 0.10.9+.")]
		[Switch] $IgnoreUnfound,

		[Parameter(Mandatory = $False, HelpMessage = "Fail On Non-installed Packages - If a package is not already installed, fail instead of installing.")]
		[Switch] $FailOnNotInstalled,

		[Parameter(Mandatory = $False, HelpMessage = "User - used with authenticated feeds. Defaults to empty.")]
		[System.String] $User,

		[Parameter(Mandatory = $False, HelpMessage = "Password - the user's password to the source. Defaults to empty.")]
		[System.String] $Password,

		[Parameter(Mandatory = $False, HelpMessage = "Client certificate - PFX pathname for an x509 authenticated feeds. Defaults to empty. Available in 0.9.10+.")]
		[System.String] $Cert,

		[Parameter(Mandatory = $False, HelpMessage = "Certificate Password - the client certificate's password to the source. Defaults to empty. Available in 0.9.10+.")]
		[System.String] $Certpassword,

		[Parameter(Mandatory = $False, HelpMessage = "IgnoreChecksums - Ignore checksums provided by the package. Overrides the default feature 'checksumFiles' set to 'False'. Available in 0.9.9.9+.")]
		[Switch] $IgnoreChecksums,

		[Parameter(Mandatory = $False, HelpMessage = "Allow Empty Checksums - Allow packages to have empty/missing checksums for downloaded resources from non-secure locations (HTTP, FTP). Use this switch is not recommended if using sources that download resources from the internet. Overrides the default feature 'allowEmptyChecksums' set to 'False'. Available in 0.10.0+.")]
		[Switch] $AllowEmptyChecksums,

		[Parameter(Mandatory = $False, HelpMessage = "Allow Empty Checksums Secure - Allow packages to have empty checksums for downloaded resources from secure locations (HTTPS). Overrides the default feature 'allowEmptyChecksumsSecure' set to 'False'. Available in 0.10.0+.")]
		[Switch] $AllowEmptyChecksumsSecure,

		[Parameter(Mandatory = $False, HelpMessage = "Require Checksums - Requires packages to have checksums for downloaded resources (both non-secure and secure). Overrides the default feature 'allowEmptyChecksums' set to 'False' and 'allowEmptyChecksumsSecure' set to 'False'. Available in 0.10.0+.")]
		[Switch] $RequireChecksums,

		[Parameter(Mandatory = $False, HelpMessage = "Download Checksum - a user provided checksum for downloaded resources for the package. Overrides the package checksum (if it has one).  Defaults to empty. Available in 0.10.0+.")]
		[System.String] $DownloadChecksum,

		[Parameter(Mandatory = $False, HelpMessage = "Download Checksum 64bit - a user provided checksum for 64bit downloaded resources for the package. Overrides the package 64-bit checksum (if it has one). Defaults to same as Download Checksum. Available in 0.10.0+.")]
		[System.String] $DownloadChecksumX64,

		[Parameter(Mandatory = $False, HelpMessage = "Download Checksum Type - a user provided checksum type. Overrides the package checksum type (if it has one). Used in conjunction with Download Checksum. Available values are 'md5', 'sha1', 'sha256' or 'sha512'. Defaults to 'md5'. Available in 0.10.0+.")]
		[System.String] $DownloadChecksumType,

		[Parameter(Mandatory = $False, HelpMessage = "Download Checksum Type 64bit - a user provided checksum for 64bit downloaded resources for the package. Overrides the package 64-bit checksum (if it has one). Used in conjunction with Download Checksum 64bit. Available values are 'md5', 'sha1', 'sha256' or 'sha512'. Defaults to same as Download Checksum Type. Available in 0.10.0+.")]
		[System.String] $DownloadChecksumTypeX64,

		[Parameter(Mandatory = $False, HelpMessage = "IgnorePackageExitCodes - Exit with a 0 for success and 1 for non-success, no matter what package scripts provide for exit codes. Overrides the default feature 'usePackageExitCodes' set to 'False'. Available in 0.9.10+.")]
		[Switch] $IgnorePackageExitCodes,

		[Parameter(Mandatory = $False, HelpMessage = "UsePackageExitCodes - Package scripts can provide exit codes. Use those for choco's exit code when non-zero (this value can come from a dependency package). Chocolatey defines valid exit codes as 0, 1605, 1614, 1641, 3010. Overrides the default feature 'usePackageExitCodes' set to 'False'. Available in 0.9.10+.")]
		[Switch] $UsePackageExitCodes,

		[Parameter(Mandatory = $False, HelpMessage = "Except - a comma-separated list of package names that should not be upgraded when upgrading 'all'. Defaults to empty. Available in 0.9.10+.")]
		[System.String] $Except,

		[Parameter(Mandatory = $False, HelpMessage = "Stop On First Package Failure - stop running install, upgrade or uninstall on first package failure instead of continuing with others. Overrides the default feature 'stopOnFirstPackageFailure' set to 'False'. Available in 0.10.4+.")]
		[Switch] $StopOnFirstPackageFailure,

		[Parameter(Mandatory = $False, HelpMessage = "Skip Packages Not Installed - if a package is not installed, do not install it during the upgrade process. Overrides the default feature 'skipPackageUpgradesWhenNotInstalled' set to 'False'. Available in 0.10.12+.")]
		[Switch] $SkipWhenNotInstalled,

		[Parameter(Mandatory = $False, HelpMessage = "Install Missing Packages When Not Installed - if a package is not installed, install it as part of running upgrade (typically default behavior). Overrides the default feature 'skipPackageUpgradesWhenNotInstalled' set to 'False'. Available in 0.10.12+.")]
		[Switch] $InstallIfNotInstalled,

		[Parameter(Mandatory = $False, HelpMessage = "Exclude Prerelease - Should prerelease be ignored for upgrades? Will be ignored if you pass `--pre`. Available in 0.10.4+.")]
		[Switch] $ExcludePrereleases,

		[Parameter(Mandatory = $False, HelpMessage = "Use Remembered Options for Upgrade - use the arguments and options used during install for upgrade. Does not override arguments being passed at runtime. Overrides the default feature 'useRememberedArgumentsForUpgrades' set to 'False'. Available in 0.10.4+.")]
		[Switch] $UseRememberedOptions,

		[Parameter(Mandatory = $False, HelpMessage = "Ignore Remembered Options for Upgrade - ignore the arguments and options used during install for upgrade. Overrides the default feature 'useRememberedArgumentsForUpgrades' set to 'False'. Available in 0.10.4+.")]
		[Switch] $IgnoreRememberedOptions,

		[Parameter(Mandatory = $False, HelpMessage = "Exit When Reboot Detected - Stop running install, upgrade, or uninstall when a reboot request is detected. Requires 'usePackageExitCodes' feature to be turned on. Will exit with either 350 or 1604.  Overrides the default feature 'exitOnRebootDetected' set to 'False'.  Available in 0.10.12+.")]
		[Switch] $ExitWhenRebootDetected,

		[Parameter(Mandatory = $False, HelpMessage = "Ignore Detected Reboot - Ignore any detected reboots if found. Overrides the default feature 'exitOnRebootDetected' set to 'False'.  Available in 0.10.12+.")]
		[Switch] $IgnoreDetectedReboot
	)

   $Command = $Script:Chocolatey.Commands["Upgrade"]
   $OptionSet = [chocolatey.infrastructure.commandline.OptionSet]::new()
   $Config = [chocolatey.infrastructure.app.configuration.ChocolateyConfiguration]::new()
   $Config.SourceCommand.Command = [chocolatey.infrastructure.app.domain.SourceCommandType]::Update
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
