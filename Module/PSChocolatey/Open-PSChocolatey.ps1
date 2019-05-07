function Open-PSChocolatey {
    $ChocoPath = "$env:SYSTEMDRIVE\ProgramData\Chocolatey\Choco.exe"
    $ASM = [Reflection.Assembly]::LoadFile($ChocoPath)

    $Script:Chocolatey = @{
        Chocolatey = [Chocolatey.GetChocolatey]::New()
        Commands = @{}
    }
    $Script:Chocolatey.Container = $Chocolatey.Chocolatey.Container()
    $TypeSearch = $Script:Chocolatey.Container.GetCurrentRegistrations().ServiceType | Where-Object FullName -like "*IEnumerable*ICommand*"

    $Script:Chocolatey.CommandList = $Chocolatey.Container.GetInstance($TypeSearch)

    $Commands = $Chocolatey.Container.GetInstance($TypeSearch)
    foreach ($Command in $Commands)
    {
        $CommandName = $Command.ToString().Split(".")[-1].Replace("Chocolatey", "")
        $Script:Chocolatey.Commands[$CommandName] = $Command
    }
}