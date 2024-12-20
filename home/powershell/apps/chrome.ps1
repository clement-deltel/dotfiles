#requires -version 5.1
<#
.SYNOPSIS
  Backup Google Chrome configuration and user data to an AWS S3 bucket.
.DESCRIPTION
  Only runs if Chrome is not running. Create a zip archive of the Google Chrome folder using 7-Zip, and then copy this file to a S3 bucket. Finally, remove the local zip archive.
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
  Creation Date:  2024-02-28
  Purpose/Change: Initial script development

.EXAMPLE
  ./chrome.ps1 init work
  ./chrome.ps1 backup work
#>

#------------------------------[Declarations]---------------------------
$tag = args[0]
$machine = args[1]

$username = $Env:UserName
$chromeUserDataDirectory = "C:\Users\$username\AppData\Local\Google\Chrome"
$localBackupDirectory = "C:\Temp"

#------------------------------[Execution]------------------------------

If( $tag -eq "init" )
{

}
Else If( $tag -eq "backup" )
{
  # Check if the Chrome process is running
  if (Get-Process -Name "chrome" -ErrorAction SilentlyContinue)
  {
      Write-Host "Chrome is currently running. Please close Chrome before running this backup script."
      exit
  }

  # Construct the zip file name
  $zipFileName = "chrome.zip"
  $zipFilePath = Join-Path -Path $localBackupDirectory -ChildPath $zipFileName

  # Compress the Chrome user data directory into a zip file using 7-Zip
  & 7z a -r -tzip $zipFilePath $chromeUserDataDirectory\*

  # Upload the zip file to AWS S3 bucket using AWS CLI
  aws s3 cp $zipFilePath s3://machine-$machine --profile personal

  # Clean up the local backup directory by removing the zip file
  Remove-Item $zipFilePath
}
