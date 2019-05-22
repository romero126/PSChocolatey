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
    public class PackCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("version")]
        [CommandHelp("Version - The version you would like to insert into the package.")]
        public string Version;

        [CommandAlias("out", "outdir", "outputdirectory", "output-directory")]
        [CommandHelp("OutputDirectory - Specifies the directory for the created Chocolatey package file. If not specified, uses the current directory.")]
        public string OutputDirectory;

    }

}