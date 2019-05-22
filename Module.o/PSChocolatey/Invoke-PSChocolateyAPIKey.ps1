function Invoke-PSChocolateyAPIKey
{
    [CmdletBinding()]    
    param(
        [Parameter( HelpMessage = "Source [REQUIRED] - The source location for the key")]
        [String] $Source,
        
        [Parameter( HelpMessage = "ApiKey - The API key for the source. This is the authentication that identifies you and allows you to push to a source. With some sources this is either a key or it could be a user name and password specified as 'user:password'.")]
        [String] $ApiKey,
        
        [Parameter( HelpMessage = "Removes an API key from Chocolatey")]
        [Switch] $Remove
    )
    #Configuration to pass to the object
    $config = [chocolatey.infrastructure.app.configuration.ChocolateyConfiguration]::new()

    # Source
    $config.Sources = $Source
    
    # ApiKey
    $config.ApiKeyCommand.Key = $ApiKey
    
    # Remove
    $config.ApiKeyCommand.Remove = $remove;

    $Script:Chocolatey.Commands["ApiKey"].Run($Config)
}