#!/bin/sh

set -e # -e: exit on error

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

# exec: replace current process with chezmoi init
exec "$chezmoi" init --apply ${GITHUB_USERNAME}
