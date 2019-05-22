function Get-PSChocolateySources
{
    $Script:Chocolatey.Chocolatey.GetConfiguration().MachineSources
}