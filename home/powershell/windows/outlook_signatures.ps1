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
  ./signatures.ps1 init work
  ./signatures.ps1 backup work
#>


#------------------------------[Declarations]---------------------------
$tag = args[0]
$machine = args[1]

$username = $Env:UserName
$signaturesDirectory = "C:\Users\$username\AppData\Roaming\Microsoft\Signatures"
$localBackupDirectory = "C:\Temp"

#------------------------------[Execution]------------------------------

If( $tag -eq "init" )
{

}
Else If( $tag -eq "backup" )
{
  # Construct the zip file name
  $zipFileName = "signatures.zip"
  $zipFilePath = Join-Path -Path $localBackupDirectory -ChildPath $zipFileName

  # Compress the directory into a zip file using 7-Zip
  & 7z a -r -tzip $zipFilePath $signaturesDirectory\*

  # Upload the zip file to AWS S3 bucket using AWS CLI
  aws s3 cp $zipFilePath s3://machine-$machine --profile personal

  # Clean up the local backup directory by removing the zip file
  Remove-Item $zipFilePath
}
