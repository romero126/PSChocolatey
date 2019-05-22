using System;

using System.Management.Automation;
using System.Collections;
using System.Collections.Generic;
using System.Net;

namespace PSChoco.PowerShell.Commands {

    #region Install
    /// <summary>
    /// Creates a PSAdmin KeyVault.
    /// </summary>
    [Cmdlet(VerbsLifecycle.Install, "PSChocolatey")]
    [OutputType(typeof(System.String))]
    public sealed class InstallPSChocolatey : PSCmdlet
    {
        
    }
    #endregion
}
