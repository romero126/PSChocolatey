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
    public class ListCommandConfiguration : CommandConfiguration
    {
        [CommandAlias("s", "source")]
        [CommandHelp("Source - Source location for install. Can use special 'webpi' or 'windowsfeatures' sources. Defaults to sources.")]
        public string Source;

        [CommandAlias("l", "lo", "localonly", "local-only")]
        [CommandHelp("LocalOnly - Only search against local machine items.")]
        public bool LocalOnly;

        [CommandAlias("idonly", "id-only")]
        [CommandHelp("Id Only - Only return Package Ids in the list results. Available in 0.10.6+.")]
        public bool IdOnly;

        [CommandAlias("pre", "prerelease")]
        [CommandHelp("Prerelease - Include Prereleases? Defaults to false.")]
        public bool Prerelease;

        [CommandAlias("i", "includeprograms", "include-programs")]
        [CommandHelp("IncludePrograms - Used in conjunction with LocalOnly, filters out apps chocolatey has listed as packages and includes those in the list. Defaults to false.")]
        public bool IncludePrograms;

        [CommandAlias("a", "all", "allversions", "all-versions")]
        [CommandHelp("AllVersions - include results from all versions.")]
        public bool AllVersions;

        [CommandAlias("version")]
        [CommandHelp("Version - Specific version of a package to return.")]
        public string Version;

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

        [CommandAlias("page")]
        [CommandHelp("Page - the 'page' of results to return. Defaults to return all results. Available in 0.9.10+.")]
        public string Page;

        [CommandAlias("page-size")]
        [CommandHelp("Page Size - the amount of package results to return per page. Defaults to 25. Available in 0.9.10+.")]
        public string PageSize;

        [CommandAlias("e", "exact")]
        [CommandHelp("Exact - Only return packages with this exact name. Available in 0.9.10+.")]
        public bool Exact;

        [CommandAlias("by-id-only")]
        [CommandHelp("ByIdOnly - Only return packages where the id contains the search filter. Available in 0.9.10+.")]
        public bool ByIdOnly;

        [CommandAlias("by-tag-only", "by-tags-only")]
        [CommandHelp("ByTagOnly - Only return packages where the search filter matches on the tags. Available in 0.10.6+.")]
        public bool ByTagsOnly;

        [CommandAlias("id-starts-with")]
        [CommandHelp("IdStartsWith - Only return packages where the id starts with the search filter. Available in 0.9.10+.")]
        public bool IdStartsWith;

        [CommandAlias("order-by-popularity")]
        [CommandHelp("OrderByPopularity - Sort by package results by popularity. Available in 0.9.10+.")]
        public bool OrderByPopularity;

        [CommandAlias("approved-only")]
        [CommandHelp("ApprovedOnly - Only return approved packages - this option will filter out results not from the community repository. Available in 0.9.10+.")]
        public bool ApprovedOnly;

        [CommandAlias("download-cache", "download-cache-only")]
        [CommandHelp("DownloadCacheAvailable - Only return packages that have a download cache available - this option will filter out results not from the community repository. Available in 0.9.10+.")]
        public bool DownloadCacheOnly;

        [CommandAlias("not-broken")]
        [CommandHelp("NotBroken - Only return packages that are not failing testing - this option only filters out failing results from the community feed. It will not filter against other sources. Available in 0.9.10+.")]
        public bool NotBroken;

        [CommandAlias("detail", "detailed")]
        [CommandHelp("Detailed - Alias for verbose. Available in 0.9.10+.")]
        public bool Detailed;

    }

}