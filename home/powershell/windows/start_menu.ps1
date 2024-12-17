#requires -version 5.1
<#
.SYNOPSIS
  .
.DESCRIPTION
  .
.PARAMETER machine
  Name of the machine.
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
  ./start_menu.ps1 init work
  ./start_menu.ps1 backup work
#>


#------------------------------[Declarations]---------------------------
$tag = args[0]
$machine = args[1]

$localBackupDirectory = "C:\Temp"

#------------------------------[Execution]------------------------------

If( $tag -eq "init" )
{
  # Download the file from AWS S3 bucket using AWS CLI
  aws s3 cp s3://machine-$machine/start_menu.json $localBackupDirectory\start_menu.json --profile personal

  Import-StartLayout -LayoutPath $localBackupDirectory\start_menu.json

  # Clean up the local backup directory by removing the file
  Remove-Item $localBackupDirectory\start_menu.json
}
Else If( $tag -eq "backup" )
{
  Export-StartLayout -Path $localBackupDirectory\start_menu.json

  # Upload the file to AWS S3 bucket using AWS CLI
  aws s3 cp $localBackupDirectory\start_menu.json s3://machine-$machine --profile personal

  # Clean up the local backup directory by removing the file
  Remove-Item $localBackupDirectory\start_menu.json
}
