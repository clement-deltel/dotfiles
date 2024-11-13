#requires -version 5.1
<#
.SYNOPSIS
  Initialize a Windows clean install machine following my configuration.
.DESCRIPTION
  Replicates my machine configuration as identical as possible with:
  - Chocolatey packages
  - winget packages
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        1.0
  Author:         Clement Deltel
  Creation Date:  2024-11-13
  Purpose/Change: Initial script development

.EXAMPLE
  ./init.ps1
#>

#------------------------------[Execution]------------------------------

# Packages
packages/chocolatey.ps1 init
packages/winget.ps1 init
