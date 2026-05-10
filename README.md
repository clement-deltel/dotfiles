# dotfiles <!-- omit in toc -->

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io) and [doppler](https://www.doppler.com).

## Table of Contents <!-- omit in toc -->

- [1. Pre-requisites](#1-pre-requisites)
- [2. Linux](#2-linux)
  - [2.1 Install](#21-install)
  - [2.2 Update](#22-update)
  - [2.3 Development](#23-development)
  - [2.4 Test](#24-test)
  - [2.5 To be Tested](#25-to-be-tested)
- [3. Microsoft Windows](#3-microsoft-windows)
  - [3.1 Install](#31-install)
  - [3.2 Test](#32-test)
- [4. Browser](#4-browser)
- [5. Visual Studio Code](#5-visual-studio-code)

## 1. Pre-requisites

I store the below secrets in Doppler:

- AWS SSO account details
- Azure DevOps account details
- git user name and email
- kubeconfig and some custom kubernetes aliases
- SSH keys: RSA and ED25519
- [wakapi](https://github.com/muety/wakapi) API key and URL

I store sensitive files for my Windows machine in an AWS S3 bucket. For more details, go to the [Microsoft Windows](#3-microsoft-windows) section.

## 2. Linux

### 2.1 Install

1. Generate a Doppler service token valid for 30 minutes, following the official documentation available [here](https://docs.doppler.com/docs/service-tokens).

2. Export required environment variables:

```bash
export GITHUB_USERNAME=clement-deltel
# Machine configuration. Options: pro, perso
export MACHINE=pro
# Linux distribution family. Options: arch, debian, nixos, redhat
export FAMILY=debian

# Set ephemeral Doppler service token
export DOPPLER_TOKEN=''
```

3. Install dependencies:

```bash
# Debian-like Systems
sudo apt update -y && sudo apt install -y curl
# RedHat-like Systems
sudo yum update -y && sudo yum install -y curl
# Arch
# NixOS
```

4. Run installation script:

```bash
curl -fLSs https://raw.githubusercontent.com/${GITHUB_USERNAME}/dotfiles/refs/heads/main/docker/linux/${FAMILY}/install.sh | bash
```

5. After pulling and configuring the dotfiles, chezmoi run a script installing ansible, and then running playbooks.
6. Ansible playbooks automatically install and configure these [apps](apps/linux.md#current).
7. Clear service token and establish a proper connection:

```bash
unset DOPPLER_TOKEN
doppler login --scope /
```

8. If needed, run this extra playbook to pull quite handy base images:

```bash
# Pull Docker images: archlinux, centos, debian, fedora, mongodb, nixos, postgis, postgres, rabbitmq, redis, ubuntu
ansible-playbook --become --connection local --inventory "localhost," --tags init ~/ansible/orchestration/images.yml
```

### 2.2 Update

Run the command below to refresh the configuration after an update on the repository:

```bash
chezmoi update
# or the alias
cmu
```

### 2.3 Development

1. Export required environment variables:

```bash
export GITHUB_USERNAME=clement-deltel
# Machine configuration. Options: pro, perso
export MACHINE=pro
# Set image parameters
export FAMILY=debian
export IMAGE=ubuntu:24.04
# See all options and more details at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
export TIMEZONE=Etc/GMT

# Generate ephemeral Doppler service token
DURATION=30m
export DOPPLER_TOKEN=$(doppler configs tokens create dotfiles-install -p dotfiles -c prod_${MACHINE} --max-age ${DURATION} --plain)
```

2. Build Docker image:

```bash
# Docker build and then run
# Use option --progress=plain to see steps in more details
docker build --build-arg GITHUB_USERNAME --build-arg MACHINE --build-arg IMAGE --build-arg TIMEZONE --build-arg DOPPLER_TOKEN --file docker/linux/${FAMILY}/Dockerfile --tag ${IMAGE}-dotfiles-dev --target development docker/linux/${FAMILY}/

unset DOPPLER_TOKEN
```

3. Run a container:

```bash
docker run --interactive --name dotfiles-dev --tty --rm --volume ~/.local/share/chezmoi:/home/linux/.local/share/chezmoi ${IMAGE}-dotfiles-dev
```

### 2.4 Test

1. Install Docker to test this setup. The following images have been tested so far:

- **Debian-like Systems**
  - ubuntu:22.04
  - ubuntu:24.04

2. Export required environment variables:

```bash
export GITHUB_USERNAME=clement-deltel
# Machine configuration. Options: pro, perso
export MACHINE=pro
# Set image parameters
FAMILY=debian
export IMAGE=ubuntu:24.04
# See all options and more details at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
export TIMEZONE=Etc/GMT

# Generate ephemeral Doppler service token
DURATION=30m
export DOPPLER_TOKEN=$(doppler configs tokens create dotfiles-install -p dotfiles -c prod_${MACHINE} --max-age ${DURATION} --plain)
```

3. Build Docker image:

```bash
# Docker build and then run
# Use option --progress=plain to see steps in more details
docker build --build-arg GITHUB_USERNAME --build-arg MACHINE --build-arg IMAGE --build-arg TIMEZONE --build-arg DOPPLER_TOKEN --file docker/linux/${FAMILY}/Dockerfile --tag ${IMAGE}-dotfiles --target production docker/linux/${FAMILY}/

unset DOPPLER_TOKEN
```

4. Run a container:

```bash
docker run --interactive --name dotfiles --tty --rm ${IMAGE}-dotfiles
```

### 2.5 To be Tested

1. The following images have not been tested so far:

- **Debian-like Systems**
  - debian:12:10
  - ubuntu:26.04
- **RedHat-like Systems**
  - quay.io/centos/centos:10
  - fedora:42
  - redhat/ubi10:10.0
- **ArchLinux**
  - archlinux:base-20250302.0.316047
- **NixOS**
  - nixos/nix:2.27.1

2. Export required environment variables:

```bash
# Machine configuration. Options: pro, perso
export MACHINE=pro
# Set image parameters
IMAGE=ubuntu:26.04

# Generate ephemeral Doppler service token
DURATION=30m
export DOPPLER_TOKEN=$(doppler configs tokens create dotfiles-install -p dotfiles -c prod_${MACHINE} --max-age ${DURATION} --plain)
```

3. Run a container:

```bash
docker run --env GITHUB_USERNAME=clement-deltel --env MACHINE --env DOPPLER_TOKEN --interactive --name dotfiles --tty --rm ${IMAGE} bash
```

4. Update and install packages, set linux user:

```bash
apt update -y && apt install -y curl sudo
groupadd --gid 10001 linux
useradd --create-home --gid 10001 --home /home/linux --shell /bin/bash --uid 10001 linux
usermod -aG sudo linux && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
su linux
```

## 3. Microsoft Windows

### 3.1 Install

1. Generate a Doppler service token valid for 30 minutes, following the official documentation available [here](https://docs.doppler.com/docs/service-tokens).

2. Export required environment variables:

```ps1
$Env:GITHUB_USERNAME=clement-deltel
# Machine configuration. Options: pro, perso
$Env:MACHINE=pro
# Set ephemeral Doppler service token
$Env:$DOPPLER_TOKEN=""
```

3. Run installation script:

```ps1
curl -fLSs https://raw.githubusercontent.com/clement-deltel/dotfiles/refs/heads/main/docker/microsoft/install.sh | powershell
```

4. After pulling and configuring the dotfiles, chezmoi run several powershell scripts, executing the steps below:
   - [Chocolatey](https://docs.chocolatey.org/en-us/)
   - [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/)

5. Chocolatey install and configure these [apps](apps/windows.md#chocolatey).
6. Winget install and configure these [apps](apps/windows.md#winget).
7. chezmoi also restore some files from backups stored in AWS S3:
   - Google Chrome
   - Outlook Signatures
   - Windows Explorer - Quick Access
   - Windows Start Menu
   - Windows Subsystem for Linux (WSL)
   - Windows Taskbar

8. Finally, install the [softwares](apps/windows.md#manual-effort) requiring manual effort.
9. Clear service token and establish a proper connection:

```powershell
$Env:DOPPLER_TOKEN=$null
doppler login --scope C:\
```

### 3.2 Test

Install Docker to test this setup.

Then, build an image:

```ps1
$Env:GITHUB_USERNAME=clement-deltel
# Machine configuration. Options: pro, perso
$Env:MACHINE=pro
# Update with your Doppler CLI token
$Env:$DOPPLER_TOKEN=""

# Docker build and then run
# Use option --progress=plain to see steps in more details
docker build --build-arg GITHUB_USERNAME --build-arg MACHINE --build-arg DOPPLER_TOKEN --file docker/microsoft/Dockerfile --tag dotfiles docker/microsoft/

$Env:DOPPLER_TOKEN=$null
```

And run a container:

```powershell
docker run --interactive --name dotfiles --tty --rm dotfiles
```

To be tested:

```powershell
docker run --interactive --name dotfiles --tty --rm mcr.microsoft.com/windows/nanoserver:ltsc2022 powershell
```

## 4. Browser

I am still figuring out a way to install these [extensions](apps/browser.md#current) programmatically.

## 5. Visual Studio Code
