# dotfiles <!-- omit in toc -->

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io).

## Table of Contents <!-- omit in toc -->

- [Pre-requisites](#pre-requisites)
- [Linux](#linux)
  - [Ubuntu](#ubuntu)
  - [Update](#update)
  - [Shell](#shell)
- [Microsoft Windows](#microsoft-windows)
- [Browser extensions](#browser-extensions)

## Pre-requisites

I store the below sensitive configuration in my Vaultwarden instance:

- **chezmoi toml configuration file**: notes of the item named "chezmoi"
- **private ssh keys**: attachments of the item named "SSH Keys"
- **kubeconfig file**: attachment "kubeconfig" of the item named "chezmoi"
- **aws cli configuration**: custom fields of the item with the id "223277e3-498b-4d3c-9c0b-fe80e0e83d7b"

I store the sensitive files for my Windows machine in an AWS S3 bucket.

## Linux

### Ubuntu

1. Export required environment variables:

```bash
# Update with your server address
export BW_SERVER="https://bw.domain.com"
# Fill the blanks with your API credentials and password
export BW_CLIENTID=""
export BW_CLIENTSECRET=""
export BW_PASSWORD=''
export GITHUB_USERNAME=clement-deltel
```

2. Install dependencies and run installation script:

```bash
sudo apt update -y && sudo apt install -y curl
curl -fLSs https://raw.githubusercontent.com/${GITHUB_USERNAME}/dotfiles/refs/heads/main/docker/linux/install.sh | bash
```

3. After pulling and configuring the dotfiles, chezmoi run a script installing ansible, and then running playbooks.
4. Ansible playbooks automatically install and configure the tools listed below:
    - Package Managers
      - apt
        - [bat](https://github.com/sharkdp/bat): cat(1) clone with wings.
        - [FIGlet](https://linux.die.net/man/6/figlet): display large characters made up of ordinary screen characters.
        - [fzf](https://github.com/junegunn/fzf): command-line fuzzy finder.
        - [git-filter-repo](https://github.com/newren/git-filter-repo): quickly rewrite git repository history (filter-branch replacement).
        - [htop](https://github.com/htop-dev/htop): interactive process viewer.
        - [jq](https://github.com/jqlang/jq): command-line JSON processor.
        - [pdftk](https://www.pdflabs.com/tools/pdftk-server): command-line tool for working with PDFs.
        - [pwgen](https://linux.die.net/man/1/pwgen): generate pronounceable passwords.
        - [trippy](https://github.com/fujiapple852/trippy): network diagnostic tool.
        - [vim](https://github.com/vim/vim)
        - [xclip](https://github.com/astrand/xclip): command line interface to the X11 clipboard.
      - [homebrew](https://github.com/Homebrew/brew): the missing package manager for Linux.
        - [btop](https://github.com/aristocratos/btop): monitor of resources.
        - [grype](https://github.com/anchore/grype): vulnerability scanner for container images and filesystems.
        - [lazydocker](https://github.com/jesseduffield/lazydocker): lazier way to manage everything Docker.
        - [lazygit](https://github.com/jesseduffield/lazygit): simple terminal UI for git commands.
        - [lnav](https://github.com/tstack/lnav): log file navigator.
        - [tldr](https://github.com/tldr-pages/tlrc): tldr client written in Rust.
        - [tokei](https://github.com/XAMPPRocky/tokei): count your code, quickly.
        - [Trivy](https://github.com/aquasecurity/trivy): find vulnerabilities, misconfigurations, secrets, SBOM in containers, Kubernetes, code repositories, clouds and more.
      - [npm](https://github.com/npm/cli)
        - [readme-generator-for-helm](https://github.com/bitnami/readme-generator-for-helm): auto generate READMEs for Helm Charts.
    - Shell
      - [antidote](https://github.com/mattmc3/antidote): the cure to slow zsh plugin management.
      - [eza](https://github.com/eza-community/eza): modern alternative to ls.
      - [Oh My Posh](https://github.com/jandedobbeleer/oh-my-posh): the most customizable and low-latency cross platform/shell prompt renderer.
      - [WezTerm](https://github.com/wezterm/wezterm): GPU-accelerated cross-platform terminal emulator and multiplexer.
      - zsh
      - [zoxide](https://github.com/ajeetdsouza/zoxide): smarter cd command.
    - Version Control System (VCS)
      - Git
        - [gitleaks](https://github.com/gitleaks/gitleaks)
        - [git-lfs](https://github.com/git-lfs/git-lfs)
    - Security
      - [Bitwarden CLI](https://bitwarden.com/help/cli/)
    - Languages
      - Go
        - [kind](https://github.com/kubernetes-sigs/kind/): Kubernetes in Docker - local clusters for testing Kubernetes.
      - JavaScript
        - [nodejs](https://github.com/nodejs/node)
      - Python
        - pip
          - [markitdown](https://github.com/microsoft/markitdown): Python tool for converting files and office documents to Markdown.
          - [Pygments](https://github.com/pygments/pygments): generic syntax highlighter written in Python.
        - [pipx](https://github.com/pypa/pipx)
          - [commitizen](https://github.com/commitizen-tools/commitizen): create committing rules for projects, auto bump versions, and auto changelog generation.
          - [poetry](https://github.com/python-poetry/poetry): Python packaging and dependency management made easy.
        - [pyenv](https://github.com/pyenv/pyenv): simple Python version management.
    - Orchestration
      - Docker
      - Kubernetes
        - [helm](https://github.com/helm/helm): the Kubernetes Package Manager.
        - [helmfile](https://github.com/helmfile/helmfile): declaratively deploy your Kubernetes manifests, Kustomize configs, and Charts as Helm releases.
        - [kubectl](https://github.com/kubernetes/kubectl)
        - [kubectx](https://github.com/ahmetb/kubectx): faster way to switch between clusters and namespaces in kubectl.
        - [k9s](https://github.com/derailed/k9s): kubernetes CLI to manage your clusters in style.
        - [stern](https://github.com/stern/stern): multi pod and container log tailing for Kubernetes.
    - Infrastructure as Code (IaC)
      - [Pulumi](https://github.com/pulumi/pulumi): infrastructure as Code in any programming language.
      - [Terraform](https://github.com/hashicorp/terraform): safely and predictably create, change, and improve infrastructure.
    - Cloud
      - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
      - [GCP CLI](https://cloud.google.com/sdk/docs/install)

5. Run extra playbooks if needed:

```bash
# Pull Docker images: fedora, mongodb, postgis, postgres, rabbitmq, redis, ubuntu
ansible-playbook --become --connection local --inventory "localhost," --tags init ~/ansible/orchestration/images.yml
```

If you want to test this setup, you need to have Docker installed and then you can run the commands below:

```bash
# Set build args
export BW_SERVER="https://bw.domain.com"
export BW_CLIENTID=""
export BW_CLIENTSECRET=""
export BW_PASSWORD=''
export GITHUB_USERNAME=clement-deltel

# Docker build and then run
# Use option --progress=plain to see steps in more details
docker build --build-arg BW_SERVER --build-arg BW_CLIENTID --build-arg BW_CLIENTSECRET --build-arg BW_PASSWORD --build-arg GITHUB_USERNAME --file docker/linux/Dockerfile --tag dotfiles docker/linux/
docker run --interactive --name dotfiles --tty --rm dotfiles
```

### Update

If you want to refresh the configuration after an update on the repository, follow the steps below:

- Open Bitwarden session
- Enter your Bitwarden password
- Run chezmoi update
- Close Bitwarden session

```bash
cmub
```

### Shell

Zsh is my default shell. Here is the list of plugins:

- **oh-my-zsh repository**
  - Aliases
    - [aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aliases)
    - [alias-finder](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/alias-finder)
    - [common-aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases)
  - Cloud
    - [aws](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aws)
    - [gcloud](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gcloud)
  - Configuration Management
    - [ansible](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ansible)
    - [chezmoi](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/chezmoi)
  - Distro-related
    - [ubuntu](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ubuntu)
  - Infrastructure as Code
    - [terraform](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/terraform)
  - Languages
    - Go
      - [golang](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/golang)
    - JavaScript
      - [node](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/node)
    - Python
      - [pip](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pip)
      - [poetry](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/poetry)
  - Packages
    - [brew](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/brew)
    - [npm](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/npm)
  - Productivity
    - [colored-man-pages](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages)
    - [colorize](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize)
    - [command-not-found](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found)
    - [safe-paste](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/safe-paste)
  - Orchestration
    - [docker](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker)
    - [docker-compose](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose)
    - [helm](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/helm)
    - [kubectl](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kubectl)
  - Shell
    - [cp](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/cp)
    - [eza](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/eza)
    - [fzf](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf)
    - [history](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/history)
    - [sudo](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo)
  - Version Control
    - [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
    - [git-lfs](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-lfs)
    - [pre-commit](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pre-commit)
  - Other
    - [vscode](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode)
- **zsh-users repository**
  - [zsh-completions](https://github.com/zsh-users/zsh-completions)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

Here is my theme: robbyrussell

## Microsoft Windows

1. Export required environment variables:

```bash
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

4. Chocolatey automatically install and configure the tools listed below:

- [7-Zip](https://community.chocolatey.org/packages/7zip)
- [AutoHotkey (Portable)](https://community.chocolatey.org/packages/autohotkey)
- [AWS CLI v2](https://community.chocolatey.org/packages/awscli)
- [Bitwarden CLI](https://community.chocolatey.org/packages/bitwarden-cli)
- [BleachBit](https://community.chocolatey.org/packages/bleachbit.install)
- [Citrix Workspace](https://community.chocolatey.org/packages/citrix-workspace)
- [DBeaver - Community Edition](https://community.chocolatey.org/packages/dbeaver)
- [Docker Engine](https://community.chocolatey.org/packages/docker-engine)
- [FileZilla](https://community.chocolatey.org/packages/filezilla)
- [Flameshot](https://community.chocolatey.org/packages/flameshot)
- [GIMP](https://community.chocolatey.org/packages/gimp)
- [Git](https://community.chocolatey.org/packages/git)
- [Git Credential Manager](https://community.chocolatey.org/packages/git-credentials-manager-for-windows)
- [Google Chrome](https://community.chocolatey.org/packages/googlechrome)
- [Google Earth Pro](https://community.chocolatey.org/packages/googleearthpro)
- [Insomnia](https://community.chocolatey.org/packages/insomnia-rest-api-client)
- [iTunes](https://community.chocolatey.org/packages/itunes)
- [Java SE (jdk8)](https://community.chocolatey.org/packages/jdk8)
- [Keepass 2.x](https://community.chocolatey.org/packages/keepass)
- [Logi Options+](https://community.chocolatey.org/packages/logioptionsplus)
- [MongoDB Compass](https://community.chocolatey.org/packages/mongodb-compass)
- [Nilesoft Shell](https://community.chocolatey.org/packages/nilesoft-shell)
- [Notepad++](https://community.chocolatey.org/packages/notepadplusplus)
- [Notion](https://community.chocolatey.org/packages/notion)
- [Obsidian](https://community.chocolatey.org/packages/obsidian)
- [Win32 OpenSSH](https://community.chocolatey.org/packages/openssh)
- [Opera](https://community.chocolatey.org/packages/opera)
- [Podman Desktop](https://community.chocolatey.org/packages/podman-desktop):
- [PowerToys](https://community.chocolatey.org/packages/powertoys): set of utilities for power users to tune and streamline their Windows experience for greater productivity.
- [PostgreSQL ODBC Driver](https://community.chocolatey.org/packages/psqlodbc): official PostgreSQL ODBC Driver.
- [Pyenv-win](https://community.chocolatey.org/packages/pyenv-win): simple python version management tool.
- [Python](https://community.chocolatey.org/packages/python): programming language that lets you work more quickly and integrate your systems more effectively.
- [QGIS](https://community.chocolatey.org/packages/qgis): user friendly Open Source Geographic Information System (GIS).
- [QuickLook](https://community.chocolatey.org/packages/quicklook): enables very quick preview of file by pressing Space key while highlighting it, without opening its associated application.
- [Rufus](https://community.chocolatey.org/packages/rufus): utility that helps format and create bootable USB flash drives, such as USB keys/pendrives, memory sticks, etc.
- [RustDesk](https://community.chocolatey.org/packages/rustdesk): remote desktop software, works out of the box, no configuration required.
- [SoundSwitch](https://community.chocolatey.org/packages/soundswitch): switch your playback and recording devices using simple hotkeys.
- [Spotify](https://community.chocolatey.org/packages/spotify): digital music service that gives you access to millions of songs.
- [Sudo](https://community.chocolatey.org/packages/sudo): elevate directly from the shell.
- [VeraCrypt](https://community.chocolatey.org/packages/veracrypt): disk encryption software for Windows, Mac OSX and Linux.
- [VLC Media Player](https://community.chocolatey.org/packages/vlc): cross-platform multimedia player and framework that plays most multimedia files as well as DVD, Audio CD, VCD, and various streaming protocols.
- [VMWare Horizon Client](https://community.chocolatey.org/packages/vmware-horizon-client): access your remote desktops and published applications with the best possible user experience on the Local Area Network (LAN) or across a Wide Area Network (WAN).
- [Visual Studio Code](https://community.chocolatey.org/packages/vscode): build and debug modern web and cloud applications.
- [VSCodium](https://community.chocolatey.org/packages/vscodium): community-driven, freely-licensed binary distribution of Microsoft's editor VS Code.
- [Webex Meetings - Cisco](https://community.chocolatey.org/packages/webex-meetings): video conferencing is as simple and seamless as meeting in person.
- [WezTerm](https://community.chocolatey.org/packages/wezterm): GPU-accelerated cross-platform terminal emulator and multiplexer.
- [Wireguard](https://community.chocolatey.org/packages/wireguard): extremely simple yet fast and modern VPN that utilizes state-of-the-art cryptography.
- [WizTree](https://community.chocolatey.org/packages/wiztree): disk space analyzer utility.
- [Yubico Authenticator](https://community.chocolatey.org/packages/yubico-authenticator): store your unique credential on a hardware-backed security key and take it wherever you go from mobile to desktop.
- [Zoom](https://community.chocolatey.org/packages/zoom): unify cloud video conferencing, simple online meetings, group messaging, and a software-defined conference room solution into one easy-to-use platform.

5. Winget automatically install and configure the tools listed below:

- [Apple Devices](https://apps.microsoft.com/detail/9np83lwlpz9k)
- [IAP Desktop](https://github.com/GoogleCloudPlatform/iap-desktop)
- [Intel Unison](https://apps.microsoft.com/detail/9pp9gzm2gn26)
- [Microsoft Sysinternals](https://apps.microsoft.com/detail/9p7knl5rwt25)
- [Rainmeter](https://www.rainmeter.net)
- [Trello](https://apps.microsoft.com/detail/9nblggh4xxvw)
- [Wacom Tablet Driver](https://www.wacom.com/en-us/support/product-support/drivers)
- [WinToys](https://apps.microsoft.com/detail/9p8ltpgcbzxd)

6. chezmoi also restore some files from backups stored in AWS S3:
   - Google Chrome
   - Outlook Signatures
   - Windows Explorer - Quick Access
   - Windows Start Menu
   - Windows Subsystem for Linux (WSL)
   - Windows Taskbar

7. Finally, there are softwares that require manual effort:

- [Backblaze](https://www.backblaze.com)
- Logitech Capture

If you want to test this setup, you need to have Docker installed and then you can run the commands below:

```ps1
# Set build args
$Env:BW_SERVER="https://bw.domain.com"
$Env:BW_CLIENTID=""
$Env:BW_CLIENTSECRET=""
$Env:BW_PASSWORD=''
$Env:GITHUB_USERNAME=clement-deltel

# Docker build and then run
# Use option --progress=plain to see steps in more details
docker build --build-arg BW_SERVER --build-arg BW_CLIENTID --build-arg BW_CLIENTSECRET --build-arg BW_PASSWORD --build-arg GITHUB_USERNAME --file docker/microsoft/Dockerfile --tag dotfiles docker/microsoft/
docker run --interactive --name dotfiles --tty --rm dotfiles

docker run --interactive --name dotfiles --tty --rm mcr.microsoft.com/windows/nanoserver:ltsc2022 powershell
```

## Browser extensions

I am still figuring out a way to install them programmatically but here is a list of browser extensions that I use:

- [Bitwarden Password Manager](https://chromewebstore.google.com/detail/bitwarden-password-manage/nngceckbapebfimnlniiiahkandclblb)
- [Cisco Webex Content Sharing](https://chromewebstore.google.com/detail/cisco-webex-content-shari/ifbdadgbpalmagalacllfaflfakmfkac)
- [ClearURLs](https://chromewebstore.google.com/detail/clearurls/lckanjgmijmafbedllaakclkaicjfmnk)
- [daily.dev | The homepage developers deserve](https://chromewebstore.google.com/detail/dailydev-the-homepage-dev/jlmpjdjjbgclbocgajdjefcidcncaied)
- [Dark Reader](https://chromewebstore.google.com/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh)
- [Ghostery Tracker & Ad Blocker - Privacy AdBlock](https://chromewebstore.google.com/detail/ghostery-tracker-ad-block/mlomiejdfkolichcflejclcbmpeaniij)
- [Grammarly: AI Writing and Grammar Check App](https://chromewebstore.google.com/detail/grammarly-ai-writing-and/kbfnbcaeplbcioakkpcpgfkobkghlhen)
- [JSON Lite](https://chromewebstore.google.com/detail/json-lite/acacmjcicejlmjcheoklfdchempahoag)
- [Keepa - Amazon Price Tracker](https://chromewebstore.google.com/detail/keepa-amazon-price-tracke/neebplgakaahbhdphmkckjjcegoiijjo)
- [Raindrop.io: all-in-one bookmark manager](https://chromewebstore.google.com/detail/raindropio/ldgfbffkinooeloadekpmfoklnobpien)
- [uBlock Origin: finally an efficient blocker, easy on CPU and memory.](https://chromewebstore.google.com/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm)
