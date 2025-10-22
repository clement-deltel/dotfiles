#requires -version 5.1
<#
.SYNOPSIS
  Install powershell modules.
.DESCRIPTION
  Install the modules listed below.
.PARAMETER machine
  Name of the machine.
.PARAMETER tag
  Specify behavior of the script. Possible values: init, update
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        1.0
  Author:         Clement Deltel
  Creation Date:  2025-10-21
  Purpose/Change: Initial script development

.EXAMPLE
  ./packages/powershell.ps1 init work
  ./packages/powershell.ps1 update work
#>

#------------------------------[Declarations]---------------------------
$tag = args[0]
$machine = args[1]

#------------------------------[Execution]------------------------------

If( $tag -eq "init" )
{
  Install-Module -Force -Name PSFzf
}
Else If( $tag -eq "update" )
{
  Install-Module -Force -Name PSFzf
}
