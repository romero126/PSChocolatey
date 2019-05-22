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
    public class ConfigCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("name")]
        [CommandHelp("Name - the name of the config setting. Required with some actions. Defaults to empty.")]
        public string Name;

        [CommandAlias("value")]
        [CommandHelp("Value - the value of the config setting. Required with some actions. Defaults to empty.")]
        public string Value;

    }

}