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

#------------------------------[Functions]------------------------------

Function InstallChezmoi{
  winget install twpayne.chezmoi --interactive
}

Function InstallDoppler{
  scoop bucket add doppler https://github.com/DopplerHQ/scoop-doppler.git
  scoop install doppler
}

Function ConfigureDoppler{
  doppler login --scope / --token $Env:DOPPLER_TOKEN

  New-Item "C:\Users\$Env:USERNAME\.config\chezmoi" -ItemType Directory -ErrorAction SilentlyContinue
  @"
[doppler]
project = "dotfiles"
config = "prod_$Env:MACHINE"
"@ | Out-File -FilePath "C:\Users\$Env:USERNAME\.config\chezmoi\chezmoi.toml" -Encoding utf8
}

Function Init{
  chezmoi init --apply $Env:GITHUB_USERNAME
}

#------------------------------[Execution]------------------------------

InstallChezmoi
InstallDoppler
ConfigureDoppler

Init
