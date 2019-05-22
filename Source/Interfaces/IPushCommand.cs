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
    public class PinCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("n", "name")]
        [CommandHelp("Name - the name of the package. Required with some actions. Defaults to empty.")]
        public string Name;

        [CommandAlias("version")]
        [CommandHelp("Version - Used when multiple versions of a package are installed.  Defaults to empty.")]
        public string Version;

    }

}