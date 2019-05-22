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
    public class SourceCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("n", "name")]
        [CommandHelp("Name - the name of the source. Required with actions other than list. Defaults to empty.")]
        public string Name;

        [CommandAlias("s", "source")]
        [CommandHelp("Source - The source. This can be a folder/file share or an http location. If it is a url, it will be a location you can go to in a browser and it returns OData with something that says Packages in the browser, similar to what you see when you go to https://chocolatey.org/api/v2/. Required with add action. Defaults to empty.")]
        public string Source;

        [CommandAlias("u", "user")]
        [CommandHelp("User - used with authenticated feeds. Defaults to empty.")]
        public string User;

        [CommandAlias("p", "password")]
        [CommandHelp("Password - the user's password to the source. Encrypted in chocolatey.config file.")]
        public string Password;

        [CommandAlias("cert")]
        [CommandHelp("Client certificate - PFX pathname for an x509 authenticated feeds. Defaults to empty. Available in 0.9.10+.")]
        public string Cert;

        [CommandAlias("cp", "certpassword")]
        [CommandHelp("Certificate Password - the client certificate's password to the source. Defaults to empty. Available in 0.9.10+.")]
        public string Certpassword;

        [CommandAlias("priority")]
        [CommandHelp("Priority - The priority order of this source as compared to other sources, lower is better. Defaults to 0 (no priority). All priorities above 0 will be evaluated first, then zero-based values will be evaluated in config file order. Available in 0.9.9.9+.")]
        public string Priority;

        [CommandAlias("bypassproxy", "bypass-proxy")]
        [CommandHelp("Bypass Proxy - Should this source explicitly bypass any explicitly or system configured proxies? Defaults to false. Available in 0.10.4+.")]
        public bool BypassProxy;

        [CommandAlias("allowselfservice", "allow-self-service")]
        [CommandHelp("Allow Self-Service - Should this source be allowed to be used with self-service? Requires business edition (v1.10.0+) with feature 'useBackgroundServiceWithSelfServiceSourcesOnly' turned on. Defaults to false. Available in 0.10.4+.")]
        public bool AllowSelfService;

        [CommandAlias("adminonly", "admin-only")]
        [CommandHelp("Visible to Administrators Only - Should this source be visible to non-administrators? Requires business edition (v1.12.2+). Defaults to false. Available in 0.10.8+.")]
        public bool AdminOnly;

    }

}