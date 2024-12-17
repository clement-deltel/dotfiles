#requires -version 5.1
<#
.SYNOPSIS
  Install Chocolatey and packages.
.DESCRIPTION
  Run the different steps to install Chocolatey on the machine. Then, install all the packages listed in the configuration.
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
  Creation Date:  2024-11-13
  Purpose/Change: Initial script development

.EXAMPLE
  ./packages/chocolatey.ps1 init work
  ./packages/chocolatey.ps1 update work
#>

#------------------------------[Declarations]---------------------------
$tag = args[0]
$machine = args[1]

$ChocolateyRootConfig = "$HOME/.config/chocolatey"

$PackagesConfig = "$ChocolateyRootConfig/$machine.config"
$excludedPackages = @("vscode", "vscode.install", "vscodium", "vscodium.install", "git", "docker-engine")

$features = @("Containers", "Microsoft-Hyper-V")

#------------------------------[Execution]------------------------------

# Chocolatey
If(-not (Test-Path -Path "$env:ProgramData\Chocolatey"))
{
  Write-Host "Installing Chocolatey..."
  If(Get-ExecutionPolicy == "Restricted")
  {
      Set-ExecutionPolicy AllSigned
  }
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  Write-Host "Chocolatey successfully installed"
}

# Packages

# Filter
[xml]$xmlContent = Get-Content -Path $PackagesConfig
$packages = $xmlContent.packages.package | ForEach-Object { $_.id }
$filteredPackages = $packageIds | Where-Object { $_ -notin $excludedPackages }

If( $tag -eq "init" )
{
  # Install
  Write-Host "Installing packages..."
  Write-Host "Packages: $filteredPackages"
  choco feature enable -n=useRememberedArgumentsForUpgrades
  choco install $filteredPackages --yes
  Write-Host "Packages successfully installed"

  # Visual Studio Code
  Write-Host "Installing Visual Studio Code..."
  choco install vscode vscode.install --yes --params="/NoDesktopIcon"
  Write-Host "Visual Studio Code successfully installed"

  # VSCodium
  # Write-Host "Installing VSCodium..."
  # choco install vscodium vscodium.install --yes --params="/AssociateWithFiles /NoDesktopIcon"
  # Write-Host "VSCodium successfully installed"

  # Git
  Write-Host "Installing Git..."
  winget uninstall --exact --id Git.Git
  choco install git git.install --yes --params="/NoAutoCrlf /WindowsTerminal /DefaultBranchName:main /Editor:VisualStudioCode"
  Write-Host "Git successfully installed"

  # Docker
  Write-Host "Installing Docker Engine..."
  choco install docker-engine --yes --params="/DockerGroup:docker /StartService" --version 24.0.7
  choco pin add --name="docker-engine" --version="24.0.7"
  Write-Host "Docker Engine successfully installed"
}
Else If( $tag -eq "update" )
{
  # Update
  choco upgrade all --yes
}

# Backup config
choco export -y --include-version-numbers --output-file-path="$PackagesConfig"
Remove-Item "$ChocolateyRootConfig/$machine.config.backup"


# Windows Features
If( $tag -eq "init" )
{
  Write-Host "Installing features..."
  Write-Host "Features: $features"
  choco install $features --yes --source windowsfeatures
  Write-Host "Features successfully installed"
}
