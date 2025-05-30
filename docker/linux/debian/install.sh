#!/bin/bash

#-----------------------------------------------------------------------------#
#DESCRIPTION: Initialize the system just with curl installed as a pre-requisite.
#-----------------------------------------------------------------------------#

#-----------------------------------------------------------------------------#
#FUNCTION: install_dependencies
#DESCRIPTION: Install pre-requisites on the system.
#-----------------------------------------------------------------------------#
function install_dependencies() {
  echo "[INFO] Installing dependencies: curl, git, jq, libsecret-1-0, unzip..."
  sudo apt update -y
  sudo apt install -y curl git jq libsecret-1-0 unzip
}

#-----------------------------------------------------------------------------#
#FUNCTION: install_chezmoi
#DESCRIPTION: Install chezmoi on the system.
#-----------------------------------------------------------------------------#
function install_chezmoi() {
  if [ ! "$(command -v chezmoi)" ]; then
    bin_dir="$HOME/.local/bin"
    chezmoi="$bin_dir/chezmoi"
    if [ "$(command -v curl)" ]; then
      sh -c "$(curl -fLSs get.chezmoi.io)" -- -b "$bin_dir"
    elif [ "$(command -v wget)" ]; then
      sh -c "$(wget -qO- get.chezmoi.io)" -- -b "$bin_dir"
    else
      echo "You must have curl or wget installed to install chezmoi." >&2
      exit 1
    fi
  else
    chezmoi=chezmoi
  fi
}

#-----------------------------------------------------------------------------#
#FUNCTION: install_bitwarden
#DESCRIPTION: Install Bitwarden CLI on the system.
#-----------------------------------------------------------------------------#
function install_bitwarden() {
  echo "[INFO] Getting Bitwarden CLI latest version..."
  export BW_VERSION=$(curl -H "Accept: application/vnd.github+json" https://api.github.com/repos/bitwarden/clients/releases | jq -r 'sort_by(.published_at) | reverse | .[].name | select( index("CLI") )' | sed "s:.*CLI v::" | head -n 1)

  echo "[INFO] Installing Bitwarden CLI ${BW_VERSION}..."
  curl -L --remote-name "https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-linux-${BW_VERSION}.zip"
  sudo unzip -d /usr/local/bin -o bw-linux-*.zip
  sudo chmod +x /usr/local/bin/bw
  echo "[INFO] Bitwarden CLI successfully installed"

  rm -f bw-linux-*.zip
}

#-----------------------------------------------------------------------------#
#FUNCTION: configure_bitwarden
#DESCRIPTION: Configure Bitwarden API access and get chezmoi configuration file.
#-----------------------------------------------------------------------------#
configure_bitwarden() {
  echo "[INFO] Configuring Bitwarden CLI..."
  bw config server ${BW_SERVER}
  bw login --apikey

  echo "[INFO] Opening session to get chezmoi configuration file..."
  export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
  mkdir -p ~/.config/chezmoi
  bw get notes chezmoi-${MACHINE} >~/.config/chezmoi/chezmoi.toml
  bw lock
  echo "[INFO] chezmoi configuration file successfully retrieved"
}

#-----------------------------------------------------------------------------#
#FUNCTION: init
#DESCRIPTION: Initialize chezmoi on the system.
#-----------------------------------------------------------------------------#
init() {
  export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)

  echo "[INFO] Running chezmoi initialization..."
  exec "$chezmoi" init --apply ${GITHUB_USERNAME}
  echo "[INFO] chezmoi successfully initialized"

  bw lock
}

#-----------------------------------------------------------------------------#
#FUNCTION: main
#-----------------------------------------------------------------------------#
function main() {
  set -e # -e: exit on error

  install_dependencies
  install_chezmoi
  install_bitwarden
  configure_bitwarden

  init
}

main $@
