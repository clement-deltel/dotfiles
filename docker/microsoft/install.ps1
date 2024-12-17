#requires -version 5.1
<#
.SYNOPSIS
  Install and initialize chezmoi.
.DESCRIPTION
  Run the different steps to install chezmoi on the machine. Then, apply the dotfiles.
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
  ./install.ps1
#>

#------------------------------[Declarations]---------------------------
$username = $Env:UserName

#------------------------------[Functions]------------------------------

Function InstallChezmoi{
  winget install twpayne.chezmoi --interactive
}

Function InstallBitwarden{
  winget install Bitwarden.CLI --interactive
}

Function ConfigureBitwarden{
  bw config server $Env:BW_SERVER
  bw login --apikey

  $BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
  New-Item "C:\Users\$username\.config\chezmoi" -ItemType Directory -ErrorAction SilentlyContinue
  bw get notes chezmoi > "C:\Users\$username\.config\chezmoi\chezmoi.toml"
  bw lock
}

Function Init{
  $BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
  chezmoi init --apply $Env:GITHUB_USERNAME
  bw lock
}

#------------------------------[Execution]------------------------------

InstallChezmoi
InstallBitwarden
ConfigureBitwarden

Init
