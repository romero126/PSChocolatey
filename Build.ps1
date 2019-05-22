
$ErrorActionPreference = 'Stop'
$Config = @{}
$Config.ModuleName = Split-Path $PSScriptRoot -Leaf
$Config.Source = "$PSScriptRoot/Source/"
$Config.ModulePath = "$PSScriptRoot/Module/$($Config.ModuleName)/"
$Config.NugetDependencies = @(
    @{
        Name = "Log4Net"
        Source = "https://www.nuget.org/api/v2/package/log4net/1.2.10"
    },
    @{ 
        Name = "Chocolatey.Lib"
        Source = "https://www.nuget.org/api/v2/package/chocolatey.lib/0.10.14-beta-20190321"
    }
)



#region BuildFunctions
function OutText {
    param (
        [Parameter()]
        [String]$Message,

        [Parameter()]
        [ValidateSet("Success", "Failed", "OK", "Warning")]
        [String]$Status,

        [Parameter()]
        [Switch]$NewLine
    )
    begin
    {

    }
    process
    {
        if ($Message) 
        {
            if ($NewLine)
            {
                Write-Host $Message
            }
            else 
            {
                $Message = ("{0} {1}" -f $Message, ("." * 50)).Substring(0,50)
                Write-Host $Message -NoNewLine
            }

        }
        if ($Status)
        {
            Write-Host " [" -NoNewline
            Switch ($Status)
            {
                "Success" {
                    Write-Host "SUCCESS" -ForegroundColor Green -NoNewline
                }
                "OK" {
                    Write-Host "OK" -ForegroundColor Green -NoNewline
                }
                "Warning" {
                    Write-Host "WARNING" -ForegroundColor Yellow -NoNewline
                }
                "Failed" {
                    Write-Host "FAILED" -ForegroundColor Red -NoNewline
                }
            }
            Write-Host "]"
        }
    }
    end
    {

    }
}
#endregion
#region Compiler
function Local:Compile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [System.String]$Path,
        [Parameter(Mandatory)]
        [System.String]$Module,
        [Parameter(Mandatory)]
        [System.String]$Build
    )

    $ReferenceAssemblyManifest = @(
        "System.Data"
        "System.Data.Common"
        "System.ComponentModel.Primitives"
        "System.Management.Automation"
        "System.Text.RegularExpressions"
        "System.Collections"
    )
    
    $ObjectList = Get-ChildItem -Path $Path/*.cs -Recurse
    $ReferencedAssemblies = $ReferenceAssemblyManifest + (get-childitem -Path $PSScriptRoot/Module/$Module/bin/$Build/*.dll -ErrorAction SilentlyContinue)
    Write-Host "Compiling DLL for $Build" -ForegroundColor Cyan
    if ($ObjectList)
    {
        Add-Type -Path $ObjectList -OutputAssembly $PSScriptRoot/Module/$Module/bin/$Build/$Module.dll -ReferencedAssemblies $ReferencedAssemblies
    }
    else
    {
        Write-Host "WARNING: Cannot compile no source files available" -ForegroundColor Red
    }
}
#endregion

Remove-Item -Path $PSScriptRoot/Module -Recurse -ErrorAction SilentlyContinue -Force -Confirm:$false | Out-Null
New-Item -Path $Config.ModulePath -ItemType Directory -ErrorAction SilentlyContinue -Force | Out-Null
Copy-Item "$($Config.Source)*" -Exclude *.cs, "src" -Recurse -Destination $Config.ModulePath -Force

write-host $Config.Source
Compile -Path $Config.Source -Module $Config.ModuleName -Build x86

#Compile -Path $Config.Source -Module $Config.ModuleName -Build 
#Compile -Path $Config.Source -Module $Config.ModuleName -Build mac