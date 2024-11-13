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

#------------------------------[Execution]------------------------------

winget install --exact --id twpayne.chezmoi
chezmoi init --apply $env:GithubUsername
