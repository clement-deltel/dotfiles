#requires -version 5.1
<#
.SYNOPSIS
  Install winget packages.
.DESCRIPTION
  Replicates my work laptop configuration as identical as possible with:
  - Chocolatey packages
  - Other softwares
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
  ./packages/winget.ps1 init
  ./packages/winget.ps1 update
#>

#------------------------------[Declarations]---------------------------
$tag = args[0]

#------------------------------[Execution]------------------------------

# Apps
If( $tag -eq "init" )
{
  # Rainmeter
  winget install Rainmeter --override "/S /AUTOSTARTUP=1 /RESTART=1"

  {{- if eq .machine "personal" }}
  # Netflix
  winget install --exact --id=9WZDNCRFJ3TJ --interactive --source=msstore

  {{- else if eq .machine "work" }}
  # PDF Merger & Splitter
  winget install --exact --id=9P4TCNS9H432 --interactive --source=msstore
  {{- end }}
}
Else If( $tag -eq "update" )
{
  # Rainmeter
  winget upgrade Rainmeter

  {{- if eq .machine "personal" }}
  # Netflix
  winget upgrade --exact --id=9WZDNCRFJ3TJ --interactive --source=msstore

  {{- else if eq .machine "work" }}
  # PDF Merger & Splitter
  winget upgrade --exact --id=9P4TCNS9H432 --interactive --source=msstore
}
