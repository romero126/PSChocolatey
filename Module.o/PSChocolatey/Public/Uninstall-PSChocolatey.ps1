function Uninstall-PSChocolatey
{
	[CmdletBinding()]
	param(
		[Parameter(Mandatory = $True, Position = 0, HelpMessage = "Package Name - The package(s) to uninstall. Uninstall sources include: chocolatey, winrar, jre8, notepadplusplus")]
		[System.String[]] $PackageName,

		[Parameter(Mandatory = $False, HelpMessage = "Source - The source to find the package(s) to install. Special sources include: ruby, webpi, cygwin, windowsfeatures, and python. Defaults to default feeds.")]
		[System.String] $Source,

		[Parameter(Mandatory = $False, HelpMessage = "Version - A specific version to uninstall. Defaults to unspecified.")]
		[System.String] $Version,

		[Parameter(Mandatory = $False, HelpMessage = "AllVersions - Uninstall all versions? Defaults to false.")]
		[Switch] $AllVersions,

		[Parameter(Mandatory = $False, HelpMessage = "UninstallArguments - Uninstall Arguments to pass to the native installer in the package. Defaults to unspecified.")]
		[System.String] $UninstallArguments,

		[Parameter(Mandatory = $False, HelpMessage = "OverrideArguments - Should uninstall arguments be used exclusively without appending to current package passed arguments? Defaults to false.")]
		[Switch] $OverrideArguments,

		[Parameter(Mandatory = $False, HelpMessage = "NotSilent - Do not uninstall this silently. Defaults to false.")]
		[Switch] $NotSilent,

		[Parameter(Mandatory = $False, HelpMessage = "PackageParameters - Parameters to pass to the package. Defaults to unspecified.")]
		[System.String] $PackageParameters,

		[Parameter(Mandatory = $False, HelpMessage = "Apply Install Arguments To Dependencies  - Should install arguments be applied to dependent packages? Defaults to false.")]
		[Switch] $ApplyInstallArgumentsToDependencies,

		[Parameter(Mandatory = $False, HelpMessage = "Apply Package Parameters To Dependencies  - Should package parameters be applied to dependent packages? Defaults to false.")]
		[Switch] $ApplyPackageParametersToDependencies,

		[Parameter(Mandatory = $False, HelpMessage = "AllowMultipleVersions - Should multiple versions of a package be installed? Defaults to false.")]
		[Switch] $AllowMultipleVersions,

		[Parameter(Mandatory = $False, HelpMessage = "RemoveDependencies - Uninstall dependencies when uninstalling package(s). Defaults to false.")]
		[Switch] $RemoveDependencies,

		[Parameter(Mandatory = $False, HelpMessage = "Skip Powershell - Do not run chocolateyUninstall.ps1. Defaults to false.")]
		[Switch] $SkipAutomationScripts,

		[Parameter(Mandatory = $False, HelpMessage = "IgnorePackageExitCodes - Exit with a 0 for success and 1 for non-success, no matter what package scripts provide for exit codes. Overrides the default feature 'usePackageExitCodes' set to 'False'. Available in 0.9.10+.")]
		[Switch] $IgnorePackageExitCodes,

		[Parameter(Mandatory = $False, HelpMessage = "UsePackageExitCodes - Package scripts can provide exit codes. Use those for choco's exit code when non-zero (this value can come from a dependency package). Chocolatey defines valid exit codes as 0, 1605, 1614, 1641, 3010. Overrides the default feature 'usePackageExitCodes' set to 'False'. Available in 0.9.10+.")]
		[Switch] $UsePackageExitCodes,

		[Parameter(Mandatory = $False, HelpMessage = "UseAutoUninstaller - Use auto uninstaller service when uninstalling. Overrides the default feature 'autoUninstaller' set to 'False'. Available in 0.9.10+.")]
		[Switch] $UseAutouninstaller,

		[Parameter(Mandatory = $False, HelpMessage = "SkipAutoUninstaller - Skip auto uninstaller service when uninstalling. Overrides the default feature 'autoUninstaller' set to 'False'. Available in 0.9.10+.")]
		[Switch] $SkipAutouninstaller,

		[Parameter(Mandatory = $False, HelpMessage = "FailOnAutoUninstaller - Fail the package uninstall if the auto uninstaller reports and error. Overrides the default feature 'failOnAutoUninstaller' set to 'False'. Available in 0.9.10+.")]
		[Switch] $FailOnAutouninstaller,

		[Parameter(Mandatory = $False, HelpMessage = "Ignore Auto Uninstaller Failure - Do not fail the package if auto uninstaller reports an error. Overrides the default feature 'failOnAutoUninstaller' set to 'False'. Available in 0.9.10+.")]
		[Switch] $IgnoreAutouninstallerFailure,

		[Parameter(Mandatory = $False, HelpMessage = "Stop On First Package Failure - stop running install, upgrade or uninstall on first package failure instead of continuing with others. Overrides the default feature 'stopOnFirstPackageFailure' set to 'False'. Available in 0.10.4+.")]
		[Switch] $StopOnFirstPackageFailure,

		[Parameter(Mandatory = $False, HelpMessage = "Exit When Reboot Detected - Stop running install, upgrade, or uninstall when a reboot request is detected. Requires 'usePackageExitCodes' feature to be turned on. Will exit with either 350 or 1604.  Overrides the default feature 'exitOnRebootDetected' set to 'False'.  Available in 0.10.12+.")]
		[Switch] $ExitWhenRebootDetected,

		[Parameter(Mandatory = $False, HelpMessage = "Ignore Detected Reboot - Ignore any detected reboots if found. Overrides the default feature 'exitOnRebootDetected' set to 'False'.  Available in 0.10.12+.")]
		[Switch] $IgnoreDetectedReboot
	)

   $Command = $Script:Chocolatey.Commands["Uninstall"]
   $OptionSet = [chocolatey.infrastructure.commandline.OptionSet]::new()
   $Config = [chocolatey.infrastructure.app.configuration.ChocolateyConfiguration]::new()
   $Config.SourceCommand.Command = [chocolatey.infrastructure.app.domain.SourceCommandType]::Unknown
   $Config.PackageNames = $PackageName -join ";"
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
