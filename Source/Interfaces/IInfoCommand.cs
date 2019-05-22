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
    public class InfoCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("s", "source")]
        [CommandHelp("Source - Source location for install. Can use special 'webpi' or 'windowsfeatures' sources. Defaults to sources.")]
        public string Source;

        [CommandAlias("l", "lo", "localonly", "local-only")]
        [CommandHelp("LocalOnly - Only search against local machine items.")]
        public bool LocalOnly;

        [CommandAlias("version")]
        [CommandHelp("Version - Specific version of a package to return.")]
        public string Version;

        [CommandAlias("pre", "prerelease")]
        [CommandHelp("Prerelease - Include Prereleases? Defaults to false.")]
        public bool Prerelease;

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

    }

}