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
    public class ApiKeyCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("s", "source")]
        [CommandHelp("Source [REQUIRED] - The source location for the key")]
        public string Source;

        [CommandAlias("k", "key", "apikey", "api-key")]
        [CommandHelp("ApiKey - The API key for the source. This is the authentication that identifies you and allows you to push to a source. With some sources this is either a key or it could be a user name and password specified as 'user:password'.")]
        public string ApiKey;

        [CommandAlias("rem", "remove")]
        [CommandHelp("Removes an API key from Chocolatey")]
        public bool Remove;

    }
}