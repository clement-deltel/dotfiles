#!/bin/bash

# ---------------------------------------------------------------------------- #
#DESCRIPTION: Initialize the system just with curl installed as a pre-requisite.
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
#FUNCTION: install_dependencies
#DESCRIPTION: Install pre-requisites.
# ---------------------------------------------------------------------------- #
function install_dependencies() {
  echo "[INFO] Installing dependencies: apt-transport-https, ca-certificates, curl, git, gnupg..."
  sudo apt update -y
  sudo apt install -y apt-transport-https ca-certificates curl git gnupg
}

# ---------------------------------------------------------------------------- #
#FUNCTION: install_chezmoi
#DESCRIPTION: Install chezmoi.
# ---------------------------------------------------------------------------- #
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

# ---------------------------------------------------------------------------- #
#FUNCTION: install_doppler
#DESCRIPTION: Install Doppler CLI.
# ---------------------------------------------------------------------------- #
function install_doppler() {
  echo "[INFO] Installing Doppler CLI..."
  curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | sudo gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | sudo tee /etc/apt/sources.list.d/doppler-cli.list
  sudo apt update -y
  sudo apt install -y doppler
  echo "[INFO] Doppler CLI successfully installed"
}

# ---------------------------------------------------------------------------- #
#FUNCTION: configure_doppler
#DESCRIPTION: Configure Doppler API access and build chezmoi configuration file.
# ---------------------------------------------------------------------------- #
configure_doppler() {
  echo "[INFO] Configuring Doppler CLI..."
  doppler login --scope / --token ${DOPPLER_TOKEN}
  echo """[doppler]
project = "dotfiles"
config = "prod_${MACHINE}"""" > ~/.config/chezmoi/chezmoi.toml
}

# ---------------------------------------------------------------------------- #
#FUNCTION: init
#DESCRIPTION: Initialize chezmoi on the system.
# ---------------------------------------------------------------------------- #
init() {
  echo "[INFO] Running chezmoi initialization..."
  exec "$chezmoi" init --apply ${GITHUB_USERNAME}
  echo "[INFO] chezmoi successfully initialized"
}

# ---------------------------------------------------------------------------- #
#FUNCTION: main
# ---------------------------------------------------------------------------- #
function main() {
  set -e # -e: exit on error

  install_dependencies
  install_chezmoi
  install_doppler
  configure_doppler

  if [[ -z ${DISABLE_INIT} ]]; then
    init
  fi
}

main $@
