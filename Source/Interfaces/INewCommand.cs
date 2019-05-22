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
    public class NewCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("a", "auto", "automaticpackage")]
        [CommandHelp("AutomaticPackage - Generate automatic package instead of normal. Defaults to false")]
        public bool Automaticpackage;

        [CommandAlias("t", "template", "template-name")]
        [CommandHelp("TemplateName - Use a named template in C:\\ProgramData\\chocolatey\\templates\\templatename instead of built-in template. Available in 0.9.9.9+. Manage templates as packages in 0.9.10+.")]
        public string TemplateName;

        [CommandAlias("name")]
        [CommandHelp("Name [Required]- the name of the package. Can be passed as first parameter without \"--name=\".")]
        public string Name;

        [CommandAlias("version")]
        [CommandHelp("Version - the version of the package. Can also be passed as the property PackageVersion=somevalue")]
        public string Version;

        [CommandAlias("maintainer")]
        [CommandHelp("Maintainer - the name of the maintainer. Can also be passed as the property MaintainerName=somevalue")]
        public string Maintainer;

        [CommandAlias("out", "outdir", "outputdirectory", "output-directory")]
        [CommandHelp("OutputDirectory - Specifies the directory for the created Chocolatey package file. If not specified, uses the current directory. Available in 0.9.10+.")]
        public string OutputDirectory;

        [CommandAlias("built-in", "built-in-template", "originaltemplate", "original-template", "use-original-template", "use-built-in-template")]
        [CommandHelp("BuiltInTemplate - Use the original built-in template instead of any override. Available in 0.9.10+.")]
        public bool UseBuiltInTemplate;

    }

}