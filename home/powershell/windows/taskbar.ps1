#requires -version 5.1
<#
.SYNOPSIS
  .
.DESCRIPTION
  .
.PARAMETER tag
  Specify behavior of the script. Possible values: init, backup
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        1.0
  Author:         Clement Deltel
  Creation Date:  2024-12-17
  Purpose/Change: Initial script development

.EXAMPLE
  ./taskbar.ps1 init work
  ./taskbak.ps1 backup work
#>


#------------------------------[Declarations]---------------------------
$tag = args[0]

#------------------------------[Execution]------------------------------

If( $tag -eq "init" )
{
  cmd /c reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ /v LayoutXMLPath /d C:\Windows\OEM\TaskbarLayoutModification.xml
}
Else If( $tag -eq "backup" )
{

}
