# dotfiles

Personal dotfiles managed with [chezmoi][1].

## Pre-requisites

I store the below sensitive configuration in my Vaultwarden instance:

 - chezmoi toml configuration file: notes of the item named "chezmoi"
 - private ssh key: attachment of the item named "SSH Key"
 - aws cli configuration: custom fields of the item with the id "223277e3-498b-4d3c-9c0b-fe80e0e83d7b"

## Install on Linux

### Ubuntu

1. Install dependencies, Bitwarden CLI and finally chezmoi:
```bash
# Dependencies
sudo apt update -y
sudo apt install -y curl git jq libsecret-1-0 unzip
# Bitwarden CLI
export BW_VERSION=$(curl -H "Accept: application/vnd.github+json" https://api.github.com/repos/bitwarden/clients/releases | jq  -r 'sort_by(.published_at) | reverse | .[].name | select( index("CLI") )' | sed "s:.*CLI v::" | head -n 1)
curl -L --remote-name "https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-linux-${BW_VERSION}.zip"
sudo unzip -d /usr/local/bin bw-linux-*.zip
sudo chmod +x /usr/local/bin/bw
rm -f bw-linux-*.zip
# chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)"
```

2. Export required environment variables:
```bash
# Update with your server address
export BW_SERVER="https://bw.domain.com"
# Fill the blanks with your API credentials and password
export BW_CLIENTID=""
export BW_CLIENTSECRET=""
export BW_PASSWORD=''
export GITHUB_USERNAME=clement-deltel
```

3. Get chezmoi configuration file from Bitwarden:
```bash
bw config server ${BW_SERVER}
bw login --apikey
export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
mkdir -p ~/.config/chezmoi
bw get notes chezmoi > ~/.config/chezmoi/chezmoi.toml
bw lock
```

4. Initialize the dotfiles:
```bash
export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
chezmoi init --apply ${GITHUB_USERNAME}
bw lock
```

5. After pulling and configuring the dotfiles, chezmoi run a script installing ansible, and then running playbooks.
6. Ansible playbooks automatically install and configure the tools listed below:
    - Package Managers
      - apt
        - [fzf][2]
        - [htop][3]
        - [jq][4]
        - pwgen
        - [vim][5]
        - [xclip][6]
      - [homebrew][7]
    - Shell
      - [eza][8]
      - [Oh My Posh][9]
      - zsh
      - [zoxide][10]
    - Languages
      - Go
      - Python
        - [pipx][11]
        - [poetry][12]
        - [pyenv][13]
    - Orchestration
      - Docker
      - Kubernetes
        - [helm][14]
        - [kubectl][15]
        - [k9s][16]
        - [stern][17]
    - Infrastructure as Code
      - [Pulumi][18]
      - [Terraform][19]
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
docker build --build-arg BW_SERVER --build-arg BW_CLIENTID --build-arg BW_CLIENTSECRET --build-arg BW_PASSWORD --build-arg GITHUB_USERNAME --file docker/linux/Dockerfile --tag dotfiles docker/linux/
docker run --interactive --name dotfiles --tty --rm dotfiles
```

## Shell

Zsh is my default shell. Here is the list of plugins:

- **oh-my-zsh repository**
  - Aliases
    - [aliases]
    - [alias-finder][]
    - [common-aliases][]
  - Cloud
    - [aws][]
  - Configuration Management
    - [ansible][]
    - [chezmoi][]
  - Distro-related
    - [debian][]
  - Infrastructure as Code
    - [terraform][]
  - Languages
    - Go
      - [golang][]
    - Python
      - [pip][]
      - [poetry][]
  - Packages
    - [brew][]
  - Productivity
    - [colored-man-pages][]
    - [colorize][]
    - [command-not-found][]
  - Orchestration
    - [docker][]
    - [docker-compose][]
    - [helm][]
    - [kubectl][]
  - Shell
    - [cp][]
    - [eza][]
    - [fzf][]
    - [history][]
    - [zoxide][]
  - Version Control
    - [git][]
    - [pre-commit][]
- **zsh-users repository**
  - [zsh-completions][]
  - [zsh-autosuggestions][]
  - [zsh-syntax-highlighting][]

Here is my theme: robbyrussell

[1]:https://www.chezmoi.io
[2]:https://github.com/junegunn/fzf
[3]:https://github.com/htop-dev/htop
[4]:https://github.com/jqlang/jq
[5]:https://github.com/vim/vim
[6]:https://github.com/astrand/xclip
[7]:https://github.com/Homebrew/brew
[8]:https://github.com/eza-community/eza
[9]:https://github.com/jandedobbeleer/oh-my-posh
[10]:https://github.com/ajeetdsouza/zoxide
[11]:https://github.com/pypa/pipx
[12]:https://github.com/python-poetry/poetry
[13]:https://github.com/pyenv/pyenv
[14]:https://github.com/helm/helm
[15]:https://github.com/kubernetes/kubectl
[16]:https://github.com/derailed/k9s
[17]:https://github.com/stern/stern
[18]:https://github.com/pulumi/pulumi
[19]:https://github.com/hashicorp/terraform
