#requires -version 5.1
<#
.SYNOPSIS
  Install winget packages.
.DESCRIPTION
  Install the packages listed below, not supported in Chocolatey.
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
  Creation Date:  2024-07-02
  Purpose/Change: Initial script development

.EXAMPLE
  ./packages/winget.ps1 init work
  ./packages/winget.ps1 update work
#>

#------------------------------[Declarations]---------------------------
$tag = args[0]
$machine = args[1]

$appleDevicesId = "9NP83LWLPZ9K"
$intelUnisonId = "9PP9GZM2GN26"
$netflixId = "9WZDNCRFJ3TJ"
$trelloId = "XPDNKNDN77T0DP"
$winToysId="9P8LTPGCBZXD"

#------------------------------[Execution]------------------------------

# Apps
If( $tag -eq "init" )
{
  winget install --exact --id Rainmeter.Rainmeter --interactive --override "/S /AUTOSTARTUP=1 /RESTART=1"

  If( $machine -eq "personal" )
  {
    winget install --exact --id $netflixId --interactive --source msstore
  }
  Else If( $machine -eq "work" )
  {
    winget install --exact --id Google.IAPDesktop --interactive
    winget install --exact --id Microsoft.Sysinternals --interactive
    winget install --exact --id Wacom.WacomTabletDriver --interactive

    winget install --exact --id $appleDevicesId --interactive --source msstore
    winget install --exact --id $intelUnisonId --interactive --source msstore
    winget install --exact --id $trelloId --interactive --source msstore
    winget install --exact --id $winToysId --interactive --source msstore
  }
}
Else If( $tag -eq "update" )
{
  winget upgrade --exact --id Rainmeter.Rainmeter --interactive

  If( $machine -eq "personal" )
  {
    winget upgrade --exact --id $netflixId --interactive --source msstore
  }
  Else If( $machine -eq "work" )
  {
    winget upgrade --exact --id twpayne.chezmoi --interactive

    winget upgrade --exact --id Google.IAPDesktop --interactive
    winget upgrade --exact --id Microsoft.Sysinternals --interactive
    winget upgrade --exact --id Wacom.WacomTabletDriver --interactive

    winget upgrade --exact --id $appleDevicesId --interactive --source msstore
    winget upgrade --exact --id $intelUnisonId --interactive --source msstore
    winget upgrade --exact --id $trelloId --interactive --source msstore
    winget upgrade --exact --id $winToysId --interactive --source msstore
  }
}
