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
  ./wsl.ps1 init work
  ./wsl.ps1 backup work
#>

#------------------------------[Declarations]---------------------------
$tag = args[0]
$machine = args[1]

$distribution = "Ubuntu-22.04"
$localBackupDirectory = "C:\Temp"
$location = "C:\wsl"
$tarFileName = "wsl_ubuntu-22.04.tar"
$gzipFileName = "$tarFileName.gz"

#------------------------------[Execution]------------------------------

If( $tag -eq "init" )
{
  # Build the gzip and tar file paths
  $tarFilePath = Join-Path -Path $localBackupDirectory -ChildPath $tarFileName
  $gzipFilePath = "$tarFilePath.gz"

  # Download the file from AWS S3 bucket using AWS CLI
  aws s3 cp s3://machine-$machine/$gzipFileName $gzipFilePath --profile personal

  # Decompress the gzip file
  & 7z e $gzipFilePath

  # Import the distribution into WSL
  wsl --import $distribution $location $tarFilePath

  # Clean up the local backup directory by removing the files
  Remove-Item $gzipFilePath
  Remove-Item $tarFilePath
}
Else If( $tag -eq "backup" )
{
  # Build the gzip and tar file paths
  $tarFilePath = Join-Path -Path $localBackupDirectory -ChildPath $tarFileName
  $gzipFilePath = "$tarFilePath.gz"

  # Terminate the virtual machine associated with the distribution
  wsl --terminate $distribution

  # Export the distribution to a tar file
  wsl --export $distribution $tarFilePath

  # Compress the tar file
  & 7z a -mx5 -tgzip $gzipFilePath $tarFilePath

  # Upload the file to AWS S3 bucket using AWS CLI
  aws s3 cp $gzipFilePath s3://machine-$machine --profile personal

  # Clean up the local backup directory by removing the files
  Remove-Item $gzipFilePath
  Remove-Item $tarFilePath
}
