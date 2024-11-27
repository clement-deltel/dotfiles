# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io).

## Pre-requisites

I store the below sensitive configuration in my Vaultwarden instance:

 - chezmoi toml configuration file: notes of the item named "chezmoi"
 - private ssh keys: attachments of the item named "SSH Keys"
 - aws cli configuration: custom fields of the item with the id "223277e3-498b-4d3c-9c0b-fe80e0e83d7b"

## Install on Linux

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
curl -fLSs https://raw.githubusercontent.com/clement-deltel/dotfiles/refs/heads/main/docker/linux/install.sh
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
        - [lnav](https://github.com/tstack/lnav)
        - [tldr](https://github.com/tldr-pages/tlrc)
      - [npm](https://github.com/npm/cli)
        - [readme-generator-for-helm](https://github.com/bitnami/readme-generator-for-helm)
    - Shell
      - [eza](https://github.com/eza-community/eza)
      - [Oh My Posh](https://github.com/jandedobbeleer/oh-my-posh)
      - zsh
      - [zoxide](https://github.com/ajeetdsouza/zoxide)
    - Languages
      - Go
      - JavaScript
        - [nodejs](https://github.com/nodejs/node)
      - Python
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
    - Infrastructure as Code
      - [Pulumi](https://github.com/pulumi/pulumi)
      - [Terraform](https://github.com/hashicorp/terraform)
    - Cloud
      - AWS CLI

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

### Shell

Zsh is my default shell. Here is the list of plugins:

- **oh-my-zsh repository**
  - Aliases
    - [aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aliases)
    - [alias-finder](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/alias-finder)
    - [common-aliases](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases)
  - Cloud
    - [aws](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aws)
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
    - [zoxide](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/zoxide)
  - Version Control
    - [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
    - [pre-commit](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/pre-commit)
  - Other
    - [vscode](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vscode)
- **zsh-users repository**
  - [zsh-completions](https://github.com/zsh-users/zsh-completions)
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

Here is my theme: robbyrussell

## Future enhancements

Here is a list of tools that could be interesting and further enhance the stack:

- AI
  - https://github.com/di-sukharev/opencommit
- Infrastructure as Code
  - https://github.com/tenable/terrascan
- Shell
  - Commands
    - btop: https://github.com/aristocratos/btop
    - du: https://github.com/bootandy/dust
    - entr: https://github.com/clibs/entr
    - find: https://github.com/sharkdp/fd
    - midnight commander: https://github.com/MidnightCommander/mc
    - ripgrep: https://github.com/BurntSushi/ripgrep
    - thefuck: https://github.com/nvbn/thefuck
  - System Info:
    - fastfetch: https://github.com/fastfetch-cli/fastfetch
    - nerdfetch: https://github.com/ThatOneCalculator/NerdFetch
    - macchina: https://github.com/Macchina-CLI/macchina
  - Tools
    - Autocomplete: https://github.com/withfig/autocomplete
    - Cheat: https://github.com/cheat/cheat
    - Clipboard: https://github.com/Slackadays/Clipboard
    - cmatrix: https://github.com/abishekvashok/cmatrix
- Version Control
  - https://mergiraf.org
  - https://difftastic.wilfred.me.uk
  - https://github.com/initialcommit-com/git-sim
  - https://github.com/carloscuesta/gitmoji-cli
  - https://github.com/gruntwork-io/git-xargs
  - https://github.com/lindell/multi-gitter
  - https://github.com/conventional-changelog/commitlint
  - https://github.com/dandavison/delta
