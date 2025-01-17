# dotfiles <!-- omit in toc -->

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io).

## Table of Contents <!-- omit in toc -->

- [Pre-requisites](#pre-requisites)
- [Linux](#linux)
  - [Ubuntu](#ubuntu)
  - [Update](#update)
  - [Shell](#shell)
- [Microsoft Windows](#microsoft-windows)
- [Future enhancements](#future-enhancements)
  - [Linux](#linux-1)
  - [Windows](#windows)

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
curl -fLSs https://raw.githubusercontent.com/clement-deltel/dotfiles/refs/heads/main/docker/linux/install.sh | bash
```

3. After pulling and configuring the dotfiles, chezmoi run a script installing ansible, and then running playbooks.
4. Ansible playbooks automatically install and configure the tools listed below:
    - Package Managers
      - apt
        - [bat](https://github.com/sharkdp/bat)
        - [fzf](https://github.com/junegunn/fzf)
        - [htop](https://github.com/htop-dev/htop)
        - [jq](https://github.com/jqlang/jq)
        - pwgen
        - [vim](https://github.com/vim/vim)
        - [xclip](https://github.com/astrand/xclip)
      - [homebrew](https://github.com/Homebrew/brew)
        - [btop](https://github.com/aristocratos/btop)
        - [lnav](https://github.com/tstack/lnav)
        - [tldr](https://github.com/tldr-pages/tlrc)
        - [tokei](https://github.com/XAMPPRocky/tokei)
        - [Trivy](https://github.com/aquasecurity/trivy)
      - [npm](https://github.com/npm/cli)
        - [readme-generator-for-helm](https://github.com/bitnami/readme-generator-for-helm)
    - Shell
      - [antidote](https://github.com/mattmc3/antidote)
      - [eza](https://github.com/eza-community/eza)
      - [Oh My Posh](https://github.com/jandedobbeleer/oh-my-posh)
      - zsh
      - [zoxide](https://github.com/ajeetdsouza/zoxide)
    - Version Control System (VCS)
      - Git
        - [git-lfs](https://github.com/git-lfs/git-lfs)
    - Security
      - [Bitwarden CLI](https://bitwarden.com/help/cli/)
    - Languages
      - Go
      - JavaScript
        - [nodejs](https://github.com/nodejs/node)
      - Python
        - pip
          - [markitdown](https://github.com/microsoft/markitdown)
          - [Pygments](https://github.com/pygments/pygments)
        - [pipx](https://github.com/pypa/pipx)
          - [commitizen](https://github.com/commitizen-tools/commitizen)
          - [poetry](https://github.com/python-poetry/poetry)
        - [pyenv](https://github.com/pyenv/pyenv)
    - Orchestration
      - Docker
      - Kubernetes
        - [helm](https://github.com/helm/helm)
        - [helmfile](https://github.com/helmfile/helmfile)
        - [kubectl](https://github.com/kubernetes/kubectl)
        - [kubectx](https://github.com/ahmetb/kubectx)
        - [k9s](https://github.com/derailed/k9s)
        - [stern](https://github.com/stern/stern)
    - Infrastructure as Code (IaC)
      - [Pulumi](https://github.com/pulumi/pulumi)
      - [Terraform](https://github.com/hashicorp/terraform)
    - Cloud
      - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
      - [GCP CLI](https://cloud.google.com/sdk/docs/install)

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
bws
cmu
unset BW_SESSION
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

4. chezmoi also restore some files from backups stored in AWS S3:
   - Google Chrome
   - Outlook Signatures
   - Windows Explorer - Quick Access
   - Windows Start Menu
   - Windows Subsystem for Linux (WSL)
   - Windows Taskbar

If you want to test this setup, you need to have Docker installed and then you can run the commands below:
```bash
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

## Future enhancements

### Linux

Here is a list of tools that could be interesting and further enhance the stack:

- **Artificial Intelligence (AI)**
  - [OpenCommit](https://github.com/di-sukharev/opencommit): generate commit messages by an LLM in 1 sec
  - [Private GPT](https://github.com/zylon-ai/private-gpt): interact with your documents using the power of GPT, 100% privately, no data leaks
- **Containers**
  - [Clair](https://github.com/quay/clair): vulnerability static analysis for containers
  - [Docker Bench](https://github.com/docker/docker-bench-security): script that checks for dozens of common best-practices around deploying Docker containers in production
  - [dozzle](https://github.com/amir20/dozzle): realtime log viewer for docker containers
  - [lazydocker](https://github.com/jesseduffield/lazydocker)
  - [skopeo](https://github.com/containers/skopeo): work with remote images registries - retrieving information, images, signing content
- **Infrastructure as Code (IaC)**
  - [terrascan](https://github.com/tenable/terrascan): detect compliance and security violations across Infrastructure as Code to mitigate risk before provisioning cloud native infrastructure
- **Integrated Development Environment (IDE)**
  - [Cursor](https://github.com/getcursor/cursor)
  - [Zed](https://github.com/zed-industries/zed)
- **Shell**
  - **Commands**
    - [ag](https://github.com/ggreer/the_silver_searcher)
    - [atuin](https://github.com/atuinsh/atuin): magical shell history
    - [dust](https://github.com/bootandy/dust): a more intuitive version of du in rust
    - [entr](https://github.com/clibs/entr)
    - [find](https://github.com/sharkdp/fd)
    - [midnight commander](https://github.com/MidnightCommander/mc)
    - [ripgrep](https://github.com/BurntSushi/ripgrep)
    - [thefuck](https://github.com/nvbn/thefuck)
  - **Multiplexer**
    - [tmux](https://github.com/tmux/tmux)
    - [zellij](https://github.com/zellij-org/zellij)
  - **System Info**
    - [fastfetch](https://github.com/fastfetch-cli/fastfetch)
    - [nerdfetch](https://github.com/ThatOneCalculator/NerdFetch)
    - [macchina](https://github.com/Macchina-CLI/macchina)
    - [powertop](https://github.com/fenrus75/powertop)
    - [sampler](https://github.com/sqshq/sampler)
  - **Tools**
    - [Autocomplete](https://github.com/withfig/autocomplete)
    - [Cheat](https://github.com/cheat/cheat)
    - [Clipboard](https://github.com/Slackadays/Clipboard)
    - [cmatrix](https://github.com/abishekvashok/cmatrix)
    - [Espanso](https://github.com/espanso/espanso)
    - [pmd](https://github.com/pmd/pmd): extensible multilanguage static code analyzer
  - **zsh**
    - [zsh-auto-notify](https://github.com/MichaelAquilina/zsh-auto-notify)
- **Version Control**
  - [commitlint](https://github.com/conventional-changelog/commitlint)
  - [delta](https://github.com/dandavison/delta)
  - [difftastic](https://difftastic.wilfred.me.uk)
  - [git-bug](https://github.com/git-bug/git-bug)
  - [git-plan](https://github.com/rorybyrne/git-plan)
  - [git-sim](https://github.com/initialcommit-com/git-sim)
  - [git-xargs](https://github.com/gruntwork-io/git-xargs)
  - [gitflow](https://github.com/nvie/gitflow)
  - [gitmoji-cli](https://github.com/carloscuesta/gitmoji-cli)
  - [mergiraf](https://mergiraf.org)
  - [multi-gitter](https://github.com/lindell/multi-gitter)

### Windows

Here is a list of softwares that could be interesting to integrate into the stack:

- Potentially through Chocolatey:
  - FortiClient VPN
- Independently:
  - [Backblaze](https://www.backblaze.com)
  - ESET antivirus solution
  - Office 365
  - Oracle SQL Developer (Chocolatey package outdated)
  - OracleXE
  - [Zed Encrypt](https://www.zedencrypt.com)
