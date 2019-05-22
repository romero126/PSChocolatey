using System;
using System.Management.Automation;
using System.Collections;
using System.Collections.Generic;
using System.Net;
using chocolatey;
using chocolatey.infrastructure.app.commands;
using chocolatey.infrastructure.app.configuration;
using chocolatey.infrastructure.app.domain;
using chocolatey.infrastructure.commandline;

namespace PSChoco.Interfaces {
    public class UninstallCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("s", "source")]
        [CommandHelp("Source - The source to find the package(s) to install. Special sources include: ruby, webpi, cygwin, windowsfeatures, and python. Defaults to default feeds.")]
        public string Source;

        [CommandAlias("version")]
        [CommandHelp("Version - A specific version to uninstall. Defaults to unspecified.")]
        public string Version;

        [CommandAlias("a", "allversions", "all-versions")]
        [CommandHelp("AllVersions - Uninstall all versions? Defaults to false.")]
        public bool AllVersions;

        [CommandAlias("ua", "uninstallargs", "uninstallarguments", "uninstall-arguments")]
        [CommandHelp("UninstallArguments - Uninstall Arguments to pass to the native installer in the package. Defaults to unspecified.")]
        public string UninstallArguments;

        [CommandAlias("o", "override", "overrideargs", "overridearguments", "override-arguments")]
        [CommandHelp("OverrideArguments - Should uninstall arguments be used exclusively without appending to current package passed arguments? Defaults to false.")]
        public bool OverrideArguments;

        [CommandAlias("notsilent", "not-silent")]
        [CommandHelp("NotSilent - Do not uninstall this silently. Defaults to false.")]
        public bool NotSilent;

        [CommandAlias("params", "parameters", "pkgparameters", "packageparameters", "package-parameters")]
        [CommandHelp("PackageParameters - Parameters to pass to the package. Defaults to unspecified.")]
        public string PackageParameters;

        [CommandAlias("argsglobal", "args-global", "installargsglobal", "install-args-global", "applyargstodependencies", "apply-args-to-dependencies", "apply-install-arguments-to-dependencies")]
        [CommandHelp("Apply Install Arguments To Dependencies  - Should install arguments be applied to dependent packages? Defaults to false.")]
        public bool ApplyInstallArgumentsToDependencies;

        [CommandAlias("paramsglobal", "params-global", "packageparametersglobal", "package-parameters-global", "applyparamstodependencies", "apply-params-to-dependencies", "apply-package-parameters-to-dependencies")]
        [CommandHelp("Apply Package Parameters To Dependencies  - Should package parameters be applied to dependent packages? Defaults to false.")]
        public bool ApplyPackageParametersToDependencies;

        [CommandAlias("m", "sxs", "sidebyside", "side-by-side", "allowmultiple", "allow-multiple", "allowmultipleversions", "allow-multiple-versions")]
        [CommandHelp("AllowMultipleVersions - Should multiple versions of a package be installed? Defaults to false.")]
        public bool AllowMultipleVersions;

        [CommandAlias("x", "forcedependencies", "force-dependencies", "removedependencies", "remove-dependencies")]
        [CommandHelp("RemoveDependencies - Uninstall dependencies when uninstalling package(s). Defaults to false.")]
        public bool RemoveDependencies;

        [CommandAlias("n", "skippowershell", "skip-powershell", "skipscripts", "skip-scripts", "skip-automation-scripts")]
        [CommandHelp("Skip Powershell - Do not run chocolateyUninstall.ps1. Defaults to false.")]
        public bool SkipAutomationScripts;

        [CommandAlias("ignorepackagecodes", "ignorepackageexitcodes", "ignore-package-codes", "ignore-package-exit-codes")]
        [CommandHelp("IgnorePackageExitCodes - Exit with a 0 for success and 1 for non-success, no matter what package scripts provide for exit codes. Overrides the default feature 'usePackageExitCodes' set to 'True'. Available in 0.9.10+.")]
        public bool IgnorePackageExitCodes;

        [CommandAlias("usepackagecodes", "usepackageexitcodes", "use-package-codes", "use-package-exit-codes")]
        [CommandHelp("UsePackageExitCodes - Package scripts can provide exit codes. Use those for choco's exit code when non-zero (this value can come from a dependency package). Chocolatey defines valid exit codes as 0, 1605, 1614, 1641, 3010. Overrides the default feature 'usePackageExitCodes' set to 'True'. Available in 0.9.10+.")]
        public bool UsePackageExitCodes;

        [CommandAlias("autouninstaller", "use-autouninstaller")]
        [CommandHelp("UseAutoUninstaller - Use auto uninstaller service when uninstalling. Overrides the default feature 'autoUninstaller' set to 'True'. Available in 0.9.10+.")]
        public bool UseAutouninstaller;

        [CommandAlias("skipautouninstaller", "skip-autouninstaller")]
        [CommandHelp("SkipAutoUninstaller - Skip auto uninstaller service when uninstalling. Overrides the default feature 'autoUninstaller' set to 'True'. Available in 0.9.10+.")]
        public bool SkipAutouninstaller;

        [CommandAlias("failonautouninstaller", "fail-on-autouninstaller")]
        [CommandHelp("FailOnAutoUninstaller - Fail the package uninstall if the auto uninstaller reports and error. Overrides the default feature 'failOnAutoUninstaller' set to 'False'. Available in 0.9.10+.")]
        public bool FailOnAutouninstaller;

        [CommandAlias("ignoreautouninstallerfailure", "ignore-autouninstaller-failure")]
        [CommandHelp("Ignore Auto Uninstaller Failure - Do not fail the package if auto uninstaller reports an error. Overrides the default feature 'failOnAutoUninstaller' set to 'False'. Available in 0.9.10+.")]
        public bool IgnoreAutouninstallerFailure;

        [CommandAlias("stoponfirstfailure", "stop-on-first-failure", "stop-on-first-package-failure")]
        [CommandHelp("Stop On First Package Failure - stop running install, upgrade or uninstall on first package failure instead of continuing with others. Overrides the default feature 'stopOnFirstPackageFailure' set to 'False'. Available in 0.10.4+.")]
        public bool StopOnFirstPackageFailure;

        [CommandAlias("exitwhenrebootdetected", "exit-when-reboot-detected")]
        [CommandHelp("Exit When Reboot Detected - Stop running install, upgrade, or uninstall when a reboot request is detected. Requires 'usePackageExitCodes' feature to be turned on. Will exit with either 350 or 1604.  Overrides the default feature 'exitOnRebootDetected' set to 'False'.  Available in 0.10.12+.")]
        public bool ExitWhenRebootDetected;

        [CommandAlias("ignoredetectedreboot", "ignore-detected-reboot")]
        [CommandHelp("Ignore Detected Reboot - Ignore any detected reboots if found. Overrides the default feature 'exitOnRebootDetected' set to 'False'.  Available in 0.10.12+.")]
        public bool IgnoreDetectedReboot;

    }

}