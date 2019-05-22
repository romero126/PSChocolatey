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
    public class OutdatedCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("s", "source")]
        [CommandHelp("Source - The source to find the package(s) to install. Special sources include: ruby, webpi, cygwin, windowsfeatures, and python. To specify more than one source, pass it with a semi-colon separating the values (e.g. \"'source1;source2'\"). Defaults to default feeds.")]
        public string Source;

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

        [CommandAlias("ignore-pinned")]
        [CommandHelp("Ignore Pinned - Ignore pinned packages. Defaults to false. Available in 0.10.6+.")]
        public bool IgnorePinned;

        [CommandAlias("ignore-unfound")]
        [CommandHelp("Ignore Unfound Packages - Ignore packages that are not found on the sources used (or the defaults). Overrides the default feature 'ignoreUnfoundPackagesOnUpgradeOutdated' set to 'False'. Available in 0.10.9+.")]
        public bool IgnoreUnfound;

        [CommandAlias("disable-repository-optimizations", "disable-package-repository-optimizations")]
        [CommandHelp("Disable Package Repository Optimizations - Do not use optimizations for reducing bandwidth with repository queries during package install/upgrade/outdated operations. Should not generally be used, unless a repository needs to support older methods of query. When disabled, this makes queries similar to the way they were done in Chocolatey v0.10.11 and before. Overrides the default feature 'usePackageRepositoryOptimizations' set to 'True'. Available in 0.10.14+.")]
        public bool DisablePackageRepositoryOptimizations;

    }

}