# dotfiles <!-- omit in toc -->

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io).

## Table of Contents <!-- omit in toc -->

- [1. Pre-requisites](#1-pre-requisites)
- [2. Linux](#2-linux)
  - [2.1 Install](#21-install)
  - [2.2 Shell](#22-shell)
  - [2.3 Update](#23-update)
  - [2.4 Test](#24-test)
  - [2.5 Containers](#25-containers)
- [3. Microsoft Windows](#3-microsoft-windows)
  - [3.1 Install](#31-install)
  - [3.2 Test](#32-test)
- [4. Browser](#4-browser)
- [5. Visual Studio Code](#5-visual-studio-code)

## 1. Pre-requisites

I store the below sensitive configuration in my Vaultwarden instance:

- **chezmoi toml configuration file**: notes of the item named "chezmoi"
- **private ssh keys**: attachments of the item named "SSH Keys"
- **kubeconfig file**: attachment "kubeconfig" of the item named "chezmoi"
- **aws CLI configuration**: custom fields of the item with the id "223277e3-498b-4d3c-9c0b-fe80e0e83d7b"

I store the sensitive files for my Windows machine in an AWS S3 bucket.

## 2. Linux

### 2.1 Install

1. Export required environment variables:

```bash
# Machine configuration. Options: pro, perso
export MACHINE="pro"
# Linux distribution family. Options: arch, debian, nixos, redhat
export FAMILY="debian"
# Update with your server address
export BW_SERVER="https://bw.domain.com"
# Fill the blanks with your API credentials and password
export BW_CLIENTID=""
export BW_CLIENTSECRET=""
export BW_PASSWORD=''
export GITHUB_USERNAME=clement-deltel
```

2. Install dependencies:

```bash
# Debian-like Systems
sudo apt update -y && sudo apt install -y curl
# RedHat-like Systems
sudo yum update -y && sudo yum install -y curl
# Arch
# NixOS
```

3. Run installation script:

```bash
curl -fLSs https://raw.githubusercontent.com/${GITHUB_USERNAME}/dotfiles/refs/heads/main/docker/linux/${FAMILY}/install.sh | bash
```

4. After pulling and configuring the dotfiles, chezmoi run a script installing ansible, and then running playbooks.
5. Ansible playbooks automatically install and configure these [apps](apps/linux.md#current).
6. Clean sensitive information:

```bash
unset BW_CLIENTID
unset BW_CLIENTSECRET
unset BW_PASSWORD
```

### 2.2 Shell

Zsh is my default shell, for which I use [plugins](apps/linux.md#zsh-plugins).

Here is my theme: robbyrussell

Here are some useful Linux system commands:

- **Built-ins**
  - [dig](https://linux.die.net/man/1/dig) - DNS lookup utility.
  - [lshw](https://linux.die.net/man/1/lshw) - list hardware.
  - [lsof](https://linux.die.net/man/8/lsof) - list open files.
  - [rsync](https://linux.die.net/man/1/rsync) - remote (and local) file-copying tool.
  - [shred](https://linux.die.net/man/1/shred) - overwrite a file to hide its contents, and optionally delete it.
  - [stat](https://linux.die.net/man/1/stat) - display file or file system status.
  - [systemd-analyze](https://man7.org/linux/man-pages/man1/systemd-analyze.1.html) - analyze and debug system manager.
  - [tcpdump](https://linux.die.net/man/8/tcpdump) - dump traffic on a network.
  - [watch](https://linux.die.net/man/1/watch) - execute a program periodically, showing output fullscreen.
- **More Utils**
  - [errno](https://linux.die.net/man/3/errno) - number of last error.
  - [ifdata](https://linux.die.net/man/1/ifdata) - get network interface info without parsing ifconfig output.
  - [vidir](https://linux.die.net/man/1/vidir) - edit directory.
  - [vipe](https://linux.die.net/man/1/vipe) - edit pipe.
  - [zrun](https://linux.die.net/man/1/zrun) - automatically uncompress arguments to command.

### 2.3 Update

Follow the steps below to refresh the configuration after an update on the repository:

- Open Bitwarden session
- Enter your Bitwarden password
- Run chezmoi update
- Close Bitwarden session

```bash
cmub
```

### 2.4 Test

Install Docker to test this setup. The following images have been tested so far:

- **Debian-like Systems**
  - ubuntu:22.04

Then, build an image:

```bash
# Machine configuration. Options: pro, perso
export MACHINE="pro"
# Set image parameters
export FAMILY="debian"
export IMAGE="ubuntu:22.04"
# See all options and more details at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
export TIMEZONE="America/New_York"

# Update with your server address
export BW_SERVER="https://bw.domain.com"
# Fill the blanks with your API credentials and password
export BW_CLIENTID=""
export BW_CLIENTSECRET=""
export BW_PASSWORD=''
export GITHUB_USERNAME=clement-deltel

# Docker build and then run
# Use option --progress=plain to see steps in more details
docker build --build-arg MACHINE --build-arg IMAGE --build-arg TIMEZONE --build-arg BW_SERVER --build-arg BW_CLIENTID --build-arg BW_CLIENTSECRET --build-arg BW_PASSWORD --build-arg GITHUB_USERNAME --tag dotfiles --file docker/linux/${FAMILY}/Dockerfile docker/linux/${FAMILY}/

unset BW_CLIENTID
unset BW_CLIENTSECRET
unset BW_PASSWORD
```

And run a container:

```bash
docker run --interactive --name dotfiles --tty --rm dotfiles
```

To be tested:

- **Debian-like Systems**
  - debian:12:10
  - ubuntu:24.04
- **RedHat-like Systems**
  - quay.io/centos/centos:10
  - fedora:42
- **ArchLinux**
  - archlinux:base-20250302.0.316047
- **NixOS**
  - nixos/nix:2.27.1

```bash
docker run --interactive --name dotfiles --tty --rm <image> bash
```

### 2.5 Containers

If needed, run this extra playbook to pull quite handy base images:

```bash
# Pull Docker images: archlinux, centos, debian, fedora, mongodb, nixos, postgis, postgres, rabbitmq, redis, ubuntu
ansible-playbook --become --connection local --inventory "localhost," --tags init ~/ansible/orchestration/images.yml
```

Here is the list of containerized tools that I use:

- [Faster Whisper](https://github.com/SYSTRAN/faster-whisper) - faster whisper transcription with ctranslate2. I use more specifically the [image](https://github.com/linuxserver/docker-faster-whisper) provided by linuxserver.

## 3. Microsoft Windows

### 3.1 Install

1. Export required environment variables:

```bash
# Machine configuration. Options: pro, perso
$Env:MACHINE="pro"
# Update with your server address
$Env:BW_SERVER="https://bw.domain.com"
# Fill the blanks with your API credentials and password
$Env:BW_CLIENTID=""
$Env:BW_CLIENTSECRET=""
$Env:BW_PASSWORD=''
$Env:GITHUB_USERNAME=clement-deltel
```

2. Run installation script:

```ps1
curl -fLSs https://raw.githubusercontent.com/clement-deltel/dotfiles/refs/heads/main/docker/microsoft/install.sh | powershell
```

3. After pulling and configuring the dotfiles, chezmoi run several powershell scripts, executing the steps below:
   - [Chocolatey](https://docs.chocolatey.org/en-us/)
   - [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/)

4. Chocolatey install and configure these [apps](apps/windows.md#chocolatey).
5. Winget install and configure these [apps](apps/windows.md#winget).
6. chezmoi also restore some files from backups stored in AWS S3:
   - Google Chrome
   - Outlook Signatures
   - Windows Explorer - Quick Access
   - Windows Start Menu
   - Windows Subsystem for Linux (WSL)
   - Windows Taskbar

7. Finally, install the [softwares](apps/windows.md#manual-effort) requiring manual effort.
8. Clean sensitive information:

```powershell
$Env:BW_CLIENTID=$null
$Env:BW_CLIENTSECRET=$null
$Env:BW_PASSWORD=$null
```

### 3.2 Test

Install Docker to test this setup.

Then, build an image:

```ps1
# Machine configuration. Options: pro, perso
$Env:MACHINE="pro"
# Update with your server address
$Env:BW_SERVER="https://bw.domain.com"
# Fill the blanks with your API credentials and password
$Env:BW_CLIENTID=""
$Env:BW_CLIENTSECRET=""
$Env:BW_PASSWORD=''
$Env:GITHUB_USERNAME=clement-deltel

# Docker build and then run
# Use option --progress=plain to see steps in more details
docker build --build-arg MACHINE --build-arg BW_SERVER --build-arg BW_CLIENTID --build-arg BW_CLIENTSECRET --build-arg BW_PASSWORD --build-arg GITHUB_USERNAME --file docker/microsoft/Dockerfile --tag dotfiles docker/microsoft/

$Env:BW_CLIENTID=$null
$Env:BW_CLIENTSECRET=$null
$Env:BW_PASSWORD=$null
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
