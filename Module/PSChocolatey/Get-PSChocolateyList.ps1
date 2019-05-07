function Get-PSChocolateyList
{
    param(
        [Parameter( HelpMessage = "Source - Source location for install. Can use special 'webpi' or 'windowsfeatures' sources. Defaults to sources.")]
        [String] $Source,
        
        [Parameter( HelpMessage = "LocalOnly - Only search against local machine items.")]
        [Switch] $LocalOnly,
        
        [Parameter( HelpMessage = "Id Only - Only return Package Ids in the list results. Available in 0.10.6+.")]
        [Switch] $IdOnly,
        
        [Parameter( HelpMessage = "Prerelease - Include Prereleases? Defaults to false.")]
        [Switch] $Prerelease,
        
        [Parameter( HelpMessage = "IncludePrograms - Used in conjunction with LocalOnly, filters out apps chocolatey has listed as packages and includes those in the list. Defaults to false.")]
        [Switch] $IncludePrograms,
        
        [Parameter( HelpMessage = "AllVersions - include results from all versions.")]
        [Switch] $AllVersions,
        
        [Parameter( HelpMessage = "Version - Specific version of a package to return.")]
        [String] $Version,
        
        [Parameter( HelpMessage = "User - used with authenticated feeds. Defaults to empty.")]
        [String] $User,
        
        [Parameter( HelpMessage = "Password - the user's password to the source. Defaults to empty.")]
        [String] $Password,
        
        [Parameter( HelpMessage = "Client certificate - PFX pathname for an x509 authenticated feeds. Defaults to empty. Available in 0.9.10+.")]
        [String] $Cert,
        
        [Parameter( HelpMessage = "Certificate Password - the client certificate's password to the source. Defaults to empty. Available in 0.9.10+.")]
        [String] $Certpassword,
        
        [Parameter( HelpMessage = "Page - the 'page' of results to return. Defaults to return all results. Available in 0.9.10+.")]
        [Int] $Page,
        
        [Parameter( HelpMessage = "Page Size - the amount of package results to return per page. Defaults to 25. Available in 0.9.10+.")]
        [Int] $PageSize,
        
        [Parameter( HelpMessage = "Exact - Only return packages with this exact name. Available in 0.9.10+.")]
        [Switch] $Exact,
        
        [Parameter( HelpMessage = "ByIdOnly - Only return packages where the id contains the search filter. Available in 0.9.10+.")]
        [Switch] $ByIdOnly,
        
        [Parameter( HelpMessage = "ByTagOnly - Only return packages where the search filter matches on the tags. Available in 0.10.6+.")]
        [Switch] $ByTagsOnly,
        
        [Parameter( HelpMessage = "IdStartsWith - Only return packages where the id starts with the search filter. Available in 0.9.10+.")]
        [Switch] $IdStartsWith,
        
        [Parameter( HelpMessage = "OrderByPopularity - Sort by package results by popularity. Available in 0.9.10+.")]
        [Switch] $OrderByPopularity,
        
        [Parameter( HelpMessage = "ApprovedOnly - Only return approved packages - this option will filter out results not from the community repository. Available in 0.9.10+.")]
        [Switch] $ApprovedOnly,
        
        [Parameter( HelpMessage = "DownloadCacheAvailable - Only return packages that have a download cache available - this option will filter out results not from the community repository. Available in 0.9.10+.")]
        [Switch] $DownloadCacheOnly,
        
        [Parameter( HelpMessage = "NotBroken - Only return packages that are not failing testing - this option only filters out failing results from the community feed. It will not filter against other sources. Available in 0.9.10+.")]
        [Switch] $NotBroken,
        
        [Parameter( HelpMessage = "Detailed - Alias for verbose. Available in 0.9.10+.")]
        [Switch] $Detailed        
    )

    #Configuration to pass to the object
    $config = [chocolatey.infrastructure.app.configuration.ChocolateyConfiguration]::new()
    
    # Source
    $config.Sources = $Source

    # LocalOnly
    $config.ListCommand.LocalOnly = $LocalOnly
    
    # IdOnly
    $config.ListCommand.IdOnly = $IdOnly

    # Prerelease
    $config.Prerelease = $Prerelease

    # IncludePrograms
    $config.ListCommand.IncludeRegistryPrograms = $IncludePrograms

    # AllVersions
    $config.AllVersions = $AllVersions

    # Version
    $config.Version = $Version

    # User
    $config.SourceCommand.Username = $User

    # Password
    $config.SourceCommand.Password = $Password

    # Cert
    $config.SourceCommand.Certificate = $Cert

    # Certpassword
    $config.SourceCommand.CertificatePassword = $Certpassword

    # Page
    $config.ListCommand.Page = $Page;

    # PageSize
    if ($PageSize)
    {
        $config.ListCommand.PageSize = $PageSize
    }


    # Exact
    $config.ListCommand.Exact = $Exact

    # ByIdOnly
    $config.ListCommand.ByIdOnly = $ByIdOnly

    # ByTagsOnly
    $config.ListCommand.ByTagOnly = $ByTagsOnly

    # IdStartsWith
    $config.ListCommand.IdStartsWith = $IdStartsWith

    # OrderByPopularity
    $config.ListCommand.OrderByPopularity = $OrderByPopularity

    # ApprovedOnly
    $config.ListCommand.ApprovedOnly = $ApprovedOnly

    # DownloadCacheOnly
    $config.ListCommand.DownloadCacheAvailable = $DownloadCacheOnly

    # NotBroken
    $config.ListCommand.NotBroken = $NotBroken

    # Detailed
    $config.Verbose = $Detailed

    $Script:Chocolatey.Commands["ListCommand"].List($Config)
}