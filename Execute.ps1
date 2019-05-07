Import-Module "$PSScriptRoot\Module\PSChocolatey\PSChocolatey.psm1" -force

Open-PSChocolatey
Get-PSChocolateySources
Get-PSChocolateyList -LocalOnly