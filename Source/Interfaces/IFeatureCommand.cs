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
    public class FeatureCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("n", "name")]
        [CommandHelp("Name - the name of the source. Required with actions other than list. Defaults to empty.")]
        public string Name;

    }

}