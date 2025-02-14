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
  - [Microsoft Windows](#microsoft-windows-1)

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
        - [fzf](https://github.com/junegunn/fzf): command-line fuzzy finder.
        - [git-filter-repo](https://github.com/newren/git-filter-repo): quickly rewrite git repository history (filter-branch replacement).
        - [htop](https://github.com/htop-dev/htop): interactive process viewer.
        - [jq](https://github.com/jqlang/jq): command-line JSON processor.
        - [pdftk](https://www.pdflabs.com/tools/pdftk-server): command-line tool for working with PDFs.
        - pwgen
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

Here is a list of tools that could be interesting and further enhance the stack.

### Linux

- **Artificial Intelligence (AI)**
  - [OpenCommit](https://github.com/di-sukharev/opencommit): generate commit messages by an LLM in 1 sec
- **Containers**
  - [Docker Bench](https://github.com/docker/docker-bench-security): script that checks for dozens of common best-practices around deploying Docker containers in production
  - [dozzle](https://github.com/amir20/dozzle): realtime log viewer for docker containers
  - [skopeo](https://github.com/containers/skopeo): work with remote images registries - retrieving information, images, signing content
- **Docker**
  - new commands (require a Docker account and/or subscription): init, debug, compose watch, build cloud, scout
- **Infrastructure as Code (IaC)**
  - [sst](https://sst.dev): build full-stack apps on your own infrastructure
- **Integrated Development Environment (IDE)**
  - [Cursor](https://github.com/getcursor/cursor)
  - [Zed](https://github.com/zed-industries/zed)
- **Security**
  - [Clair](https://github.com/quay/clair): vulnerability static analysis for containers
  - [Google OSV](https://github.com/google/osv.dev): Open source vulnerability DB and triage service
  - [terrascan](https://github.com/tenable/terrascan): detect compliance and security violations across Infrastructure as Code to mitigate risk before provisioning cloud native infrastructure
- **Shell**
  - **Commands**
    - [ag](https://github.com/ggreer/the_silver_searcher): code-searching tool similar to ack, but faster
    - [atuin](https://github.com/atuinsh/atuin): magical shell history
    - [dust](https://github.com/bootandy/dust): a more intuitive version of du in rust
    - [find](https://github.com/sharkdp/fd): simple, fast and user-friendly alternative to 'find'
    - [midnight commander](https://github.com/MidnightCommander/mc)
    - [ripgrep](https://github.com/BurntSushi/ripgrep): recursively searches directories for a regex pattern while respecting your gitignore
    - [thefuck](https://github.com/nvbn/thefuck): magnificent app which corrects your previous console command
  - **Files**
    - [entr](https://github.com/eradman/entr): run arbitrary commands when files change
    - [yazi](https://github.com/sxyazi/yazi): terminal file manager written in Rust, based on async I/O
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
    - [Autocomplete](https://github.com/withfig/autocomplete): IDE-style autocomplete for your existing terminal & shell
    - [Cheat](https://github.com/cheat/cheat): create and view interactive cheatsheets on the command-line
    - [Clipboard](https://github.com/Slackadays/Clipboard): smart clipboard manager
    - [cmatrix](https://github.com/abishekvashok/cmatrix): terminal based "The Matrix" like implementation
    - [Espanso](https://github.com/espanso/espanso): cross-platform Text Expander written in Rust
    - [pmd](https://github.com/pmd/pmd): extensible multilanguage static code analyzer
  - **zsh**
    - [zsh-auto-notify](https://github.com/MichaelAquilina/zsh-auto-notify)
- **Version Control**
  - [better commits](https://github.com/Everduin94/better-commits): CLI for creating better commits following the conventional commits specification
  - [commitlint](https://github.com/conventional-changelog/commitlint): lint commit messages
  - [delta](https://github.com/dandavison/delta): syntax-highlighting pager for git, diff, grep, and blame output
  - [difftastic](https://difftastic.wilfred.me.uk)
  - [gh-dash](https://github.com/dlvhdr/gh-dash): beautiful CLI dashboard for GitHub
  - [gitbutler](https://github.com/gitbutlerapp/gitbutler): GitButler version control client
  - [gitu](https://github.com/altsem/gitu): TUI git client inspired by Magit
  - [git-bug](https://github.com/git-bug/git-bug): distributed, offline-first bug tracker embedded in git, with bridges
  - [git-plan](https://github.com/rorybyrne/git-plan): a better workflow for git
  - [git-sim](https://github.com/initialcommit-com/git-sim): visually simulate Git operations in your own repos with a single terminal command
  - [git-xargs](https://github.com/gruntwork-io/git-xargs): command-line tool (CLI) for making updates across multiple Github repositories with a single command
  - [gitflow](https://github.com/nvie/gitflow): git extensions to provide high-level repository operations for Vincent Driessen's branching model
  - [gitmoji-cli](https://github.com/carloscuesta/gitmoji-cli): gitmoji interactive cli tool for using emojis on commits
  - [mergiraf](https://mergiraf.org)
  - [multi-gitter](https://github.com/lindell/multi-gitter): update multiple repositories in with one command

### Microsoft Windows

- Through Chocolatey:
  - cinebench
  - cpu-z
  - cpu-z.install
  - forticlientvpn
  - gpu-z
  - msiafterburner
  - occt
  - OpenHardwareMonitor
  - revo-uninstaller
- Independently:
  - [Backblaze](https://www.backblaze.com)
  - [Fan Control](https://getfancontrol.com)
  - [Hardware Monitor](https://www.cpuid.com/softwares/hwmonitor.html)
  - Office 365
  - [Open RGB](https://openrgb.org/)
  - Oracle SQL Developer (Chocolatey package outdated)
  - OracleXE
  - [Zed Encrypt](https://www.zedencrypt.com)
