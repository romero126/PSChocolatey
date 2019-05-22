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
    public class InstallCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("s", "source")]
        [CommandHelp("Source - The source to find the package(s) to install. Special sources include: ruby, webpi, cygwin, windowsfeatures, and python. To specify more than one source, pass it with a semi-colon separating the values (e.g. \"'source1;source2'\"). Defaults to default feeds.")]
        public string Source;

        [CommandAlias("version")]
        [CommandHelp("Version - A specific version to install. Defaults to unspecified.")]
        public string Version;

        [CommandAlias("pre", "prerelease")]
        [CommandHelp("Prerelease - Include Prereleases? Defaults to false.")]
        public bool Prerelease;

        [CommandAlias("x86", "forcex86")]
        [CommandHelp("ForceX86 - Force x86 (32bit) installation on 64 bit systems. Defaults to false.")]
        public bool Forcex86;

        [CommandAlias("ia", "installargs", "installarguments", "install-arguments")]
        [CommandHelp("InstallArguments - Install Arguments to pass to the native installer in the package. Defaults to unspecified.")]
        public string InstallArguments;

        [CommandAlias("o", "override", "overrideargs", "overridearguments", "override-arguments")]
        [CommandHelp("OverrideArguments - Should install arguments be used exclusively without appending to current package passed arguments? Defaults to false.")]
        public bool OverrideArguments;

        [CommandAlias("notsilent", "not-silent")]
        [CommandHelp("NotSilent - Do not install this silently. Defaults to false.")]
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

        [CommandAlias("allowdowngrade", "allow-downgrade")]
        [CommandHelp("AllowDowngrade - Should an attempt at downgrading be allowed? Defaults to false.")]
        public bool AllowDowngrade;

        [CommandAlias("m", "sxs", "sidebyside", "side-by-side", "allowmultiple", "allow-multiple", "allowmultipleversions", "allow-multiple-versions")]
        [CommandHelp("AllowMultipleVersions - Should multiple versions of a package be installed? Defaults to false.")]
        public bool AllowMultipleVersions;

        [CommandAlias("i", "ignoredependencies", "ignore-dependencies")]
        [CommandHelp("IgnoreDependencies - Ignore dependencies when installing package(s). Defaults to false.")]
        public bool IgnoreDependencies;

        [CommandAlias("x", "forcedependencies", "force-dependencies")]
        [CommandHelp("ForceDependencies - Force dependencies to be reinstalled when force installing package(s). Must be used in conjunction with --force. Defaults to false.")]
        public bool ForceDependencies;

        [CommandAlias("n", "skippowershell", "skip-powershell", "skipscripts", "skip-scripts", "skip-automation-scripts")]
        [CommandHelp("Skip Powershell - Do not run chocolateyInstall.ps1. Defaults to false.")]
        public bool SkipAutomationScripts;

        [CommandAlias("u", "user")]
        [CommandHelp("User - used with authenticated feeds. Defaults to empty.")]
        public string User;

        [CommandAlias("p", "password")]
        [CommandHelp("Password - the user's password to the source. Defaults to empty.")]
        public string Password;

        [CommandAlias("cert")]
        [CommandHelp("Client certificate - PFX pathname for an x509 authenticated feeds. Defaults to empty. Available in 0.9.10+.")]
        public string Cert;

        [CommandAlias("cp", "certpassword")]
        [CommandHelp("Certificate Password - the client certificate's password to the source. Defaults to empty. Available in 0.9.10+.")]
        public string Certpassword;

        [CommandAlias("ignorechecksum", "ignore-checksum", "ignorechecksums", "ignore-checksums")]
        [CommandHelp("IgnoreChecksums - Ignore checksums provided by the package. Overrides the default feature 'checksumFiles' set to 'True'. Available in 0.9.9.9+.")]
        public bool IgnoreChecksums;

        [CommandAlias("allowemptychecksum", "allowemptychecksums", "allow-empty-checksums")]
        [CommandHelp("Allow Empty Checksums - Allow packages to have empty/missing checksums for downloaded resources from non-secure locations (HTTP, FTP). Use this switch is not recommended if using sources that download resources from the internet. Overrides the default feature 'allowEmptyChecksums' set to 'False'. Available in 0.10.0+.")]
        public bool AllowEmptyChecksums;

        [CommandAlias("allowemptychecksumsecure", "allowemptychecksumssecure", "allow-empty-checksums-secure")]
        [CommandHelp("Allow Empty Checksums Secure - Allow packages to have empty checksums for downloaded resources from secure locations (HTTPS). Overrides the default feature 'allowEmptyChecksumsSecure' set to 'True'. Available in 0.10.0+.")]
        public bool AllowEmptyChecksumsSecure;

        [CommandAlias("requirechecksum", "requirechecksums", "require-checksums")]
        [CommandHelp("Require Checksums - Requires packages to have checksums for downloaded resources (both non-secure and secure). Overrides the default feature 'allowEmptyChecksums' set to 'False' and 'allowEmptyChecksumsSecure' set to 'True'. Available in 0.10.0+.")]
        public bool RequireChecksums;

        [CommandAlias("checksum", "downloadchecksum", "download-checksum")]
        [CommandHelp("Download Checksum - a user provided checksum for downloaded resources for the package. Overrides the package checksum (if it has one).  Defaults to empty. Available in 0.10.0+.")]
        public string DownloadChecksum;

        [CommandAlias("checksum64", "checksumx64", "downloadchecksumx64", "download-checksum-x64")]
        [CommandHelp("Download Checksum 64bit - a user provided checksum for 64bit downloaded resources for the package. Overrides the package 64-bit checksum (if it has one). Defaults to same as Download Checksum. Available in 0.10.0+.")]
        public string DownloadChecksumX64;

        [CommandAlias("checksumtype", "checksum-type", "downloadchecksumtype", "download-checksum-type")]
        [CommandHelp("Download Checksum Type - a user provided checksum type. Overrides the package checksum type (if it has one). Used in conjunction with Download Checksum. Available values are 'md5', 'sha1', 'sha256' or 'sha512'. Defaults to 'md5'. Available in 0.10.0+.")]
        public string DownloadChecksumType;

        [CommandAlias("checksumtype64", "checksumtypex64", "checksum-type-x64", "downloadchecksumtypex64", "download-checksum-type-x64")]
        [CommandHelp("Download Checksum Type 64bit - a user provided checksum for 64bit downloaded resources for the package. Overrides the package 64-bit checksum (if it has one). Used in conjunction with Download Checksum 64bit. Available values are 'md5', 'sha1', 'sha256' or 'sha512'. Defaults to same as Download Checksum Type. Available in 0.10.0+.")]
        public string DownloadChecksumTypeX64;

        [CommandAlias("ignorepackagecodes", "ignorepackageexitcodes", "ignore-package-codes", "ignore-package-exit-codes")]
        [CommandHelp("IgnorePackageExitCodes - Exit with a 0 for success and 1 for non-success, no matter what package scripts provide for exit codes. Overrides the default feature 'usePackageExitCodes' set to 'True'. Available in 0.9.10+.")]
        public bool IgnorePackageExitCodes;

        [CommandAlias("usepackagecodes", "usepackageexitcodes", "use-package-codes", "use-package-exit-codes")]
        [CommandHelp("UsePackageExitCodes - Package scripts can provide exit codes. Use those for choco's exit code when non-zero (this value can come from a dependency package). Chocolatey defines valid exit codes as 0, 1605, 1614, 1641, 3010.  Overrides the default feature 'usePackageExitCodes' set to 'True'. Available in 0.9.10+.")]
        public bool UsePackageExitCodes;

        [CommandAlias("stoponfirstfailure", "stop-on-first-failure", "stop-on-first-package-failure")]
        [CommandHelp("Stop On First Package Failure - stop running install, upgrade or uninstall on first package failure instead of continuing with others. Overrides the default feature 'stopOnFirstPackageFailure' set to 'False'. Available in 0.10.4+.")]
        public bool StopOnFirstPackageFailure;

        [CommandAlias("exitwhenrebootdetected", "exit-when-reboot-detected")]
        [CommandHelp("Exit When Reboot Detected - Stop running install, upgrade, or uninstall when a reboot request is detected. Requires 'usePackageExitCodes' feature to be turned on. Will exit with either 350 or 1604. Overrides the default feature 'exitOnRebootDetected' set to 'False'. Available in 0.10.12+.")]
        public bool ExitWhenRebootDetected;

        [CommandAlias("ignoredetectedreboot", "ignore-detected-reboot")]
        [CommandHelp("Ignore Detected Reboot - Ignore any detected reboots if found. Overrides the default feature 'exitOnRebootDetected' set to 'False'. Available in 0.10.12+.")]
        public bool IgnoreDetectedReboot;

        [CommandAlias("disable-repository-optimizations", "disable-package-repository-optimizations")]
        [CommandHelp("Disable Package Repository Optimizations - Do not use optimizations for reducing bandwidth with repository queries during package install/upgrade/outdated operations. Should not generally be used, unless a repository needs to support older methods of query. When used, this makes queries similar to the way they were done in Chocolatey v0.10.11 and before. Overrides the default feature 'usePackageRepositoryOptimizations' set to 'True'. Available in 0.10.14+.")]
        public bool DisablePackageRepositoryOptimizations;

    }

}