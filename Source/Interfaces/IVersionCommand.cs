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
    public class VersionCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("s", "source")]
        [CommandHelp("Source - The source to find the package(s) to install. Special sources include: ruby, webpi, cygwin, windowsfeatures, and python. Defaults to default feeds.")]
        public string Source;

        [CommandAlias("lo", "localonly")]
        [CommandHelp("LocalOnly - Only search against local machine items.")]
        public bool Localonly;

        [CommandAlias("pre", "prerelease")]
        [CommandHelp("Prerelease - Include Prereleases? Defaults to false.")]
        public bool Prerelease;

    }

}