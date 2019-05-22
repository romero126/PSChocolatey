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
    public class CommandAliasAttribute : Attribute
    {
        public string[] Alias;
        public CommandAliasAttribute(params string[] args)
        {
            Alias = args;
        }
        public string get_alias()
        {
            string result = null;
            foreach(string a in Alias)
            {
                if (string.IsNullOrEmpty(result))
                    result = a;
                if (a.Length > result.Length)
                    result = a;
            }
            return result;
        }
    }

    public class CommandHelpAttribute : Attribute
    {
        public string HelpMessage;
        public CommandHelpAttribute(string args)
        {
            HelpMessage = args;
        }
    }
    public class CommandConfiguration {
        [CommandAlias("d", "debug")]
        public bool Debug;

        [CommandAlias("v", "verbose")]
        public bool Verbose;

        [CommandAlias("trace")]
        public bool Trace;

        [CommandAlias("nocolor", "no-color")]
        public bool NoColor;

        [CommandAlias("acceptlicense", "accept-license")]
        public bool AcceptLicense;

        [CommandAlias("y", "yes", "confirm")]
        public bool Confirm;

        [CommandAlias("noop", "whatif", "what-if")]
        public bool WhatIf;

        [CommandAlias("r", "limitoutput", "limit-output")]
        public bool LimitOutput;

        [CommandAlias("timeout", "execution-timeout")]
        public int LimitTimeout;


        [CommandAlias("c", "cache", "cachelocation", "cache-location")]
        public string CacheLocation;

        [CommandAlias("allowunofficial", "allow-unofficial", "allowunofficialbuild", "allow-unofficial-build")]
        public bool AllowUnofficialBuild;

        [CommandAlias("failstderr", "failonstderr", "fail-on-stderr", "fail-on-standard-error", "fail-on-error-output")]
        public bool FailOnStandardError;
        
        [CommandAlias("use-system-powershell")]
        public bool UseSystemPowerShell;

        [CommandAlias("no-progress")]
        public bool DoNotShowProgress;

        [CommandAlias("proxy")]
        public string Proxy;

        [CommandAlias("proxy-user")]
        public string ProxyUserName;

        [CommandAlias("proxy-password")]
        public string ProxyPassword;

        [CommandAlias("proxy-bypass-list")]
        public string ProxyBypassList;

        [CommandAlias("proxy-bypass-on-local")]
        public bool ProxyBypassOnLocal;

        [CommandAlias("log-file")]
        public string LogFile;

    }
}